--Crear un procedimiento almacenado transaccional que realice una operación del sistema, relacionado a subscripciones, pagos, servicios, transacciones o planes, y que dicha operación requiera insertar y/o actualizar al menos 3 tablas.
USE solturaDB;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_RenovarSuscripcionAutomatica')
DROP PROCEDURE dbo.sp_RenovarSuscripcionAutomatica;
GO
CREATE PROCEDURE dbo.sp_RenovarSuscripcionAutomatica
    @userID INT,
    @planPriceID INT,
    @paymentMethodID INT,
    @currencyID INT,
    @resultado BIT OUTPUT,
    @mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @transactionID INT;
    DECLARE @paymentID INT;
    DECLARE @userPlanID INT;
    DECLARE @monto DECIMAL(12,2);
    DECLARE @planID INT;
    DECLARE @nuevoSaldo DECIMAL(10,2) = 0;
    DECLARE @token VARBINARY(255) = CONVERT(VARBINARY(255), 'AUTO_' + CONVERT(VARCHAR(36), NEWID()));
    DECLARE @checksum VARBINARY(250) = CONVERT(VARBINARY(250), HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), GETDATE())));
    DECLARE @refNumber VARCHAR(50) = 'REN-' + CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
    DECLARE @authCode VARCHAR(60) = 'AUTH-' + CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
    DECLARE @randomSubtype INT = CAST(ABS(CHECKSUM(NEWID())) % 5 + 1 AS INT);
	DECLARE @defaultScheduleID INT = (SELECT TOP 1 scheduleID FROM solturaDB.sol_schedules WHERE name = 'Renovación Automática');
        IF @defaultScheduleID IS NULL
    BEGIN
        INSERT INTO solturaDB.sol_schedules (
            name, repit, repetitions, recurrencyType, endDate, startDate
        )
        VALUES (
            'Renovación Automática', 0, 0, 0, DATEADD(YEAR, 10, GETDATE()), GETDATE()
        );
        SET @defaultScheduleID = SCOPE_IDENTITY();
    END
    BEGIN TRY
        BEGIN TRANSACTION;
        SELECT @monto = pp.amount, @planID = pp.planID
        FROM solturaDB.sol_planPrices pp
        WHERE pp.planPriceID = @planPriceID AND pp.[current] = 1;
        IF @monto IS NULL
        BEGIN
            SET @resultado = 0;
            SET @mensaje = 'El plan especificado no existe o no está activo';
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_payments (
            availableMethodID, currency_id, amount, date_pay,
            confirmed, result, auth, reference,
            charge_token, description, error, checksum, methodID
        )
        VALUES (
            @paymentMethodID, @currencyID, @monto, GETDATE(),
            1, 'Renovación automática', @authCode, @refNumber,
            @token, 'Renovación automática', '', @checksum, @paymentMethodID
        );
        SET @paymentID = SCOPE_IDENTITY();
        SELECT @userPlanID = userPlanID 
        FROM solturaDB.sol_userPlans 
        WHERE userID = @userID AND enabled = 1;
        IF @userPlanID IS NOT NULL
        BEGIN
            UPDATE solturaDB.sol_userPlans
            SET planPriceID = @planPriceID,
                scheduleID = @defaultScheduleID, 
                adquisition = GETDATE(),
                enabled = 1
            WHERE userPlanID = @userPlanID;
        END
        ELSE
        BEGIN
            INSERT INTO solturaDB.sol_userPlans (
                userID, planPriceID, scheduleID, adquisition, enabled
            )
            VALUES (
                @userID, @planPriceID, @defaultScheduleID, GETDATE(), 1
            );
            SET @userPlanID = SCOPE_IDENTITY();
        END
        INSERT INTO solturaDB.sol_transactions (
            payment_id, date, postTime, refNumber,
            user_id, checksum, exchangeRate, convertedAmount,
            transactionTypesID, transactionSubtypesID, amount, exchangeCurrencyID
        )
        VALUES (
            @paymentID, GETDATE(), GETDATE(), @refNumber,
            @userID, @checksum, 1.0, @monto,
            1, @randomSubtype, @monto, @currencyID
        );
        SET @transactionID = SCOPE_IDENTITY();
        IF EXISTS (SELECT 1 FROM solturaDB.sol_balances WHERE userID = @userID AND balanceTypeID = 1 AND expirationDate > GETDATE())
        BEGIN
            UPDATE solturaDB.sol_balances
            SET amount = amount - @monto,
                lastUpdate = GETDATE()
            WHERE userID = @userID AND balanceTypeID = 1 AND expirationDate > GETDATE();

            SET @nuevoSaldo = (SELECT amount FROM solturaDB.sol_balances WHERE userID = @userID AND balanceTypeID = 1);
        END
        -- Registrar en logs
        INSERT INTO solturaDB.sol_logs (
            description, postTime, computer, username,
            trace, referenceId1, referenceId2, value1,
            checksum, logSeverityID, logTypesID, logSourcesID
        )
        VALUES (
            'Renovación automática', GETDATE(), HOST_NAME(), SYSTEM_USER,
            '', @userID, @transactionID, CAST(@monto AS VARCHAR(50)),
            @checksum, 1, 3, 1
        );
        COMMIT TRANSACTION;
        SET @resultado = 1;
        SET @mensaje = 'Renovación exitosa. Nuevo saldo: ' + ISNULL(CAST(@nuevoSaldo AS VARCHAR(20)), '0.00');
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @resultado = 0;
        SET @mensaje = 'Error al renovar suscripción: ' + ERROR_MESSAGE();
        INSERT INTO solturaDB.sol_logs (
            description, postTime, computer, username,
            trace, referenceId1, value1, value2,
            checksum, logSeverityID, logTypesID, logSourcesID
        )
        VALUES (
            'Error en renovación automática', GETDATE(), HOST_NAME(), SYSTEM_USER,
            '', @userID, ERROR_MESSAGE(), ERROR_PROCEDURE(),
            @checksum, 3, 3, 1
        );
    END CATCH
END;
GO
DECLARE @resultado BIT, @mensaje VARCHAR(200);
IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_users WHERE userID = 1)
    INSERT INTO solturaDB.sol_users (userID, email, firstName, lastName, password, enabled)
    VALUES (1, 'test@example.com', 'Test', 'User', 0x00, 1);
IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_planPrices WHERE planPriceID = 1)
    INSERT INTO solturaDB.sol_planPrices (planPriceID, planID, amount, currency_id, postTime, "current")
    VALUES (1, 1, 100.00, 1, GETDATE(), 1);

-- ejecucion de procedimiento
EXEC dbo.sp_RenovarSuscripcionAutomatica 
    @userID = 1,
    @planPriceID = 1,
    @paymentMethodID = 1,
    @currencyID = 1,
    @resultado = @resultado OUTPUT,
    @mensaje = @mensaje OUTPUT;
-- resultados
SELECT 
    'Resultado' = CASE WHEN @resultado = 1 THEN 'Éxito' ELSE 'Fallo' END,
    'Mensaje' = @mensaje,
    'Detalles' = 'PagoID: ' + ISNULL((SELECT TOP 1 CAST(paymentID AS VARCHAR) FROM solturaDB.sol_payments ORDER BY paymentID DESC), 'N/A') +
                ', TransID: ' + ISNULL((SELECT TOP 1 CAST(transactionsID AS VARCHAR) FROM solturaDB.sol_transactions ORDER BY transactionsID DESC), 'N/A') +
                ', UserPlan: ' + ISNULL((SELECT TOP 1 CAST(userPlanID AS VARCHAR) FROM solturaDB.sol_userPlans ORDER BY userPlanID DESC), 'N/A');

-- detalles de las tablas afectadas
SELECT TOP 1 
    'Último Pago' = 'ID: ' + CAST(paymentID AS VARCHAR) + 
                   ', Monto: ' + CAST(amount AS VARCHAR) + 
                   ', Método: ' + CAST(methodID AS VARCHAR) + 
                   ', Fecha: ' + CONVERT(VARCHAR, date_pay, 120)
FROM solturaDB.sol_payments 
ORDER BY paymentID DESC;
SELECT TOP 1 
    'Última Transacción' = 'ID: ' + CAST(t.transactionsID AS VARCHAR) + 
                         ', Monto: ' + CAST(t.amount AS VARCHAR) + 
                         ', Tipo: ' + ISNULL(tt.name, 'N/A') + 
                         ', Fecha: ' + CONVERT(VARCHAR, t.date, 120)
FROM solturaDB.sol_transactions t
LEFT JOIN solturaDB.sol_transactionTypes tt ON t.transactionTypesID = tt.transactionTypeID
ORDER BY t.transactionsID DESC;
SELECT TOP 1 
    'UserPlan Actualizado' = 'ID: ' + CAST(up.userPlanID AS VARCHAR) + 
                           ', PlanID: ' + CAST(up.planPriceID AS VARCHAR) + 
                           ', ScheduleID: ' + CAST(up.scheduleID AS VARCHAR) + 
                           ', Estado: ' + CASE WHEN up.enabled = 1 THEN 'Activo' ELSE 'Inactivo' END
FROM solturaDB.sol_userPlans up
ORDER BY up.userPlanID DESC;

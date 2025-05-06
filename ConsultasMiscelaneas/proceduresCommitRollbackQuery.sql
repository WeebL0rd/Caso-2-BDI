USE solturaDB;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarPago
    @AvailableMethodID INT,
    @CurrencyID INT,
    @Amount DECIMAL(10,2),
    @Description NVARCHAR(255),
    @UserID INT,
    @PaymentID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_availablePayMethods WHERE available_method_id = @AvailableMethodID AND userID = @UserID)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Método de pago no disponible para el usuario';
            ROLLBACK;
            RETURN;
        END
        DECLARE @MethodID INT;
        SELECT @MethodID = methodID FROM solturaDB.sol_availablePayMethods WHERE available_method_id = @AvailableMethodID;

        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_payMethod WHERE payMethodID = @MethodID AND enabled = 1)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Método de pago no habilitado';
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_payments (
            availableMethodID, currency_id, amount, date_pay, confirmed,
            result, auth, [reference], charge_token, [description],
            error, checksum, methodID
        )
        VALUES (
            @AvailableMethodID, @CurrencyID, @Amount, GETDATE(), 0,
            'Procesando', NEWID(), 'REF-' + CAST(NEXT VALUE FOR sol_payment_ref_seq AS NVARCHAR(20)),
            CAST('charge_tok_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(255)),
            @Description, NULL,
            CAST('checksum_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(250)),
            @MethodID
        );

        SET @PaymentID = SCOPE_IDENTITY();

        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Pago registrado exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;

        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_RegistrarPago: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ProcesarCompraDeal
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @PaymentID INT;
    DECLARE @CurrencyID INT = 1;
    DECLARE @Amount DECIMAL(10,2);
    DECLARE @PartnerID INT;
    DECLARE @Comision DECIMAL(5,2);
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_deals WHERE dealId = @DealID AND isActive = 1)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Deal no disponible o no activo';
            ROLLBACK;
            RETURN;
        END
        SELECT
            @Amount = fp.finalPrice,
            @PartnerID = d.partnerId,
            @Comision = d.solturaComission
        FROM solturaDB.sol_deals d
        JOIN solturaDB.sol_planFeatures pf ON d.dealId = pf.dealId
        JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID
        WHERE d.dealId = @DealID AND fp."current" = 1;

        DECLARE @DescriptionDeal NVARCHAR(255);
        SET @DescriptionDeal = 'Compra de deal ' + CAST(@DealID AS NVARCHAR);

        EXEC sp_RegistrarPago
            @AvailableMethodID, @CurrencyID, @Amount,
            @DescriptionDeal, @UserID,
            @PaymentID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;

        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_transactions (
            payment_id, date, postTime, refNumber, user_id, checksum,
            exchangeRate, convertedAmount, transactionTypesID,
            transactionSubtypesID, amount, exchangeCurrencyID
        )
        VALUES (
            @PaymentID, GETDATE(), GETDATE(), 'TXN-' + CONVERT(NVARCHAR(20), NEXT VALUE FOR sol_txn_ref_seq),
            @UserID, CAST('checksum_txn_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(250)),
            1.0, @Amount, 1,
            CASE
                WHEN @AvailableMethodID IN (1,4,7,13) THEN 1 -- Tarjeta de crédito
                WHEN @AvailableMethodID IN (2,10,16) THEN 2 -- Transferencia bancaria
                WHEN @AvailableMethodID IN (5,6,12) THEN 3 -- Efectivo
                ELSE 4 
            END,
            @Amount, 1
        );
        SET @TransactionID = SCOPE_IDENTITY();
        DECLARE @ComisionAmount DECIMAL(10,2) = @Amount * (@Comision / 100);

        INSERT INTO solturaDB.sol_balances (
            amount, expirationDate, lastUpdate, balanceTypeID, userId
        )
        VALUES (
            @ComisionAmount, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 1, @UserID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra de deal procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ProcesarCompraDeal: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ComprarDealPremium
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM solturaDB.sol_userPlans up
            JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
            JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
            WHERE up.userID = @UserID
            AND up.enabled = 1
            AND pt.type IN ('Premium', 'Gold - Acceso Total', 'Empresarial Avanzado')
        )
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Usuario no tiene un plan premium para acceder a este deal';
            ROLLBACK;
            RETURN;
        END
        EXEC sp_ProcesarCompraDeal
            @DealID, @UserID, @AvailableMethodID,
            @TransactionID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;
        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        UPDATE solturaDB.sol_payments
        SET confirmed = 1, result = 'Aprobado'
        WHERE paymentID = (
            SELECT payment_id FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra premium procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ComprarDealPremium: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ComprarDealPremium
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM solturaDB.sol_userPlans up
            JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
            JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
            WHERE up.userID = @UserID
            AND up.enabled = 1
            AND pt.type IN ('Premium', 'Gold - Acceso Total', 'Empresarial Avanzado')
        )
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Usuario no tiene un plan premium para acceder a este deal';
            ROLLBACK;
            RETURN;
        END
        EXEC sp_ProcesarCompraDeal
            @DealID, @UserID, @AvailableMethodID,
            @TransactionID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;
        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        UPDATE solturaDB.sol_payments
        SET confirmed = 1, result = 'Aprobado'
        WHERE paymentID = (
            SELECT payment_id FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra premium procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ComprarDealPremium: ' + ERROR_MESSAGE();
    END CATCH
END;
GO



--Probar los procedures -> Esta ejecución fallará, puesto que un usuario con un plan no premiun, intenta acceder a un plan premiun
DECLARE @TransactionID INT, @Exito BIT, @Mensaje NVARCHAR(500);
EXEC sp_ComprarDealPremium 
    @DealID = 1, 
    @UserID = 2, 
    @AvailableMethodID = 2,
    @TransactionID = @TransactionID OUTPUT, 
    @Exito = @Exito OUTPUT, 
    @Mensaje = @Mensaje OUTPUT;
SELECT @Exito AS Exito, @Mensaje AS Mensaje, @TransactionID AS TransactionID;
SELECT * FROM solturaDB.sol_payments WHERE paymentID IN (SELECT payment_id 
														FROM solturaDB.sol_transactions 
														WHERE transactionsID = @TransactionID);
SELECT * FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID;
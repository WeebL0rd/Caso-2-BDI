USE solturaDB
GO

CREATE OR ALTER PROCEDURE sp_PopulateAllTablesWithFormat
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

    DECLARE @constraintName NVARCHAR(128);
    
    SELECT @constraintName = name
    FROM sys.key_constraints
    WHERE parent_object_id = OBJECT_ID('solturaDB.sol_payments')
    AND type = 'UQ';
    
    IF @constraintName IS NOT NULL
    BEGIN
        DECLARE @sql NVARCHAR(MAX) = N'ALTER TABLE solturaDB.sol_payments DROP CONSTRAINT [' + @constraintName + ']';
        EXEC sp_executesql @sql;
        
        PRINT 'Restricción UNIQUE eliminada: ' + @constraintName;
		END
		ELSE
		BEGIN
			PRINT 'No se encontró ninguna restricción UNIQUE en sol_payments.methodID';
		END
    
		COMMIT TRANSACTION;
		PRINT 'Operación completada exitosamente';
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;
			PRINT 'Error al eliminar la restricción UNIQUE: ' + ERROR_MESSAGE();
		END CATCH

		
		INSERT INTO solturaDB.sol_payMethod (payMethodID, name, apiURL, secretKey, [key], logoIconURL, enabled)
		VALUES
		(1, 'Tarjeta de Crédito', 'https://api.payments.com/creditcard', 
		 CAST('AES_Encrypted_Key_123' AS VARBINARY(255)), 
		 'pk_live_123456789', '/assets/icons/credit-card.png', 1),
    
		(2, 'Transferencia Bancaria', 'https://api.payments.com/banktransfer', 
		 CAST('AES_Encrypted_Key_456' AS VARBINARY(255)), 
		 'pk_live_987654321', '/assets/icons/bank-transfer.png', 1),
    
		(3, 'PayPal', 'https://api.payments.com/paypal', 
		 CAST('AES_Encrypted_Key_789' AS VARBINARY(255)), 
		 'pk_live_567891234', '/assets/icons/paypal.png', 1),
    
		(4, 'Sinpe Móvil', 'https://api.payments.com/sinpe', 
		 CAST('AES_Encrypted_Key_321' AS VARBINARY(255)), 
		 'pk_live_432187654', '/assets/icons/mobile-payment.png', 1),
    
		(5, 'Efectivo', 'https://api.payments.com/cash', 
		 CAST('AES_Encrypted_Key_654' AS VARBINARY(255)), 
		 'pk_live_876543219', '/assets/icons/cash.png', 1);


		SET IDENTITY_INSERT solturaDB.sol_availablePayMethods ON;
		INSERT INTO solturaDB.sol_availablePayMethods (available_method_id, name, userID, token, expToken, 
														maskAccount, methodID)
		VALUES
		(1, 'VISA Platinum ****1234', 1, 'tok_visa_1234', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1234', 1),
		(2, 'Cuenta BAC Credomatic', 1, 'tok_bac_5678', DATEADD(YEAR, 6, GETDATE()), '****5678 (BAC)', 2),
		(3, 'PayPal Premium', 2, 'tok_paypal_9012', DATEADD(YEAR, 3, GETDATE()), 'pp_juan', 3),
		(4, 'Mastercard Gold ****4321', 3, 'tok_mc_4321', DATEADD(YEAR, 5, GETDATE()), '****-****-****-4321', 1),
		(5, 'Sinpe Móvil BAC', 3, 'tok_sinpe_8765', DATEADD(YEAR, 12, GETDATE()), '8888-8888 (SINPE)', 4),
		(6, 'Efectivo en Sucursal', 4, 'tok_cash_0000', DATEADD(YEAR, 50, GETDATE()), 'EFECTIVO-001', 5),
		(7, 'VISA Infinite ****1111', 5, 'tok_visa_1111', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1111', 1),
		(8, 'Mastercard Black ****2222', 6, 'tok_mc_2222', DATEADD(YEAR, 5, GETDATE()), '****-****-****-2222', 1),
		(9, 'PayPal Business', 7, 'tok_paypal_biz', DATEADD(YEAR, 3, GETDATE()), 'pp_sofia', 3),
		(10, 'Cuenta BCR', 8, 'tok_bcr_3333', DATEADD(YEAR, 7, GETDATE()), '****3333 (BCR)', 2),
		(11, 'Sinpe Móvil BCR', 9, 'tok_sinpe_bcr', DATEADD(YEAR, 10, GETDATE()), '7777-7777', 4),
		(12, 'Efectivo Express', 10, 'tok_cash_exp', DATEADD(YEAR, 2, GETDATE()), 'EFECTIVO-002', 5),
		(13, 'VISA Signature ****4444', 11, 'tok_visa_4444', DATEADD(YEAR, 4, GETDATE()), '****-****-****-4444', 1),
		(14, 'Mastercard Platinum ****5555', 12, 'tok_mc_5555', DATEADD(YEAR, 5, GETDATE()), '****-****-****-5555', 1),
		(15, 'PayPal Personal', 13, 'tok_paypal_per', DATEADD(YEAR, 3, GETDATE()), 'pp_isabel', 3),
		(16, 'Cuenta Scotiabank', 14, 'tok_scotia_666', DATEADD(YEAR, 6, GETDATE()), '****6666 (Scotia)', 2),
		(17, 'Sinpe Móvil BN', 15, 'tok_sinpe_bn', DATEADD(YEAR, 8, GETDATE()), '6666-6666', 4),
		(18, 'Efectivo VIP', 16, 'tok_cash_vip', DATEADD(YEAR, 3, GETDATE()), 'EFECTIVO-VIP', 5),
		(19, 'VISA Classic ****7777', 17, 'tok_visa_7777', DATEADD(YEAR, 3, GETDATE()), '****-****-****-7777', 1),
		(20, 'Mastercard Standard ****8888', 18, 'tok_mc_8888', DATEADD(YEAR, 4, GETDATE()), '****-****-****-8888', 1),
		(21, 'PayPal Family', 19, 'tok_paypal_fam', DATEADD(YEAR, 2, GETDATE()), 'pp_adriana', 3),
		(22, 'Cuenta Popular', 20, 'tok_popular_999', DATEADD(YEAR, 5, GETDATE()), '****9999 (Popular)', 2),
		(23, 'Sinpe Móvil Popular', 21, 'tok_sinpe_pop', DATEADD(YEAR, 7, GETDATE()), '9999-9999', 4),
		(24, 'Efectivo Rápido', 22, 'tok_cash_fast', DATEADD(YEAR, 1, GETDATE()), 'EFECTIVO-FAST', 5),
		(25, 'VISA Oro ****0000', 23, 'tok_visa_0000', DATEADD(YEAR, 3, GETDATE()), '****-****-****-0000', 1),
		(26, 'Mastercard Oro ****1111', 24, 'tok_mc_1111', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1111', 1),
		(27, 'PayPal Student', 25, 'tok_paypal_std', DATEADD(YEAR, 2, GETDATE()), 'pp_diana', 3),
		(28, 'Cuenta Nacional', 26, 'tok_nacional_222', DATEADD(YEAR, 5, GETDATE()), '****2222 (Nacional)', 2),
		(29, 'Sinpe Móvil Nacional', 27, 'tok_sinpe_nac', DATEADD(YEAR, 6, GETDATE()), '2222-2222', 4),
		(30, 'Efectivo Standard', 28, 'tok_cash_std', DATEADD(YEAR, 2, GETDATE()), 'EFECTIVO-STD', 5);
		SET IDENTITY_INSERT solturaDB.sol_availablePayMethods OFF;
    
		SET IDENTITY_INSERT solturaDB.sol_payments ON;
		INSERT INTO solturaDB.sol_payments (paymentID, availableMethodID, currency_id, amount, date_pay, confirmed, 
		result, auth, [reference], charge_token,[description], error, checksum, methodID)
		VALUES
		(1, 1, 1, 15000.00, GETDATE(), 1, 'Aprobado', 'AUTH123', 'REF-1001', 
		 CAST('charge_tok_123' AS VARBINARY(255)), 'Pago membresía básica', NULL, 
		 CAST('checksum_123' AS VARBINARY(250)), 1),
		(2, 3, 2, 50.00, DATEADD(DAY, -5, GETDATE()), 1, 'Completado', 'AUTH456', 'REF-1002', 
		 CAST('charge_tok_456' AS VARBINARY(255)), 'Pago membresía premium', NULL, 
		 CAST('checksum_456' AS VARBINARY(250)), 3),
		(3, 4, 1, 20000.00, DATEADD(DAY, -2, GETDATE()), 0, 'Procesando', 'AUTH789', 'REF-1003', 
		 CAST('charge_tok_789' AS VARBINARY(255)), 'Pago anual', NULL, 
		 CAST('checksum_789' AS VARBINARY(250)), 4),
		(4, 2, 1, 10000.00, DATEADD(DAY, -7, GETDATE()), 0, 'Rechazado', 'AUTH321', 'REF-1004', 
		 CAST('charge_tok_321' AS VARBINARY(255)), 'Pago servicios adicionales', 'Fondos insuficientes', 
		 CAST('checksum_321' AS VARBINARY(250)), 2),
		(5, 6, 1, 5000.00, DATEADD(DAY, -1, GETDATE()), 1, 'Completado', 'AUTH654', 'REF-1005', 
		 CAST('charge_tok_654' AS VARBINARY(255)), 'Pago en oficina', NULL, 
		 CAST('checksum_654' AS VARBINARY(250)), 5),
		 (6, 7, 2, 75.00, DATEADD(DAY, -10, GETDATE()), 1, 'Aprobado', 'AUTH202', 'REF-1006', 
		 CAST('charge_tok_202' AS VARBINARY(255)), 'Pago corporativo', NULL, 
		 CAST('checksum_202' AS VARBINARY(250)), 1),
    
		(7, 8, 1, 22000.00, DATEADD(DAY, -7, GETDATE()), 1, 'Completado', 'AUTH303', 'REF-1007', 
		 CAST('charge_tok_303' AS VARBINARY(255)), 'Pago anual premium', NULL, 
		 CAST('checksum_303' AS VARBINARY(250)), 1),
    
		(8, 9, 1, 12000.00, DATEADD(DAY, -4, GETDATE()), 1, 'Aprobado', 'AUTH404', 'REF-1008', 
		 CAST('charge_tok_404' AS VARBINARY(255)), 'Pago estudiantil', NULL, 
		 CAST('checksum_404' AS VARBINARY(250)), 3),
    
		(9, 10, 2, 60.00, DATEADD(DAY, -15, GETDATE()), 1, 'Completado', 'AUTH505', 'REF-1009', 
		 CAST('charge_tok_505' AS VARBINARY(255)), 'Pago promocional', NULL, 
		 CAST('checksum_505' AS VARBINARY(250)), 3),
    
		(10, 11, 1, 25000.00, DATEADD(DAY, -20, GETDATE()), 1, 'Aprobado', 'AUTH606', 'REF-1010', 
		 CAST('charge_tok_606' AS VARBINARY(255)), 'Pago gobierno', NULL, 
		 CAST('checksum_606' AS VARBINARY(250)), 2),
    
		(11, 12, 1, 17000.00, DATEADD(DAY, -1, GETDATE()), 0, 'Procesando', 'AUTH707', 'REF-1011', 
		 CAST('charge_tok_707' AS VARBINARY(255)), 'Pago semestral', NULL, 
		 CAST('checksum_707' AS VARBINARY(250)), 1),
    
		(12, 13, 2, 85.00, DATEADD(DAY, -2, GETDATE()), 0, 'Procesando', 'AUTH808', 'REF-1012', 
		 CAST('charge_tok_808' AS VARBINARY(255)), 'Pago internacional', NULL, 
		 CAST('checksum_808' AS VARBINARY(250)), 1),
    
		(13, 14, 1, 19000.00, DATEADD(DAY, -3, GETDATE()), 0, 'Procesando', 'AUTH909', 'REF-1013', 
		 CAST('charge_tok_909' AS VARBINARY(255)), 'Pago empresarial', NULL, 
		 CAST('checksum_909' AS VARBINARY(250)), 2),
    
		(14, 15, 1, 8000.00, DATEADD(DAY, -5, GETDATE()), 0, 'Procesando', 'AUTH010', 'REF-1014', 
		 CAST('charge_tok_010' AS VARBINARY(255)), 'Pago básico', NULL, 
		 CAST('checksum_010' AS VARBINARY(250)), 4),
    
		(15, 16, 2, 45.00, DATEADD(DAY, -8, GETDATE()), 0, 'Procesando', 'AUTH111', 'REF-1015', 
		 CAST('charge_tok_111' AS VARBINARY(255)), 'Pago prueba', NULL, 
		 CAST('checksum_111' AS VARBINARY(250)), 3),
		
		(16, 17, 1, 10000.00, DATEADD(DAY, -7, GETDATE()), 0, 'Rechazado', 'AUTH222', 'REF-1016', 
		 CAST('charge_tok_222' AS VARBINARY(255)), 'Pago servicios', 'Fondos insuficientes', 
		 CAST('checksum_222' AS VARBINARY(250)), 2),
    
		(17, 18, 1, 21000.00, DATEADD(DAY, -10, GETDATE()), 0, 'Rechazado', 'AUTH333', 'REF-1017', 
		 CAST('charge_tok_333' AS VARBINARY(255)), 'Pago anual plus', 'Tarjeta expirada', 
		 CAST('checksum_333' AS VARBINARY(250)), 1),
    
		(18, 19, 2, 55.00, DATEADD(DAY, -12, GETDATE()), 0, 'Rechazado', 'AUTH444', 'REF-1018', 
		 CAST('charge_tok_444' AS VARBINARY(255)), 'Pago membresía', 'Límite excedido', 
		 CAST('checksum_444' AS VARBINARY(250)), 3),
    
		(19, 20, 1, 13000.00, DATEADD(DAY, -15, GETDATE()), 0, 'Rechazado', 'AUTH555', 'REF-1019', 
		 CAST('charge_tok_555' AS VARBINARY(255)), 'Pago familiar', 'Cuenta suspendida', 
		 CAST('checksum_555' AS VARBINARY(250)), 4),
    
		(20, 21, 1, 9000.00, DATEADD(DAY, -18, GETDATE()), 0, 'Rechazado', 'AUTH666', 'REF-1020', 
		 CAST('charge_tok_666' AS VARBINARY(255)), 'Pago estudiantil', 'Autenticación fallida', 
		 CAST('checksum_666' AS VARBINARY(250)), 5),
    
		-- Pagos varios (21-25)
		(21, 22, 2, 65.00, DATEADD(DAY, -22, GETDATE()), 1, 'Completado', 'AUTH777', 'REF-1021', 
		 CAST('charge_tok_777' AS VARBINARY(255)), 'Pago promoción', NULL, 
		 CAST('checksum_777' AS VARBINARY(250)), 3),
    
		(22, 23, 1, 28000.00, DATEADD(DAY, -25, GETDATE()), 1, 'Aprobado', 'AUTH888', 'REF-1022', 
		 CAST('charge_tok_888' AS VARBINARY(255)), 'Pago corporativo plus', NULL, 
		 CAST('checksum_888' AS VARBINARY(250)), 1),
    
		(23, 24, 1, 7500.00, DATEADD(DAY, -30, GETDATE()), 0, 'Reembolsado', 'AUTH999', 'REF-1023', 
		 CAST('charge_tok_999' AS VARBINARY(255)), 'Pago especial', 'Reembolsado por solicitud', 
		 CAST('checksum_999' AS VARBINARY(250)), 2),
    
		(24, 25, 2, 95.00, DATEADD(DAY, -35, GETDATE()), 1, 'Completado', 'AUTH000', 'REF-1024', 
		 CAST('charge_tok_000' AS VARBINARY(255)), 'Pago internacional plus', NULL, 
		 CAST('checksum_000' AS VARBINARY(250)), 1),
    
		(25, 1, 1, 30000.00, DATEADD(DAY, -40, GETDATE()), 1, 'Aprobado', 'AUTH121', 'REF-1025', 
		 CAST('charge_tok_121' AS VARBINARY(255)), 'Pago anual gold', NULL, 
		 CAST('checksum_121' AS VARBINARY(250)), 1);
			SET IDENTITY_INSERT solturaDB.sol_payments OFF;

		SET IDENTITY_INSERT solturaDB.sol_deals ON;
		INSERT INTO solturaDB.sol_deals (dealId,partnerId,dealDescription,sealDate,endDate,solturaComission,discount,isActive)
		VALUES
		(1, 1, 'Promoción de verano: 15% descuento en membresías de gimnasio', 
		 '2023-06-01', '2023-08-31', 15.00, 15.00, 1),
		(2, 2, '2x1 en cines los miércoles', 
		 '2023-05-15', '2023-12-31', 10.00, 50.00, 1),
		(3, 3, '10% de descuento en compras mayores a ₡30,000', 
		 '2023-04-01', '2023-09-30', 12.50, 10.00, 1),
		(4, 4, 'Promoción Black Friday: 20% descuento en todos los servicios', 
		 '2023-11-01', '2023-11-30', 18.00, 20.00, 0), 
		(5, 5, 'Parqueo gratuito los fines de semana', 
		 '2023-07-01', '2024-01-31', 8.00, 100.00, 1),
		(6, 6, 'Combo familiar: 4 entradas + palomitas grandes + 4 bebidas', 
		 '2023-03-01', '2023-12-31', 12.00, 25.00, 1),
		(7, 7, 'Descuento del 15% en pedidos a través de la app', 
		 '2023-05-01', '2023-10-31', 10.00, 15.00, 1),
		(8, 1, 'Paquete deportivo: Gimnasio + Parqueo + Comida saludable', 
		 '2023-06-15', '2023-09-15', 20.00, 25.00, 1),
		(9, 1, 'Promoción de inicio de año: Matrícula gratis', 
		 '2023-01-01', '2023-01-31', 5.00, 100.00, 0),
		(10, 2, 'Descuentos para estudiantes los jueves', 
		 '2023-02-01', '2023-12-31', 7.50, 15.00, 1);
		SET IDENTITY_INSERT solturaDB.sol_deals OFF;
        
		SET IDENTITY_INSERT solturaDB.sol_featureTypes ON;
        INSERT INTO solturaDB.sol_featureTypes (featureTypeID, type)
		VALUES 
		(1, 'Gimnasios'),
		(2, 'Salud'),
		(3, 'Parqueos'),
		(4, 'Entretenimiento'),
		(5, 'Restaurantes'),
		(6, 'Viajes'),
		(7, 'Educación');
		SET IDENTITY_INSERT solturaDB.sol_featureTypes OFF;
		
		SET IDENTITY_INSERT solturaDB.sol_planFeatures ON;
		INSERT INTO solturaDB.sol_planFeatures (planFeatureID,dealId,description,unit,consumableQuantity,enabled,isRecurrent,scheduleID,featureTypeID)
		VALUES
		(1, 1, 'Acceso completo a instalaciones del gimnasio', 'visitas', 30, 1, 1, 1, 1),
		(2, 5, 'Acceso a áreas de parqueo exclusivas', 'horas', 60, 1, 1, 1, 2),
		(3, 1, 'Uso de instalaciones de spa y relajación', 'visitas', 4, 1, 1, 3, 3),
		(4, 1, 'Sesiones de masaje incluidas', 'sesiones', 2, 1, 1, 3, 4),
		(5, 8, 'Acceso a plataforma con entrenadores virtuales', 'sesiones', 12, 1, 1, 2, 5),
		(6, 6, 'Programas recreativos para niños', 'actividades', 8, 1, 1, 2, 6),
		(7, 5, 'Acceso a área de piscina familiar', 'visitas', 15, 1, 1, 1, 7);
		SET IDENTITY_INSERT solturaDB.sol_planFeatures OFF;

		SET IDENTITY_INSERT solturaDB.sol_featuresPerPlans ON;
		INSERT INTO solturaDB.sol_featuresPerPlans (featurePerPlansID,planFeatureID,planID,enabled)
		VALUES
		(1, 1, 1, 1),  
		(2, 2, 1, 1),  
		(3, 3, 1, 0),  
		(4, 1, 3, 1),
		(5, 2, 3, 1),
		(6, 3, 3, 1),  
		(7, 4, 3, 1), 
		(8, 1, 21, 1),
		(9, 5, 21, 1),
		(10, 6, 22, 1),
		(11, 7, 22, 1);
		SET IDENTITY_INSERT solturaDB.sol_featuresPerPlans OFF;
    
		SET IDENTITY_INSERT solturaDB.sol_featurePrices ON;
		INSERT INTO solturaDB.sol_featurePrices (featurePriceID,originalPrice,discountedPrice,finalPrice,currency_id,"current",variable,planFeatureID)
		VALUES
		(1, 15000.00, 13500.00, 13500.00, 1, 1, 0, 1),  
		(2, 5000.00, 5000.00, 5000.00, 1, 1, 0, 2), 
		(3, 20000.00, 18000.00, 18000.00, 1, 1, 0, 3), 
		(4, 10000.00, 10000.00, 10000.00, 1, 1, 1, 4), 
		(5, 30.00, 27.00, 27.00, 2, 1, 0, 1), 
		(6, 10.00, 9.00, 9.00, 2, 1, 0, 2),
		(7, 40.00, 36.00, 36.00, 2, 1, 0, 3), 
		(8, 8000.00, 7200.00, 7200.00, 1, 1, 0, 5), 
		(9, 12000.00, 10000.00, 10000.00, 1, 1, 0, 6), 
		(10, 15000.00, 12000.00, 12000.00, 1, 1, 0, 7);
		SET IDENTITY_INSERT solturaDB.sol_featurePrices OFF;

		SET IDENTITY_INSERT solturaDB.sol_featureAvailableLocations ON;
		INSERT INTO solturaDB.sol_featureAvailableLocations (locationID,featurePerPlanID,partnerAddressId,available)
		VALUES
		(1, 1, 1, 1),  
		(2, 1, 2, 1), 
		(3, 1, 5, 1),  
		(4, 2, 3, 1), 
		(5, 2, 5, 1), 
		(6, 3, 1, 1),
		(7, 10, 4, 1),
		(8, 11, 5, 1);
		SET IDENTITY_INSERT solturaDB.sol_featureAvailableLocations OFF;

        SET IDENTITY_INSERT solturaDB.sol_planTransactionTypes ON;
        INSERT INTO solturaDB.sol_planTransactionTypes (planTransactionTypeID, type)
        VALUES
        (1, 'Activación de plan'),
        (2, 'Renovación de plan'),
        (3, 'Upgrade de plan'),
        (4, 'Cancelación de plan'),
        (5, 'Pago de factura');
        SET IDENTITY_INSERT solturaDB.sol_planTransactionTypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactionTypes ON;
        INSERT INTO solturaDB.sol_transactionTypes (transactionTypeID, name)
        VALUES
        (1, 'Pago'),
        (2, 'Reembolso'),
        (3, 'Ajuste'),
        (4, 'Transferencia'),
        (5, 'Cargo recurrente');
        SET IDENTITY_INSERT solturaDB.sol_transactionTypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes ON;
        INSERT INTO solturaDB.sol_transactionSubtypes (transactionSubtypeID, name)
        VALUES
        (1, 'Tarjeta de crédito'),
        (2, 'Transferencia bancaria'),
        (3, 'Efectivo'),
        (4, 'Wallet digital'),
        (5, 'Pago móvil');
        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_planTransactions ON;
        INSERT INTO solturaDB.sol_planTransactions (planTransactionID,planTransactionTypeID,date,postTime,amount,checksum,userID,associateID,partnerAddressId)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 100.00, 0x123456, 1, 1, 1),
        (2, 2, '2023-02-20', GETDATE(), 120.00, 0x123457, 2, 2, 2),
        (3, 3, '2023-03-10', GETDATE(), 150.00, 0x123458, 3, 3, 3),
        (4, 4, '2023-04-05', GETDATE(), 0.00, 0x123459, 4, 4, NULL),
        (5, 5, '2023-05-12', GETDATE(), 80.00, 0x123460, 5, 5, 5);
        SET IDENTITY_INSERT solturaDB.sol_planTransactions OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactions ON;
        INSERT INTO solturaDB.sol_transactions (transactionsID,payment_id,date,postTime,refNumber,user_id, checksum,exchangeRate,convertedAmount,
												transactionTypesID,transactionSubtypesID,amount,exchangeCurrencyID)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 'INV-001', 1, 0x654321, 1.0, 100.00, 1, 1, 100.00, 1),
        (2, 2, '2023-02-20', GETDATE(), 'INV-002', 2, 0x654322, 555.556, 55555.60, 1, 2, 100.00, 2),
        (3, 3, '2023-03-10', GETDATE(), 'INV-003', 3, 0x654323, 17.5, 1750.00, 1, 3, 100.00, 1),
        (4, 4, '2023-04-05', GETDATE(), 'RFND-001', 4, 0x654324, 555.556, 5555.56, 2, 4, 10.00, 2),
        (5, 5, '2023-05-12', GETDATE(), 'ADJ-001', 5, 0x654325, 1.0, 50.00, 3, 4, 50.00, 1);
        SET IDENTITY_INSERT solturaDB.sol_transactions OFF;

		SET IDENTITY_INSERT solturaDB.sol_balances ON;
		INSERT INTO solturaDB.sol_balances (balanceID,amount,expirationDate,lastUpdate,balanceTypeID,planFeatureID,userId)
		VALUES
		(1, 15000.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 1, 1, 1),
		(2, 12000.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 3, 2),
		(3, 18000.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 2, 3),
		(4, 9000.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 3, 5, 4),
		(5, 21000.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 6, 5),
		(6, 7500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 2, 4, 6),
		(7, 16500.00, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 4, 7, 7),
		(8, 13500.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 1, 7, 8),
		(9, 19500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 2, 3, 9),
		(10, 10500.00, DATEADD(MONTH, 5, GETDATE()), GETDATE(), 1, 1, 10),
		(11, 22500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 11),
		(12, 8500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 4, 12),
		(13, 17500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 2, 13),
		(14, 11500.00, DATEADD(MONTH, 7, GETDATE()), GETDATE(), 4, 7, 14),
		(15, 24500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 6, 15),
		(16, 9500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 2, 3, 16),
		(17, 15500.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 1, 2, 17),
		(18, 20500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 18),
		(19, 12500.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 2, 4, 19),
		(20, 18500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 1, 20),
		(21, 6500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 4, 7, 21),
		(22, 23500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 2, 22),
		(23, 14500.00, DATEADD(MONTH, 5, GETDATE()), GETDATE(), 2, 3, 23),
		(24, 9500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 1, 6, 24),
		(25, 21500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 25),
		(26, 13500.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 1, 1, 26),
		(27, 17500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 2, 4, 27),
		(28, 10500.00, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 4, 7, 28),
		(29, 25500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 1, 29),
		(30, 8500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 3, 30);
		SET IDENTITY_INSERT solturaDB.sol_balances OFF;

        COMMIT TRANSACTION;
        PRINT 'Todas las tablas fueron pobladas exitosamente con el formato solicitado';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar las tablas: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
EXEC sp_PopulateAllTablesWithFormat;









USE solturaDB
GO

CREATE OR ALTER PROCEDURE sp_PopulateAllTablesWithFormat
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
;
		
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
		INSERT INTO solturaDB.sol_availablePayMethods (available_method_id, name, userID, token, expToken, maskAccount, methodID)
		VALUES
		(1, 'VISA ****1234', 1, 'tok_visa_1234', DATEADD(YEAR, 3, GETDATE()), '****1234', 1),
		(2, 'Cuenta BAC', 1, 'tok_bac_5678', DATEADD(YEAR, 5, GETDATE()), '****5678', 2),
		(3, 'PayPal Personal', 2, 'tok_paypal_9012', DATEADD(YEAR, 2, GETDATE()), 'user@example.com', 3),
		(4, 'Mastercard ****4321', 3, 'tok_mc_4321', DATEADD(YEAR, 4, GETDATE()), '****4321', 1),
		(5, 'Sinpe Móvil', 3, 'tok_sinpe_8765', DATEADD(YEAR, 10, GETDATE()), '8888-8888', 4),
		(6, 'Efectivo', 4, 'tok_cash_0000', DATEADD(YEAR, 100, GETDATE()), 'Pago en Oficina', 5);
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
		 CAST('checksum_654' AS VARBINARY(250)), 5);
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

        -- 2. Tipos de transacción general
        SET IDENTITY_INSERT solturaDB.sol_transactionTypes ON;
        INSERT INTO solturaDB.sol_transactionTypes (transactionTypeID, name)
        VALUES
        (1, 'Pago'),
        (2, 'Reembolso'),
        (3, 'Ajuste'),
        (4, 'Transferencia'),
        (5, 'Cargo recurrente');
        SET IDENTITY_INSERT solturaDB.sol_transactionTypes OFF;

        -- 3. Subtipos de transacción
        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes ON;
        INSERT INTO solturaDB.sol_transactionSubtypes (transactionSubtypeID, name)
        VALUES
        (1, 'Tarjeta de crédito'),
        (2, 'Transferencia bancaria'),
        (3, 'Efectivo'),
        (4, 'Wallet digital'),
        (5, 'Pago móvil');
        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes OFF;

        -- 4. Transacciones de plan
        SET IDENTITY_INSERT solturaDB.sol_planTransactions ON;
        INSERT INTO solturaDB.sol_planTransactions (planTransactionID,planTransactionTypeID,date,postTime,amount,checksum,userID,associateID,partnerAddressId)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 100.00, 0x123456, 1, 1, 1),
        (2, 2, '2023-02-20', GETDATE(), 120.00, 0x123457, 2, 2, 2),
        (3, 3, '2023-03-10', GETDATE(), 150.00, 0x123458, 3, 3, 3),
        (4, 4, '2023-04-05', GETDATE(), 0.00, 0x123459, 4, 4, NULL),
        (5, 5, '2023-05-12', GETDATE(), 80.00, 0x123460, 5, 5, 5);
        SET IDENTITY_INSERT solturaDB.sol_planTransactions OFF;

        -- 5. Transacciones generales
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

        COMMIT TRANSACTION;
        PRINT 'Todas las tablas fueron pobladas exitosamente con el formato solicitado';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar las tablas: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Ejecutar el procedimiento
EXEC sp_PopulateAllTablesWithFormat;
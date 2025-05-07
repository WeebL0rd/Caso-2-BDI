-- 3. Uso de un trigger (por ejemplo, para log de inserciones en pagos).
USE solturaDB;
GO
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN computer NVARCHAR(75) NULL;
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN trace NVARCHAR(100) NULL;
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN checksum varbinary(250) NULL;
GO
CREATE OR ALTER TRIGGER tr_log_payment_insert_3
ON solturaDB.sol_payments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO solturaDB.sol_logs (
        description, 
        postTime, 
        computer, 
        username, 
        trace, 
        referenceId1, 
        value1, 
        checksum, 
        logSeverityID, 
        logTypesID, 
        logSourcesID
    )
    SELECT 
        'Nuevo pago - Monto: ' + CAST(ISNULL(i.amount, 0) AS VARCHAR) + ' ' + 
        ISNULL((SELECT TOP 1 acronym FROM solturaDB.sol_currencies WHERE currency_id = i.currency_id ORDER BY currency_id), 'UNK'),
        GETDATE(),
        ISNULL(HOST_NAME(), 'UNKNOWN'),
        ISNULL(SYSTEM_USER, 'system'),
        'PAYMENT_INSERT',
        i.paymentID,
        'M�todo: ' + ISNULL((SELECT TOP 1 name FROM solturaDB.sol_availablePayMethods 
            WHERE available_method_id = i.availableMethodID ORDER BY available_method_id), 'DESCONOCIDO'),
        HASHBYTES('SHA2_256', CAST(i.paymentID AS NVARCHAR(50)) + CAST(ISNULL(i.amount, 0) AS NVARCHAR(20))),
        ISNULL((SELECT TOP 1 logSererityID FROM solturaDB.sol_logsSererity WHERE name = 'Info' ORDER BY logSererityID), 1),
        ISNULL((SELECT TOP 1 logTypesID FROM solturaDB.sol_logTypes WHERE name = 'Payment' ORDER BY logTypesID), 1),
        ISNULL((SELECT TOP 1 logSourcesID FROM solturaDB.sol_logSources WHERE name = 'PaymentSystem' ORDER BY logSourcesID), 1)
    FROM inserted i;
END;
GO

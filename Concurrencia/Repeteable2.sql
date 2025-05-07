USE solturaDB;
GO

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
GO


WAITFOR DELAY '00:00:02';
GO

BEGIN TRANSACTION;

INSERT INTO SolturaDB.sol_transactions
  (payment_id, date, postTime, refNumber, user_id, checksum, exchangeRate, convertedAmount, transactionTypesID, transactionSubtypesID, amount, exchangeCurrencyID)
VALUES
  (1, GETDATE(), GETDATE(), 'INV-100', 5, CAST('tokentest3' AS VARBINARY(255)), 1.0, 100.00, 1, 1, 100.00, 1),
  (1, GETDATE(), GETDATE(), 'INV-101', 5, CAST('tokentest4' AS VARBINARY(255)), 1.0,  50.00, 1, 1,  50.00, 1);

COMMIT;
GO

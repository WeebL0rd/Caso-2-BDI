BEGIN TRANSACTION;
UPDATE solturaDB.sol_users SET firstName = 'nuevoNombre' WHERE userID = 1;
WAITFOR DELAY '00:00:03';
UPDATE solturaDB.sol_payments SET amount = amount + 100 WHERE paymentID = 1;
WAITFOR DELAY '00:00:03';
SELECT * FROM solturaDB.sol_balances WHERE userID = 1;
COMMIT TRANSACTION;
BEGIN TRANSACTION;
UPDATE solturaDB.sol_balances SET amount = amount + 400 WHERE balanceID = 2;
WAITFOR DELAY '00:00:03';
SELECT * FROM solturaDB.sol_payments WHERE paymentID = 3;
WAITFOR DELAY '00:00:03';
UPDATE solturaDB.sol_users SET firstName = 'Nombre2' WHERE userID = 2;
COMMIT TRANSACTION;
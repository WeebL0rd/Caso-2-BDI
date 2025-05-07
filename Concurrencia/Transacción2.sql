BEGIN TRANSACTION;
UPDATE solturaDB.sol_payments SET amount = amount + 200 WHERE paymentID = 2;
WAITFOR DELAY '00:00:03';
UPDATE solturaDB.sol_balances SET amount = amount + 300 WHERE balanceID = 1;
WAITFOR DELAY '00:00:03';
SELECT * FROM solturaDB.sol_users WHERE userID = 1;
COMMIT TRANSACTION;
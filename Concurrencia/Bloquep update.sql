USE solturaDB;
UPDATE solturaDB.sol_payments
SET result = 'Forzado'
WHERE paymentID = 3;
SELECT * FROM solturaDB.sol_payments

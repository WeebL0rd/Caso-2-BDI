USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN;

SELECT SUM(amount) AS total_consumos
  FROM SolturaDB.sol_transactions
  WHERE user_id = 5;               

WAITFOR DELAY '00:00:05';         

SELECT SUM(amount) AS total_consumos
  FROM SolturaDB.sol_transactions
  WHERE user_id = 5;             

COMMIT;

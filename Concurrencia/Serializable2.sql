USE solturaDB;
GO


WAITFOR DELAY '00:00:02';

BEGIN TRAN;
UPDATE solturaDB.sol_planPrices
   SET amount = amount * 1.10
 WHERE planID = 3;               
COMMIT;

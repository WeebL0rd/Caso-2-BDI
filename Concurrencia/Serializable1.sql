USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN;

SELECT planPriceID, amount
  FROM solturaDB.sol_planPrices
  WHERE planID = 3;              

WAITFOR DELAY '00:00:10';        

SELECT planPriceID, amount
  FROM solturaDB.sol_planPrices
  WHERE planID = 3;             

COMMIT;

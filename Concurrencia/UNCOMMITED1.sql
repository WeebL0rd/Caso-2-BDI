
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRANSACTION;

SELECT exchangeCurrencyID, exchange_rate
FROM solturaDB.sol_exchangeCurrencies
WHERE sourceID = 1 AND destinyID = 2;


WAITFOR DELAY '00:00:05';  -- Espera a que Sesión B actualice y NO haga COMMIT

-- podría ver el valor nuevo aunque Sesión B no haya hecho COMMIT
SELECT exchangeCurrencyID, exchange_rate
FROM solturaDB.sol_exchangeCurrencies
WHERE sourceID = 1 AND destinyID = 2;

COMMIT;

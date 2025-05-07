-- Sesi�n B
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
BEGIN TRANSACTION;

-- Actualiza la tasa de cambio
UPDATE solturaDB.sol_exchangeCurrencies
SET exchange_rate = 0.0020
WHERE sourceID = 1 AND destinyID = 2;

WAITFOR DELAY '00:00:10';  -- dura m�s que la espera de Sesi�n A

ROLLBACK; 

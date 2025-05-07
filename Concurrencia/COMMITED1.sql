
USE solturaDB;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

-- Primera lectura del conteo de pagos
SELECT COUNT(*) AS total_pagos
FROM SolturaDB.sol_payments;
-- Sup�n que devuelve 100

WAITFOR DELAY '00:00:05';  -- durante este tiempo Sesi�n B inserta nuevos pagos y COMMIT

-- Segunda lectura del mismo conteo
SELECT COUNT(*) AS total_pagos
FROM SolturaDB.sol_payments;


COMMIT;

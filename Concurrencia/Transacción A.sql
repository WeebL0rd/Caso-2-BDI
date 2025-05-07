BEGIN TRANSACTION;

-- Simular un SELECT en la primera tabla
SELECT * FROM solturaDB.sol_countries
WHERE name = 'Costa Rica Actualizado';

-- Esperar para simular alta concurrencia
WAITFOR DELAY '00:00:10';

-- Intentar actualizar la segunda tabla
UPDATE solturaDB.sol_states
SET name = 'San José '
WHERE name = 'San José Actualizado';

COMMIT;


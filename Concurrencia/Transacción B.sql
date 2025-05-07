BEGIN TRANSACTION;

-- Simular un SELECT en la segunda tabla
SELECT * FROM solturaDB.sol_states
WHERE name = 'San José';

-- Esperar para simular alta concurrencia
WAITFOR DELAY '00:00:10';

-- Intentar actualizar la primera tabla
UPDATE solturaDB.sol_countries
SET name = 'Costa Rica '
WHERE name = 'Costa Rica Actualizado';

COMMIT;


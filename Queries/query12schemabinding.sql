USE solturaDB;
GO

-- 1. Creación de la vista con SCHEMABINDING
IF OBJECT_ID('vw_member_subscriptions', 'V') IS NOT NULL
    DROP VIEW vw_member_subscriptions;
GO

CREATE VIEW vw_member_subscriptions
WITH SCHEMABINDING
AS
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    u.email,
    COUNT_BIG(*) AS subscription_count,
    SUM(CAST(pp.amount AS DECIMAL(10,2))) AS monthly_cost,
    MAX(up.adquisition) AS last_subscription_date
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_plans p ON pp.planID = p.planID
WHERE up.enabled = 1 AND pp.[current] = 1
GROUP BY u.userID, u.firstName, u.lastName, u.email;
GO

-- 2. Demostración de que SCHEMABINDING funciona
PRINT '=== PRUEBA DE SCHEMABINDING ===';
PRINT 'Intentando modificar una columna referenciada...';
GO

BEGIN TRY
    -- Intentar modificar una columna referenciada en la vista
    ALTER TABLE solturaDB.sol_users ALTER COLUMN firstName NVARCHAR(100);
    PRINT 'ERROR: SCHEMABINDING no está funcionando (se permitió la modificación)';
END TRY
BEGIN CATCH
    PRINT 'SCHEMABINDING funciona correctamente:';
    PRINT 'Error: ' + ERROR_MESSAGE()  + '     <<<<<<<    prueba que el schemabinding funciona bien';
END CATCH;
GO

-- 3. Consulta para verificar la vista
PRINT 'Vista en results table';
SELECT TOP 5 * FROM vw_member_subscriptions;
GO
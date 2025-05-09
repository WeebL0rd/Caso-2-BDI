--12. SCHEMABINDING demostrar que efectivamente funciona en SPs, vistas, funciones.
USE solturaDB;
GO
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

PRINT 'PRUEBA DE SCHEMABINDING ';
PRINT 'Intentando modificar una columna referenciada...';
GO
BEGIN TRY
    ALTER TABLE solturaDB.sol_users ALTER COLUMN firstName NVARCHAR(100);
    PRINT 'ERROR: SCHEMABINDING no est� funcionando (se permiti� la modificaci�n)';
END TRY
BEGIN CATCH
    PRINT 'SCHEMABINDING funciona correctamente:';
    PRINT 'Error: ' + ERROR_MESSAGE()  + '     <<<<<<<    prueba que el schemabinding funciona bien';
END CATCH;
GO
PRINT 'Vista en results table';
SELECT TOP 5 * FROM vw_member_subscriptions;
GO
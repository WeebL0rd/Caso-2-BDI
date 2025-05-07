--Crear una vista indexada con al menos 4 tablas (ej. usuarios, suscripciones, pagos, servicios). La vista debe ser din�mica, no una vista materializada con datos est�ticos. Demuestre que si es din�mica.
USE solturaDB;
GO
-- crea la vista con SCHEMABINDING
IF OBJECT_ID('dbo.vw_user_subscription_details', 'V') IS NOT NULL
    DROP VIEW dbo.vw_user_subscription_details;
GO
CREATE VIEW dbo.vw_user_subscription_details
WITH SCHEMABINDING
AS
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    u.email,
    p.planID,
    p.description AS planName,
    pt.type AS planType,
    pp.amount AS monthlyPrice,
    pp.planPriceID,
    up.userPlanID,
    p.planTypeID
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_plans p ON pp.planID = p.planID
JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
WHERE up.enabled = 1 AND pp.[current] = 1;
GO
CREATE UNIQUE CLUSTERED INDEX IX_vw_user_subscription_details       --aqui la indexaci�n
ON dbo.vw_user_subscription_details (userID, planID);
GO
IF OBJECT_ID('dbo.vw_user_subscription_aggregates', 'V') IS NOT NULL
    DROP VIEW dbo.vw_user_subscription_aggregates;
GO
CREATE VIEW dbo.vw_user_subscription_aggregates
AS
SELECT 
    v.userID,
    v.firstName + ' ' + v.lastName AS fullName,
    v.planName,
    v.planType,
    v.monthlyPrice,
    COUNT(fpp.featurePerPlansID) AS featureCount,
    SUM(CAST(fp.finalPrice AS DECIMAL(10,2))) AS totalFeatureValue
FROM dbo.vw_user_subscription_details v
JOIN solturaDB.sol_featuresPerPlans fpp ON v.planID = fpp.planID
JOIN solturaDB.sol_planFeatures pf ON fpp.planFeatureID = pf.planFeatureID
JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID AND fp.[current] = 1
GROUP BY v.userID, v.firstName, v.lastName, v.planName, v.planType, v.monthlyPrice;
GO
BEGIN TRANSACTION;
SELECT TOP 1 firstName, lastName, planName, monthlyPrice 
FROM dbo.vw_user_subscription_details 
WHERE userID = 1;
UPDATE solturaDB.sol_planPrices 
SET amount = amount * 1.1 -- Aumento del 10%
WHERE planPriceID IN (SELECT planPriceID FROM solturaDB.sol_userPlans WHERE userID = 1);
-- Ver cambios en la vista
SELECT TOP 1 firstName, lastName, planName, monthlyPrice 
FROM dbo.vw_user_subscription_details 
WHERE userID = 1;
ROLLBACK TRANSACTION; -- Revertir cambios de demostraci�n
-- Consultas de ejemplo usando la vista indexada
SELECT 
    planType,
    COUNT(DISTINCT userID) AS totalUsers,
    AVG(monthlyPrice) AS avgMonthlyPrice
FROM dbo.vw_user_subscription_details
GROUP BY planType
ORDER BY totalUsers DESC;
-- usando la vista de agregados
SELECT 
    planType,
    COUNT(DISTINCT userID) AS totalUsers,
    AVG(totalFeatureValue) AS avgFeatureValue
FROM dbo.vw_user_subscription_aggregates
GROUP BY planType
ORDER BY totalUsers DESC;
-- 16. DISTINCT para evitar duplicados en servicios asignados por ejemplo.
USE solturaDB;
GO
SELECT DISTINCT
    pf.planFeatureID,
    pf.description AS feature,
    ft.type AS feature_type,
    fp.finalPrice AS base_price
FROM solturaDB.sol_planFeatures pf
JOIN solturaDB.sol_featureTypes ft ON pf.featureTypeID = ft.featureTypeID
JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID AND fp."current" = 1
JOIN solturaDB.sol_featuresPerPlans fpp ON pf.planFeatureID = fpp.planFeatureID
JOIN solturaDB.sol_plans p ON fpp.planID = p.planID
WHERE pf.enabled = 1
ORDER BY feature_type, feature;
GO

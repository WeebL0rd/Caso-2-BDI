--Uso de MERGE para sincronizar datos de planes por ejemplo.
USE solturaDB;
GO
SET IDENTITY_INSERT solturaDB.sol_plans ON
-- Ejemplo con datos de planes personales y familiares
MERGE INTO solturaDB.sol_plans AS target
USING (
    SELECT 21 AS planID, 'Joven Deportista' AS description, 5 AS planTypeID UNION ALL
    SELECT 11, 'Full Modern Family', 4 UNION ALL
	SELECT 12, 'Profesional Joven', 4 UNION ALL
    SELECT 22, 'Familia de Verano', 4 UNION ALL
    SELECT 23, 'Viajero Frecuente', 6 UNION ALL
	SELECT 30, 'Plan Ciudadano de Oro', 15 UNION ALL
    SELECT 24, 'Nómada Digital', 6

) AS source
ON target.planID = source.planID
WHEN MATCHED AND (target.description <> source.description OR target.planTypeID <> source.planTypeID) THEN
    UPDATE SET 
        target.description = source.description,
        target.planTypeID = source.planTypeID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (planID, description, planTypeID)
    VALUES (source.planID, source.description, source.planTypeID);
SET IDENTITY_INSERT solturaDB.sol_plans OFF
SELECT planID, description, planTypeID 
FROM solturaDB.sol_plans
ORDER BY planID;
GO
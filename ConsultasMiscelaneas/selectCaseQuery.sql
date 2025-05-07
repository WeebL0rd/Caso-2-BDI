--Escribir un SELECT que use CASE para crear una columna calculada que agrupe din�micamente datos (por ejemplo, agrupar cantidades de usuarios por plan en rangos de monto, no use este ejemplo).USE solturaDB;
-- Clasificaci�n de usuarios por antig�edad (usando datos reales de las tablas)
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    u.email,
    up.adquisition AS fechaAdquisicion,
    DATEDIFF(MONTH, up.adquisition, GETDATE()) AS mesesActivo,
    CASE 
        WHEN DATEDIFF(MONTH, up.adquisition, GETDATE()) < 6 THEN 'Nuevo (0-6 meses)'
        WHEN DATEDIFF(MONTH, up.adquisition, GETDATE()) BETWEEN 6 AND 12 THEN 'Intermedio (6-12 meses)'
        WHEN DATEDIFF(MONTH, up.adquisition, GETDATE()) BETWEEN 13 AND 24 THEN 'Avanzado (1-2 a�os)'
        ELSE 'Experto (+2 a�os)'
    END AS segmentoAntiguedad
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
WHERE up.enabled = 1
ORDER BY mesesActivo DESC;

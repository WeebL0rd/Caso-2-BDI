Use solturaDB
-- Primero, esta es la consulta con JOIN
SELECT 
    u.userID, 
    u.firstName + ' ' + u.lastName AS fullName,
    u.email, 
    up.adquisition, 
    up.enabled
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID;

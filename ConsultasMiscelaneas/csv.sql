USE solturaDB;
GO

SELECT
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    u.email,
    up.adquisition,
    up.enabled
FROM solturaDB.sol_users      AS u
JOIN solturaDB.sol_userPlans AS up
  ON u.userID = up.userID;

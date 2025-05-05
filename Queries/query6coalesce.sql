--6.COALESCE para manejar valores nulos en configuraciones de usuario.
USE solturaDB;
GO
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    COALESCE(up.enabled, 1) AS notifications_enabled,
    COALESCE(nc.settings, '{"alert":true,"email":true,"push":true}') AS notification_settings,
    COALESCE((
        SELECT TOP 1 channel 
        FROM solturaDB.sol_communicationChannels 
        WHERE communicationChannelID = nc.communicationChannelID
    ), 'Email') AS default_channel
FROM solturaDB.sol_users u
LEFT JOIN solturaDB.sol_userPermissions up ON u.userID = up.userID AND up.permissionID = 5
LEFT JOIN solturaDB.sol_notificationConfigurations nc ON u.userID = nc.userID;
GO
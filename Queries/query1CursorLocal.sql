-- 1. Cursor local, mostrando que no es visible fuera de la sesi�n de la base de datos
USE solturaDB;
GO
DECLARE @userID INT, @userName NVARCHAR(100);
--crea el cursor local 
DECLARE user_cursor_local CURSOR LOCAL FOR
SELECT userID, firstName + ' ' + lastName
FROM solturaDB.sol_users
WHERE enabled = 1 AND userID BETWEEN 1 AND 4  -- Filtramos para obtener exactamente los 4 usuarios mostrados
ORDER BY userID;
OPEN user_cursor_local;
FETCH NEXT FROM user_cursor_local INTO @userID, @userName;
PRINT 'Procesando usuarios con cursor LOCAL:';
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '  Usuario ' + CAST(@userID AS VARCHAR) + ': ' + @userName;
    FETCH NEXT FROM user_cursor_local INTO @userID, @userName;
END
-- Verificaci�n en la misma sesi�n
PRINT 'Cursor local dejado abierto para demostraci�n';
IF CURSOR_STATUS('local','user_cursor_local') = 1
    PRINT '  (Verificaci�n: Cursor visible en esta sesi�n)';
ELSE
    PRINT '  (Error: Cursor no visible en su propia sesi�n)';
-- No cerramos el cursor para la demostraci�n
GO
-- intento de acceder al cursor de otra sesi�n
PRINT 'Intento de acceder al cursor desde otra sesi�n';
BEGIN TRY
    DECLARE @testID INT, @testName NVARCHAR(100);
    FETCH NEXT FROM user_cursor_local INTO @testID, @testName;
    PRINT 'ERROR: El cursor es visible en otra sesi�n';
END TRY
BEGIN CATCH
    PRINT 'Demostraci�n exitosa:';
    PRINT '  Error: ' + ERROR_MESSAGE();
    PRINT '  Esto prueba que el cursor LOCAL no es visible fuera de su sesi�n original';
END CATCH;
GO
BEGIN TRY             --aqui si cerramos el cursor
    CLOSE user_cursor_local;
    DEALLOCATE user_cursor_local;
END TRY
BEGIN CATCH
END CATCH;
GO
--2. Cursor global, accesible desde otras sesiones de la base de datos
USE solturaDB;
GO
PRINT 'SESI�N 1';
PRINT 'Creando cursor GLOBAL...';
DECLARE @planID INT, @planName VARCHAR(100);
DECLARE plan_cursor_global CURSOR GLOBAL FOR
SELECT planID, description 
FROM solturaDB.sol_plans 
ORDER BY planID;
OPEN plan_cursor_global;
FETCH NEXT FROM plan_cursor_global INTO @planID, @planName;
PRINT 'Procesando planes con cursor GLOBAL:';
WHILE @@FETCH_STATUS = 0 AND @planID < 5  -- Limite para demostraci�n
BEGIN
    PRINT '  Plan ' + CAST(@planID AS VARCHAR) + ': ' + @planName;
    FETCH NEXT FROM plan_cursor_global INTO @planID, @planName;
END
PRINT 'Cursor global dejado abierto para acceso desde otras sesiones';
GO
PRINT 'SESI�N 2';
PRINT 'Accediendo al cursor GLOBAL desde otra sesi�n...';
BEGIN TRY
    DECLARE @currentPlanID INT, @currentPlanName VARCHAR(100);
    FETCH NEXT FROM plan_cursor_global INTO @currentPlanID, @currentPlanName;
    PRINT 'Continuando procesamiento desde otra sesi�n:';
    WHILE @@FETCH_STATUS = 0 AND @currentPlanID < 10  -- Nuevo l�mite
    BEGIN
        PRINT '  Plan ' + CAST(@currentPlanID AS VARCHAR) + ': ' + @currentPlanName;
        FETCH NEXT FROM plan_cursor_global INTO @currentPlanID, @currentPlanName;
    END
    PRINT 'Procesamiento completado en sesi�n 2';
END TRY
BEGIN CATCH
    PRINT 'Error al acceder al cursor: ' + ERROR_MESSAGE();
END CATCH;
-- Cerrar cursor
CLOSE plan_cursor_global;
DEALLOCATE plan_cursor_global;
GO
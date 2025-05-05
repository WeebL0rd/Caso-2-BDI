-- 13. WITH ENCRYPTION demostrar que es posible encriptar un SP y que no lo violenten.    
-- 14. EXECUTE AS para ejecutar SP con impersonificación, es posible? qué significa eso
--muchos comentarios por que me costo entenderlo hasta a mi :(
USE solturaDB;
GO
-- Tbabla de ejemplos
IF OBJECT_ID('sol_payments', 'U') IS NOT NULL DROP TABLE sol_payments;
GO
CREATE TABLE sol_payments (
    id INT IDENTITY(1,1),
    confirmed BIT
);
GO
INSERT INTO sol_payments (confirmed)
VALUES (0), (1), (0), (1), (0);
GO
--  Crea usuario (para impersonificación)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'app_executor')
    CREATE USER app_executor WITHOUT LOGIN;
GO
-- Otorgar permisos limitados a la tabla creada
GRANT SELECT ON dbo.sol_payments TO app_executor;
GO
-- procedimiento con encriptación y impersonificación
IF OBJECT_ID('sp_demo_secure', 'P') IS NOT NULL DROP PROCEDURE sp_demo_secure;
GO
CREATE PROCEDURE sp_demo_secure
WITH ENCRYPTION, EXECUTE AS 'app_executor'
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @pendientes INT;
    SELECT @pendientes = COUNT(*) FROM sol_payments WHERE confirmed = 0;
    PRINT 'Pagos pendientes: ' + CAST(@pendientes AS VARCHAR);
END;
GO
PRINT ' Confirmar que el código está encriptado (debe dar null en la tabla de results )';
SELECT 
    OBJECT_NAME(object_id) AS Procedimiento,
    definition AS CodigoFuente
FROM sys.sql_modules
WHERE object_id = OBJECT_ID('sp_demo_secure');
GO
PRINT ''
PRINT ' Ejecutar procedimiento ( como app_executor con impersonificación , funciona) ';
EXEC sp_demo_secure;
PRINT 'es posible, EXECUTE AS ejecuta un procedimiento almacenado con los permisos de otro usuario diferente al que lo está llamando, es decir, a traves de la impersonificación puede ejecutar procedimientos, triggers y funciones.'
Print ''
GO
-- Crea otro usuario para prueba de acceso denegado
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_tester')
BEGIN
    REVERT; 
    DROP USER usuario_tester;
END
GO
CREATE USER usuario_tester WITHOUT LOGIN;
GO
-- Probar acceso directo a la tabla desde un usuario sin permisos
EXECUTE AS USER = 'usuario_tester';
PRINT ' Usuario limitado intentando leer la tabla directamente (debe fallar) ';
BEGIN TRY
    SELECT * FROM sol_payments;
END TRY
BEGIN CATCH
    PRINT 'ERROR: Usuario sin permisos no puede acceder directamente a la tabla.';
END CATCH;
REVERT;
GO

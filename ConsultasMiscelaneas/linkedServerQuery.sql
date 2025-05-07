USE master;
GO

-- Verifica si el Linked Server ya existe. Si existe, lo elimina.
IF EXISTS (SELECT 1 FROM sys.servers WHERE name = 'LocalServer')
BEGIN
    PRINT 'Eliminando el Linked Server existente...';
    EXEC sp_dropserver @server = 'LocalServer', @droplogins = 'droplogins';
END;
GO

--Se crea un servidor vincluado a una estancia local, esto puesto no tenemos un servidor real. 
EXEC sp_addlinkedserver
    @server = 'LocalServer', 
    @srvproduct = 'SQL Server';

EXEC sp_addlinkedsrvlogin
    @rmtsrvname = 'LocalServer',
    @useself = 'True',
    @locallogin = NULL;

EXEC sp_serveroption 'LocalServer', 'rpc', 'TRUE';
EXEC sp_serveroption 'LocalServer', 'rpc out', 'TRUE';
GO

PRINT 'Servidor vinculado.';

--Se crea una tabla de bit�cora en esta instancia local. 
USE master;
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'RegistroBitacora')
BEGIN
    CREATE TABLE  dbo.RegistroBitacora (
        ID INT PRIMARY KEY IDENTITY(1,1),
        FechaHora DATETIME,
        NombreProcedimiento NVARCHAR(255),
        Mensaje NVARCHAR(MAX),
        UsuarioSQL NVARCHAR(255),
        Servidor NVARCHAR(255),
        Gravedad INT NOT NULL,
        NombreAplicacion NVARCHAR(255) );
    PRINT 'Tabla de bit�cora creada.';
END;
ELSE
    PRINT 'La tabla de bit�cora ya existe.';
GO


-- Utilizando la base de datos, se hace un proceso de almacenamiento de datos.

USE solturaDB;
GO

IF OBJECT_ID('sp_RegistrarEventoBitacora', 'P') IS NOT NULL
BEGIN
    PRINT 'Eliminando el procedimiento almacenado existente...';
    DROP PROCEDURE sp_RegistrarEventoBitacora;
END;
GO

CREATE PROCEDURE sp_RegistrarEventoBitacora (
    @NombreProcedimiento NVARCHAR(255),
    @Mensaje NVARCHAR(MAX),
    @Gravedad INT = 0,
    @NombreAplicacion NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Inserta en la tabla de bit�cora del servidor en la instancia local!!!!!
        INSERT INTO master.dbo.RegistroBitacora (
            FechaHora,
            NombreProcedimiento,
            Mensaje,
            UsuarioSQL,
            Servidor,
            Gravedad,
            NombreAplicacion
        )
        VALUES ( GETDATE(),@NombreProcedimiento, @Mensaje, SUSER_SNAME(),@@SERVERNAME, @Gravedad,
				ISNULL(@NombreAplicacion, APP_NAME()));
    END TRY
    BEGIN CATCH
        PRINT 'Error al registrar en la bit�cora: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

PRINT 'Procedimiento almacenado gen�rico creado exitosamente.';




USE solturaDB;
GO

--Proceso para probar el Script
EXEC sp_RegistrarEventoBitacora
    @NombreProcedimiento = 'PruebaDeBitacora',
    @Mensaje = 'Esto es un mensaje de prueba.',
    @Gravedad = 0,
    @NombreAplicacion = 'Soltura';

-- Verifica el registro en la tabla de bit�cora
SELECT * FROM master.dbo.RegistroBitacora;
GO

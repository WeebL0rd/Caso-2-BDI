USE solturaDB;
GO

-- Definici�n del Table-Valued Parameter (TVP) para las condiciones del contrato
IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'ContractConditionsType')
BEGIN
  CREATE TYPE dbo.ContractConditionsType AS TABLE
  (
      ItemID INT NULL,  
	  Description NVARCHAR(255) NOT NULL,
      StartDate DATE NOT NULL,
      EndDate DATE NULL,
      Price DECIMAL(10, 2) NOT NULL 
      UNIQUE (ItemID) 
  );
END;
GO

CREATE OR ALTER PROCEDURE sp_ActualizarContratoProveedorConDeals
    @ProveedorID INT = NULL, 
    @NombreProveedor NVARCHAR(255) NULL,
    @CondicionesContrato dbo.ContractConditionsType READONLY,
    @EsContrato BIT = 1,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @ProveedorID IS NULL
        BEGIN
            IF @NombreProveedor IS NULL
            BEGIN
                SET @Exito = 0;
                SET @Mensaje = 'El nombre del proveedor es requerido para un nuevo proveedor.';
                ROLLBACK;
                RETURN;
            END

            INSERT INTO solturaDB.sol_partners (name, registerDate, state, identificationtypeId, enterpriseSizeid, identification)
            VALUES (@NombreProveedor, GETDATE(), 1, 1, 1, 'PENDIENTE');

            SET @ProveedorID = SCOPE_IDENTITY();

            IF @ProveedorID IS NULL
            BEGIN
                SET @Exito = 0;
                SET @Mensaje = 'Error al insertar el nuevo proveedor.';
                ROLLBACK;
                RETURN;
            END
        END
        ELSE
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_partners WHERE partnerId = @ProveedorID)
            BEGIN
                SET @Exito = 0;
                SET @Mensaje = 'El proveedor con el ID especificado no existe.';
                ROLLBACK;
                RETURN;
            END
        END
        MERGE solturaDB.sol_deals AS target
        USING @CondicionesContrato AS source
        ON target.partnerId = @ProveedorID AND target.dealDescription = source.Description
        WHEN MATCHED THEN
            UPDATE SET
                target.sealDate = source.StartDate,
                target.endDate = source.EndDate,
                target.isActive = 1
        WHEN NOT MATCHED THEN
            INSERT (partnerId, dealDescription, sealDate, endDate, solturaComission, discount, isActive)
            VALUES (@ProveedorID, source.Description, source.StartDate, source.EndDate, 0.00, source.Price * -1, 1);
        COMMIT TRANSACTION;
        SET @Exito = 1;
        SET @Mensaje = 'Contrato de proveedor actualizado exitosamente (utilizando sol_deals).';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @Exito = 0;
        SET @Mensaje = 'Error al actualizar el contrato del proveedor (utilizando sol_deals): ' + ERROR_MESSAGE();
    END CATCH
END;
GO



--Forma de probar el qury :D 
DECLARE @ContractConditions AS dbo.ContractConditionsType;
INSERT INTO @ContractConditions (ItemID, Description, StartDate, EndDate, Price)
VALUES
(1, 'Servicio Inicial', '2025-08-01', '2026-07-31', 300.00);

DECLARE @Exito BIT;
DECLARE @Mensaje NVARCHAR(500);

EXEC sp_ActualizarContratoProveedorConDeals
    @ProveedorID = NULL,
    @NombreProveedor = 'Proveedor C',
    @CondicionesContrato = @ContractConditions,
    @Exito = @Exito OUTPUT,
    @Mensaje = @Mensaje OUTPUT;

--SELECT @Exito AS Exito, @Mensaje AS Mensaje;
SELECT * FROM solturaDB.sol_partners WHERE name = 'Proveedor C';
SELECT * FROM solturaDB.sol_deals WHERE partnerId = (SELECT TOP 1 partnerId FROM solturaDB.sol_partners WHERE name = 'Proveedor C');
GO
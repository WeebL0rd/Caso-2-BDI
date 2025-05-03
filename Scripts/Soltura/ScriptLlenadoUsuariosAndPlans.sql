USE solturaDB
GO

CREATE OR ALTER PROCEDURE sp_PopulateUserTables
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
		        SET IDENTITY_INSERT solturaDB.sol_users ON;
        INSERT INTO solturaDB.sol_users (userID, email, firstName, lastName, password, enabled)
        VALUES

        (1, 'admin@soltura.com', 'Admin', 'Sistema', HASHBYTES('SHA2_256', 'Admin123'), 1),
        (2, 'juan.perez@example.com', 'Juan', 'Pérez', HASHBYTES('SHA2_256', 'Clave123'), 1),
        (3, 'maria.gomez@example.com', 'María', 'Gómez', HASHBYTES('SHA2_256', 'Secure456'), 1),
        (4, 'carlos.rodriguez@example.com', 'Carlos', 'Rodríguez', HASHBYTES('SHA2_256', 'Pass789'), 1),
        (5, 'ana.martinez@example.com', 'Ana', 'Martínez', HASHBYTES('SHA2_256', 'Ana2023'), 1),
        (6, 'luis.hdez@example.com', 'Luis', 'Hernández', HASHBYTES('SHA2_256', 'Luis456'), 1),
        (7, 'sofia.castro@example.com', 'Sofía', 'Castro', HASHBYTES('SHA2_256', 'Sofia789'), 1),
        (8, 'pedro.mendoza@example.com', 'Pedro', 'Mendoza', HASHBYTES('SHA2_256', 'Pedro123'), 1),
        (9, 'laura.gutierrez@example.com', 'Laura', 'Gutiérrez', HASHBYTES('SHA2_256', 'Laura456'), 1),
        (10, 'diego.ramirez@example.com', 'Diego', 'Ramírez', HASHBYTES('SHA2_256', 'Diego789'), 1),
        (11, 'elena.sanchez@example.com', 'Elena', 'Sánchez', HASHBYTES('SHA2_256', 'Elena123'), 1),
        (12, 'javier.lopez@example.com', 'Javier', 'López', HASHBYTES('SHA2_256', 'Javier456'), 1),
        (13, 'isabel.garcia@example.com', 'Isabel', 'García', HASHBYTES('SHA2_256', 'Isabel789'), 1),
        (14, 'miguel.torres@example.com', 'Miguel', 'Torres', HASHBYTES('SHA2_256', 'Miguel123'), 1),
        (15, 'carmen.ortiz@example.com', 'Carmen', 'Ortiz', HASHBYTES('SHA2_256', 'Carmen456'), 1),
        (16, 'raul.morales@example.com', 'Raúl', 'Morales', HASHBYTES('SHA2_256', 'Raul789'), 1),
        (17, 'patricia.vargas@example.com', 'Patricia', 'Vargas', HASHBYTES('SHA2_256', 'Patricia123'), 1),
        (18, 'oscar.diaz@example.com', 'Oscar', 'Díaz', HASHBYTES('SHA2_256', 'Oscar456'), 1),
        (19, 'adriana.ruiz@example.com', 'Adriana', 'Ruiz', HASHBYTES('SHA2_256', 'Adriana789'), 1),
        (20, 'fernando.molina@example.com', 'Fernando', 'Molina', HASHBYTES('SHA2_256', 'Fernando123'), 1),
        (21, 'gabriela.silva@example.com', 'Gabriela', 'Silva', HASHBYTES('SHA2_256', 'Gabriela456'), 1),
        (22, 'arturo.cruz@example.com', 'Arturo', 'Cruz', HASHBYTES('SHA2_256', 'Arturo789'), 1),
        (23, 'claudia.reyes@example.com', 'Claudia', 'Reyes', HASHBYTES('SHA2_256', 'Claudia123'), 1),
        (24, 'manuel.aguilar@example.com', 'Manuel', 'Aguilar', HASHBYTES('SHA2_256', 'Manuel456'), 1),
        (25, 'diana.flores@example.com', 'Diana', 'Flores', HASHBYTES('SHA2_256', 'Diana789'), 1),
        (26, 'roberto.campos@example.com', 'Roberto', 'Campos', HASHBYTES('SHA2_256', 'Roberto123'), 1),
        (27, 'silvia.mendez@example.com', 'Silvia', 'Méndez', HASHBYTES('SHA2_256', 'Silvia456'), 1),
        (28, 'eduardo.guerra@example.com', 'Eduardo', 'Guerra', HASHBYTES('SHA2_256', 'Eduardo789'), 1),
        (29, 'lucia.sosa@example.com', 'Lucía', 'Sosa', HASHBYTES('SHA2_256', 'Lucia123'), 1),
        (30, 'hugo.rios@example.com', 'Hugo', 'Ríos', HASHBYTES('SHA2_256', 'Hugo456'), 1);
        SET IDENTITY_INSERT solturaDB.sol_users OFF;

		SET IDENTITY_INSERT solturaDB.sol_associateIdentificationTypes ON;
		INSERT INTO solturaDB.sol_associateIdentificationTypes (identificationTypeID, description, datatype) VALUES
		(1, 'NFC Tag - Formato estándar', 'Binario'),
		(2, 'NFC Tag - Formato personalizado', 'Binario'),
		(3, 'Código QR - Versión 1', 'Texto'),
		(4, 'Código QR - Versión 2 con logo', 'Texto'),
		(5, 'Código QR Dinámico', 'URL'),
		(6, 'NFC HCE (Host Card Emulation)', 'Binario'),
		(7, 'Código QR de un solo uso', 'Texto encriptado'),
		(8, 'NFC con autenticación biométrica', 'Binario seguro');
		SET IDENTITY_INSERT solturaDB.sol_associateIdentificationTypes OFF;


		SET IDENTITY_INSERT solturaDB.sol_planTypes ON;
		INSERT INTO solturaDB.sol_planTypes (planTypeID, type, userID) VALUES
		(1, 'Básico', NULL),
		(2, 'Premium', NULL),
		(3, 'Empresarial', NULL),
		(4, 'Familiar', NULL),
		(5, 'Estudiantil', NULL),
		(6, 'Personalizado', NULL),
		(7, 'Promocional', NULL),
		(8, 'Metales (Gold/Plata/Bronce)', NULL),
		(9, 'Prueba Gratis', NULL),
		(10, 'Corporativo', NULL),
		(11, 'Gobierno', NULL),
		(12, 'ONG', NULL),
		(13, 'Emergencia', NULL),
		(14, 'Temporada', NULL),
		(15, 'Personal Plus', NULL);
		SET IDENTITY_INSERT solturaDB.sol_planTypes OFF;
		

		SET IDENTITY_INSERT solturaDB.sol_plans ON;
		INSERT INTO solturaDB.sol_plans (planID, description, planTypeID) VALUES 
		(1, 'Plan Básico Mensual', 1),
		(2, 'Plan Básico Anual', 1),
		(3, 'Plan Premium Mensual', 2),
		(4, 'Plan Premium Anual', 2),
		(5, 'Plan Empresarial Básico', 3),
		(6, 'Plan Empresarial Avanzado', 3),
		(7, 'Plan Familiar', 4),
		(8, 'Plan Estudiantil', 5),
		(9, 'Plan Personalizado', 6),
		(10, 'Plan Promocional Temporada', 7),
		(11, 'Plan Gold - Acceso Total', 8),
		(12, 'Plan Plata - Funcionalidades Limitadas', 8),
		(13, 'Plan Bronce - Básico', 8),
		(14, 'Plan Prueba 15 días', 9),
		(15, 'Plan Corporativo Multisede', 10),
		(16, 'Plan Gobierno', 11),
		(17, 'Plan ONG', 12),
		(18, 'Plan Emergencia', 13),
		(19, 'Plan Temporada Baja', 14),
		(20, 'Plan Personal Plus', 15),
		(21, 'Joven Deportista', 5),  
		(22, 'Familia de Verano', 4), 
		(23, 'Viajero Frecuente', 6), 
		(24, 'Nómada Digital', 6);    
		SET IDENTITY_INSERT solturaDB.sol_plans OFF;

		SET IDENTITY_INSERT solturaDB.sol_planPrices ON;
		INSERT INTO solturaDB.sol_planPrices (planPriceID,planID,amount,currency_id,postTime,endDate,"current")
		VALUES
		(1, 1, 20000.00, 1, GETDATE(), '2023-12-31', 1),
		(2, 2, 35000.00, 1, GETDATE(), '2023-12-31', 1),
		(3, 3, 50.00, 2, GETDATE(), '2023-12-31', 1),
		(4, 1, 35.00, 2, GETDATE(), '2023-12-31', 0),
		(5, 2, 60.00, 2, GETDATE(), '2023-12-31', 0);

		SET IDENTITY_INSERT solturaDB.sol_planPrices OFF;

		SET IDENTITY_INSERT solturaDB.sol_schedules ON;
        INSERT INTO solturaDB.sol_schedules (
            scheduleID,name,repit,repetitions,recurrencyType,endDate,startDate)
        VALUES
        (1, 'Ejecución Diaria', 1, 0, 1, NULL, '2023-01-01'),
        (2, 'Ejecución Semanal', 1, 12, 2, DATEADD(MONTH, 3, GETDATE()), '2023-01-01'),
        (3, 'Ejecución Mensual', 1, 12, 3, DATEADD(YEAR, 1, GETDATE()), '2023-01-01'),
        (4, 'Ejecución Anual', 1, 0, 5, NULL, '2023-01-01');
        SET IDENTITY_INSERT solturaDB.sol_schedules OFF;

        SET IDENTITY_INSERT solturaDB.sol_schedulesDetails ON;
        INSERT INTO solturaDB.sol_schedulesDetails (schedulesDetailsID,deleted,schedule_id,baseDate,datePart,lastExecute,nextExecute,description,detail)
        VALUES
        (1, 0, 1, '2023-01-01', CONVERT(date, GETDATE()), 
            DATEADD(DAY, -1, GETDATE()), GETDATE(), 
            'Ejecución diaria del sistema', 'Procesamiento nocturno'),
        (2, 0, 2, '2023-01-01', CONVERT(date, DATEADD(DAY, 7-DATEPART(WEEKDAY, GETDATE()), GETDATE())), 
            DATEADD(WEEK, -1, GETDATE()), DATEADD(WEEK, 1, GETDATE()), 
            'Ejecución semanal de reportes', 'Generación de reportes semanales'),
        (3, 0, 3, '2023-01-01', CONVERT(date, DATEADD(DAY, -DAY(GETDATE())+1, GETDATE())), 
            DATEADD(MONTH, -1, GETDATE()), DATEADD(MONTH, 1, GETDATE()), 
            'Cierre mensual contable', 'Proceso de cierre contable'),
        (4, 0, 4, '2023-01-01', DATEFROMPARTS(YEAR(GETDATE()), 1, 1), 
            DATEADD(YEAR, -1, GETDATE()), DATEADD(YEAR, 1, GETDATE()), 
            'Mantenimiento anual', 'Actualización general del sistema');
        SET IDENTITY_INSERT solturaDB.sol_schedulesDetails OFF;


        SET IDENTITY_INSERT solturaDB.sol_roles ON;
        INSERT INTO solturaDB.sol_roles (roleID, roleName)
        VALUES
        (1, 'Administrador'),
        (2, 'Usuario Estándar'),
        (3, 'Usuario Premium'),
        (4, 'Soporte Técnico'),
        (5, 'Gestor de Contenidos');
        SET IDENTITY_INSERT solturaDB.sol_roles OFF;

        SET IDENTITY_INSERT solturaDB.sol_modules ON;
        INSERT INTO solturaDB.sol_modules (moduleID, name)
        VALUES
        (1, 'Dashboard'),
        (2, 'Usuarios'),
        (3, 'Planes'),
        (4, 'Reportes'),
        (5, 'Configuración');
        SET IDENTITY_INSERT solturaDB.sol_modules OFF;

        SET IDENTITY_INSERT solturaDB.sol_permissions ON;
        INSERT INTO solturaDB.sol_permissions (permissionID, description, code, moduleID)
        VALUES
        (1, 'Acceso completo', 'All', 1),
        (2, 'Ver dashboard', 'DashView', 1),
        (3, 'Crear usuarios', 'UserCreate', 2),
        (4, 'Editar usuarios', 'UserEdit', 2),
        (5, 'Eliminar usuarios', 'UserDelete', 2),
        (6, 'Administrar planes', 'PlanManage', 3),
        (7, 'Generar reportes', 'ReportGen', 4),
        (8, 'Configuración sistema', 'ConfigEdit', 5);
        SET IDENTITY_INSERT solturaDB.sol_permissions OFF;

        SET IDENTITY_INSERT solturaDB.sol_rolePermissions ON;
        INSERT INTO solturaDB.sol_rolePermissions (rolePermissionID, roleID, permissionID, enabled, deleted, lastPermUpdate, username, checksum)
        VALUES
        (1, 1, 1, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm1')),
        (2, 2, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm2')),
        (3, 3, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm3')),
        (4, 3, 6, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm4')),
        (5, 4, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm5')), 
        (6, 4, 3, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm6')),
        (7, 4, 4, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm7')),
        (8, 5, 2, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm8')), 
        (9, 5, 7, 1, 0, GETDATE(), 'system', HASHBYTES('SHA2_256', 'roleperm9')); 
        SET IDENTITY_INSERT solturaDB.sol_rolePermissions OFF;

        SET IDENTITY_INSERT solturaDB.sol_userRoles ON;
        INSERT INTO solturaDB.sol_userRoles (userID, role_id, enabled, deleted, lastUpdate, username, checksum)
        VALUES
        (1, 1, 1, 0, GETDATE(), 'admin', HASHBYTES('SHA2_256', 'admin_role')),
        (2, 2, 1, 0, GETDATE(), 'juan.perez', HASHBYTES('SHA2_256', 'user_role')),
        (3, 3, 1, 0, GETDATE(), 'maria.gomez', HASHBYTES('SHA2_256', 'prem_role')),
        (4, 4, 1, 0, GETDATE(), 'carlos.rod', HASHBYTES('SHA2_256', 'support_role')),
        (5, 5, 1, 0, GETDATE(), 'ana.mtz', HASHBYTES('SHA2_256', 'content_role')),
        (6, 2, 1, 0, GETDATE(), 'luis.hdez', HASHBYTES('SHA2_256', 'user_role')),
        (7, 3, 1, 0, GETDATE(), 'sofia.castro', HASHBYTES('SHA2_256', 'prem_role')),
        (8, 2, 1, 0, GETDATE(), 'pedro.mendoza', HASHBYTES('SHA2_256', 'user_role')),
        (9, 3, 1, 0, GETDATE(), 'laura.gutierrez', HASHBYTES('SHA2_256', 'prem_role')),
        (10, 2, 1, 0, GETDATE(), 'diego.ramirez', HASHBYTES('SHA2_256', 'user_role')),
        (11, 3, 1, 0, GETDATE(), 'elena.sanchez', HASHBYTES('SHA2_256', 'prem_role')),
        (12, 2, 1, 0, GETDATE(), 'javier.lopez', HASHBYTES('SHA2_256', 'user_role')),
        (13, 3, 1, 0, GETDATE(), 'isabel.garcia', HASHBYTES('SHA2_256', 'prem_role')),
        (14, 2, 1, 0, GETDATE(), 'miguel.torres', HASHBYTES('SHA2_256', 'user_role')),
        (15, 3, 1, 0, GETDATE(), 'carmen.ortiz', HASHBYTES('SHA2_256', 'prem_role')),
        (16, 2, 1, 0, GETDATE(), 'raul.morales', HASHBYTES('SHA2_256', 'user_role')),
        (17, 3, 1, 0, GETDATE(), 'patricia.vargas', HASHBYTES('SHA2_256', 'prem_role')),
        (18, 2, 1, 0, GETDATE(), 'oscar.diaz', HASHBYTES('SHA2_256', 'user_role')),
        (19, 3, 1, 0, GETDATE(), 'adriana.ruiz', HASHBYTES('SHA2_256', 'prem_role')),
        (20, 2, 1, 0, GETDATE(), 'fernando.molina', HASHBYTES('SHA2_256', 'user_role')),
        (21, 3, 1, 0, GETDATE(), 'gabriela.silva', HASHBYTES('SHA2_256', 'prem_role')),
        (22, 2, 1, 0, GETDATE(), 'arturo.cruz', HASHBYTES('SHA2_256', 'user_role')),
        (23, 3, 1, 0, GETDATE(), 'claudia.reyes', HASHBYTES('SHA2_256', 'prem_role')),
        (24, 2, 1, 0, GETDATE(), 'manuel.aguilar', HASHBYTES('SHA2_256', 'user_role')),
        (25, 3, 1, 0, GETDATE(), 'diana.flores', HASHBYTES('SHA2_256', 'prem_role')),
        (26, 2, 1, 0, GETDATE(), 'roberto.campos', HASHBYTES('SHA2_256', 'user_role')),
        (27, 2, 1, 0, GETDATE(), 'silvia.mendez', HASHBYTES('SHA2_256', 'user_role')),
        (28, 2, 1, 0, GETDATE(), 'eduardo.guerra', HASHBYTES('SHA2_256', 'user_role')),
        (29, 2, 1, 0, GETDATE(), 'lucia.sosa', HASHBYTES('SHA2_256', 'user_role')),
        (30, 2, 1, 0, GETDATE(), 'hugo.rios', HASHBYTES('SHA2_256', 'user_role'));
        SET IDENTITY_INSERT solturaDB.sol_userRoles OFF;

        SET IDENTITY_INSERT solturaDB.sol_usersAdresses ON;
        INSERT INTO solturaDB.sol_usersAdresses(userAddressID, userID, addressID, enabled)
        VALUES
        (1, 1, 1, 1),
        (2, 2, 2, 1),
        (3, 3, 3, 1),
        (4, 4, 4, 1),
        (5, 5, 5, 1),
        (6, 6, 1, 1),
        (7, 7, 2, 1),
        (8, 8, 3, 1),
        (9, 9, 4, 1),
        (10, 10, 5, 1),
        (11, 11, 1, 1),
        (12, 12, 2, 1),
        (13, 13, 3, 1),
        (14, 14, 4, 1),
        (15, 15, 5, 1),
        (16, 16, 1, 1),
        (17, 17, 2, 1),
        (18, 18, 3, 1),
        (19, 19, 4, 1),
        (20, 20, 5, 1),
        (21, 21, 1, 1),
        (22, 22, 2, 1),
        (23, 23, 3, 1),
        (24, 24, 4, 1),
        (25, 25, 5, 1),
        (26, 26, 1, 1),
        (27, 27, 2, 1),
        (28, 28, 3, 1),
        (29, 29, 4, 1),
        (30, 30, 5, 1);
        SET IDENTITY_INSERT solturaDB.sol_usersAdresses OFF;

        SET IDENTITY_INSERT solturaDB.sol_userPlans ON;
        INSERT INTO solturaDB.sol_userPlans (userPlanID, userID, planPriceID, scheduleID, adquisition, enabled)
        VALUES
        (1, 1, 1, 1, '2023-01-01', 1),
        (2, 2, 2, 1, '2023-02-15', 1),
        (3, 3, 2, 2, '2023-03-10', 1),
        (4, 4, 3, 3, '2023-04-20', 1),
        (5, 5, 3, 3, '2023-05-05', 1),
        (6, 6, 1, 1, '2023-01-15', 1),
        (7, 7, 2, 1, '2023-02-20', 1),
        (8, 8, 2, 2, '2023-03-25', 1),
        (9, 9, 3, 3, '2023-04-10', 1),
        (10, 10, 3, 3, '2023-05-15', 1),
        (11, 11, 1, 1, '2023-01-20', 1),
        (12, 12, 2, 1, '2023-02-25', 1),
        (13, 13, 2, 2, '2023-03-30', 1),
        (14, 14, 3, 3, '2023-04-05', 1),
        (15, 15, 3, 3, '2023-05-10', 1),
        (16, 16, 1, 1, '2023-01-25', 1),
        (17, 17, 2, 1, '2023-02-28', 1),
        (18, 18, 2, 2, '2023-03-05', 1),
        (19, 19, 3, 3, '2023-04-15', 1),
        (20, 20, 3, 3, '2023-05-20', 1),
        (21, 21, 1, 1, '2023-01-30', 1),
        (22, 22, 2, 1, '2023-02-05', 1),
        (23, 23, 2, 2, '2023-03-15', 1),
        (24, 24, 3, 3, '2023-04-25', 1),
        (25, 25, 3, 3, '2023-05-30', 1),
		(26, 6, 1, 1, '2023-06-01', 1),
		(27, 7, 1, 1, '2023-06-05', 1),
		(28, 8, 1, 1, '2023-06-10', 1),
		(29, 9, 2, 2, '2023-06-15', 1),
		(30, 10, 2, 2, '2023-06-20', 1),
		(31, 11, 2, 2, '2023-06-25', 1),
		(32, 12, 2, 2, '2023-06-30', 1);
        SET IDENTITY_INSERT solturaDB.sol_userPlans OFF;

        SET IDENTITY_INSERT solturaDB.sol_userPermissions ON;
        INSERT INTO solturaDB.sol_userPermissions (userPermissionID, permissionID, enabled, deleted, lastPermUpdate, username, checksum, userID)
        VALUES
        (1, 1, 1, 0, GETDATE(), 'admin', HASHBYTES('SHA2_256', 'perm_admin'), 1),
        (2, 2, 1, 0, GETDATE(), 'juan.perez', HASHBYTES('SHA2_256', 'perm_user'), 2),
        (3, 2, 1, 0, GETDATE(), 'maria.gomez', HASHBYTES('SHA2_256', 'perm_user'), 3),
        (4, 3, 1, 0, GETDATE(), 'carlos.rod', HASHBYTES('SHA2_256', 'perm_prem'), 4),
        (5, 3, 1, 0, GETDATE(), 'ana.mtz', HASHBYTES('SHA2_256', 'perm_prem'), 5);
        SET IDENTITY_INSERT solturaDB.sol_userPermissions OFF;

        INSERT INTO solturaDB.sol_userAssociateIdentifications(associateID, token, userID, identificationTypeID)
        VALUES
        (1, HASHBYTES('SHA2_256', 'token123'), 1, 1),
        (2, HASHBYTES('SHA2_256', 'token456'), 2, 1),
        (3, HASHBYTES('SHA2_256', 'token789'), 3, 1),
        (4, HASHBYTES('SHA2_256', 'token012'), 4, 2),
        (5, HASHBYTES('SHA2_256', 'token345'), 5, 2);

        COMMIT TRANSACTION;
        PRINT 'Tablas de usuarios pobladas exitosamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar tablas de usuarios: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

EXEC sp_PopulateUserTables;


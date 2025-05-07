# Documentación del Caso #2

## Integrantes

Efraim Cuevas Aguilar
Carné: 2024109746
Github user: weebL0rd




Carlos Andrés García Molina
Carné: 2024181023
Github user: CGarcía1411




Beatriz Rebeca Díaz Gómez
Carné: 2024090972
Github user: pinkcrate




Rachel Leiva Abarca
Carné: 2024220640
Github user:RachellLeiva

---
# Diseño de la base de datos

---
# Test de la base de datos
## Población de datos
Script Llenado Paises
Inserta todos los datos referentes a países. 
```sql
USE solturaDB
INSERT INTO solturaDB.sol_countries (name)
VALUES
('Costa Rica'),
('Estados Unidos'),
('México'),
('España');
INSERT INTO solturaDB.sol_states (name, countryID)
VALUES
('San José', 1),
('Alajuela', 1),
('Cartago', 1),
('Heredia', 1),
('Guanacaste', 1),
('Puntarenas', 1),
('Limón', 1),
('California', 2),
('Texas', 2),
('Florida', 2),
('Nueva York', 2),
('Ciudad de México', 3),
('Jalisco', 3),
('Nuevo León', 3),
('Madrid', 4),
('Barcelona', 4),
('Valencia', 4);
SET IDENTITY_INSERT solturaDB.sol_city ON;
INSERT INTO solturaDB.sol_city (cityID, stateID, name)
VALUES
(1, 1, 'San José'),
(2, 1, 'Escazú'),
(3, 1, 'Santa Ana'),
(4, 2, 'Alajuela'),
(5, 2, 'Grecia'),
(6, 2, 'San Ramón'),
(7, 8, 'Los Ángeles'),
(8, 8, 'San Francisco'),
(9, 8, 'San Diego'),
(10, 12, 'Ciudad de México'),
(11, 12, 'Coyoacán'),
(12, 12, 'Polanco'),
(13, 15, 'Madrid'),
(14, 15, 'Alcobendas'),
(15, 15, 'Las Rozas');

SET IDENTITY_INSERT solturaDB.sol_city OFF;
SET IDENTITY_INSERT solturaDB.sol_addresses ON;
INSERT INTO solturaDB.sol_addresses (addressid, line1, line2, zipcode, geoposition, cityID)
VALUES
(1, 'Avenida Central', 'Calle 25', '10101', 
 geometry::Point(9.9281, -84.0907, 4326), 1),
(2, 'Centro Comercial Multiplaza', 'Local #45', '10203', 
 geometry::Point(9.9186, -84.1118, 4326), 2),
(3, 'Calle Vieja', 'Frente a la iglesia', '10901', 
 geometry::Point(9.9326, -84.1826, 4326), 3),
(4, 'Hollywood Boulevard 123', 'Sector 5', '90028', 
 geometry::Point(34.1016, -118.3389, 4326), 7),
(5, 'Gran Vía 78', 'Piso 3', '28013', 
 geometry::Point(40.4194, -3.7055, 4326), 13);
SET IDENTITY_INSERT solturaDB.sol_addresses OFF;
INSERT INTO solturaDB.sol_currencies (name, acronym, symbol, countryID)
VALUES
('Colón Costarricense', 'CRC', '₡', 1),
('Dólar Estadounidense', 'USD', '$', 2);
SET IDENTITY_INSERT solturaDB.sol_exchangeCurrencies ON;
INSERT INTO solturaDB.sol_exchangeCurrencies (exchangeCurrencyID, sourceID, destinyID, startDate, endDate, exchange_rate, enabled, currentExchange)
VALUES
(1, 1, 2, '2025-05-01', NULL, 0.0018, 1, 1),
(2, 2, 1, '2025-05-01', NULL, 555.556, 1, 1);
SET IDENTITY_INSERT solturaDB.sol_exchangeCurrencies OFF;
```
Script Llenado Partners
Inserts de los datos relacionado a Partners y a Empresas. 
```sql
USE solturaDB
GO
INSERT INTO solturaDB.sol_partners_identifications_types(name) 
VALUES 
('Jurídico'),
('Cédula'),
('Gobierno')
INSERT INTO solturaDB.sol_enterprise_size (size) 
VALUES 
('Pequeña'),
('Mediana'),
('Grande')
SET IDENTITY_INSERT solturaDB.sol_partners ON;
INSERT INTO solturaDB.sol_partners (partnerId, name, registerDate, state, identificationtypeId, enterpriseSizeid, identification) 
VALUES
(1, 'ElectroProveedores S.A.', GETDATE(), 1, 1, 3, '3-101-205045'),
(2, 'Tienda XYZ Descuentos', GETDATE(), 1, 1, 2, '3-102-456789'),
(3, 'SuperAhorro Limitado', GETDATE(), 1, 1, 2, '3-103-123456'),
(4, 'MegaTienda Cuponera', GETDATE(), 1, 1, 3, '3-104-789123'),
(5, 'Parqueo Seguro VIP', GETDATE(), 1, 1, 2, '3-105-456123'),
(6, 'Cinépolis', GETDATE(), 1, 1, 3, '3-106-321654'),
(7, 'McDonalds', GETDATE(), 1, 1, 2, '3-107-098324');
SET IDENTITY_INSERT solturaDB.sol_partners OFF;
INSERT INTO solturaDB.sol_partner_addresses (partnerId, addressid)
VALUES
(1, 1),  
(2, 2),  
(3, 2),  
(4, 5), 
(5, 3),
(7, 1),
(6, 4);
```
Script Llenado Usuarios
Inserta datos referentes a los usuarios.
```sql
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
		(4, 4, 35.00, 2, GETDATE(), '2023-12-31', 0),
		(5, 5, 60.00, 2, GETDATE(), '2023-12-31', 0);
		SET IDENTITY_INSERT solturaDB.sol_planPrices OFF;

		SET IDENTITY_INSERT solturaDB.sol_schedules ON;
        INSERT INTO solturaDB.sol_schedules (scheduleID,name,repit,repetitions,recurrencyType,endDate,startDate)
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
		(26, 26, 1, 1, '2023-06-01', 1),
		(27, 27, 1, 1, '2023-06-05', 1),
		(28, 28, 1, 1, '2023-06-10', 1),
		(29, 29, 2, 2, '2023-06-15', 1),
		(30, 30, 2, 2, '2023-06-20', 1);
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
		SET IDENTITY_INSERT solturaDB.sol_userPermissions ON;
        INSERT INTO solturaDB.sol_userPermissions (
            userPermissionID, permissionID, enabled, deleted, lastPermUpdate, username, checksum, userID
        )
        SELECT 
            ROW_NUMBER() OVER (ORDER BY u.userID) + 5 AS userPermissionID, -- Continuando desde el ID 6
            CASE 
                WHEN u.userID = 1 THEN 1 
                WHEN u.userID % 3 = 0 THEN 3
                ELSE 2 
            END AS permissionID,
            1 AS enabled,
            0 AS deleted,
            GETDATE() AS lastPermUpdate,
            LEFT(u.email, CHARINDEX('@', u.email) - 1) AS username,
            HASHBYTES('SHA2_256', 'perm_' + CAST(u.userID AS VARCHAR)) AS checksum,
            u.userID
        FROM solturaDB.sol_users u
        WHERE u.userID > 5; 
        SET IDENTITY_INSERT solturaDB.sol_userPermissions OFF;

		ALTER TABLE solturaDB.sol_userAssociateIdentifications
		ALTER COLUMN token VARBINARY(MAX) NOT NULL;

        OPEN SYMMETRIC KEY SolturaLlaveSimetrica  
		DECRYPTION BY CERTIFICATE CertificadoDeCifrado;

		INSERT INTO solturaDB.sol_userAssociateIdentifications(associateID, token, userID, identificationTypeID)
		VALUES
		(1, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'NFC_TAG_STD_001')), 1, 1),
		(2, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'NFC_TAG_CUSTOM_002')), 2, 2),
		(3, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'QR_V1_ABC123')), 3, 3),
		(4, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'QR_V2_LOGO_DEF456')), 4, 4),
		(5, EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), CONVERT(varchar, 'DYN_QR_789URL')), 5, 5);

		INSERT INTO solturaDB.sol_userAssociateIdentifications (associateID, token, userID, identificationTypeID)
		SELECT 
			ROW_NUMBER() OVER (ORDER BY u.userID) + 5 AS associateID,
			EncryptByKey(Key_GUID('SolturaLlaveSimetrica'), 
				CONVERT(varchar,
					CASE 
						WHEN u.userID % 2 = 0 THEN 'NFC_STD_UID_' + CAST(u.userID AS varchar)
						ELSE 'QR_V1_TOKEN_' + CAST(u.userID AS varchar)
					END
				)
			) AS token,
			u.userID,
			CASE 
				WHEN u.userID % 2 = 0 THEN 1  -- NFC Tag - Formato estándar
				ELSE 3                        -- Código QR - Versión 1
			END AS identificationTypeID
		FROM solturaDB.sol_users u
		WHERE u.userID > 5;

CLOSE SYMMETRIC KEY SolturaLlaveSimetrica;
               COMMIT TRANSACTION;
        PRINT 'Tablas de usuarios pobladas exitosamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar tablas de usuarios: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
delete from solturaDB.sol_availablePayMethods 
EXEC sp_PopulateUserTables;
```
Script Llenado Logs
Insertar datos referentes a los logs, sobretodo preparando los logs para el trigger hecho más adelante.
```sql
USE solturaDB;
GO
INSERT INTO solturaDB.sol_logSources ( name)
VALUES 
    ('PaymentSystem'),
    ( 'UserManagement'), 
    ( 'Subscription'),
    ( 'API'),  
    ( 'Database'),  
    ( 'Scheduler'), 
    ( 'MobileApp'),   
    ( 'WebPortal'); 


INSERT INTO solturaDB.sol_logTypes (
    name, 
    reference1Description, 
    reference2Description, 
    value1Description, 
    value2Description
)
VALUES 
    ( 'Payment', 'PaymentID', 'UserID', 'Amount', 'PaymentMethod'), 
    ( 'User', 'UserID', 'RoleID', 'Action', 'Details'),   
    ( 'Subscription', 'PlanID', 'UserID', 'OldPlan', 'NewPlan'),  
    ( 'Error', 'ErrorCode', 'LineNumber', 'Message', 'Context'), 
    ( 'Audit', 'EntityID', 'ModifiedBy', 'FieldChanged', 'NewValue'),
    ( 'Security', 'UserID', 'IPAddress', 'Action', 'Status'), 
    ( 'APIRequest', 'Endpoint', 'Status', 'Parameters', 'Response'), 
    ( 'Maintenance', 'TaskID', 'Duration', 'Details', 'Result');  

INSERT INTO solturaDB.sol_logsSererity ( name)
VALUES 
    ( 'Info'),
    ( 'Warning'), 
    ( 'Error'), 
    ( 'Critical'), 
    ( 'Debug');  

ALTER TABLE solturaDB.sol_logs
ALTER COLUMN computer NVARCHAR(75) NULL;
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN trace NVARCHAR(100) NULL;
ALTER TABLE solturaDB.sol_logs
ALTER COLUMN checksum varbinary(250) NULL;
GO
```

Script Llenado Payments
Inserts relacionados a los payments, y a los features
```sql
USE solturaDB
GO
BEGIN TRY
    BEGIN TRANSACTION;
    
    DECLARE @constraintName NVARCHAR(128);
    
    SELECT @constraintName = name
    FROM sys.key_constraints
    WHERE parent_object_id = OBJECT_ID('solturaDB.sol_payments')
    AND type = 'UQ';
    
    IF @constraintName IS NOT NULL
    BEGIN
        DECLARE @sql NVARCHAR(MAX) = N'ALTER TABLE solturaDB.sol_payments DROP CONSTRAINT [' + @constraintName + ']';
        EXEC sp_executesql @sql;
        
        PRINT 'Restricción UNIQUE eliminada: ' + @constraintName;
    END
    ELSE
    BEGIN
        PRINT 'No se encontró ninguna restricción UNIQUE en sol_payments.methodID';
    END
    
    COMMIT TRANSACTION;
    PRINT 'Operación completada exitosamente';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error al eliminar la restricción UNIQUE: ' + ERROR_MESSAGE();
END CATCH
GO

CREATE OR ALTER PROCEDURE sp_PopulateTables
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
	
		INSERT INTO solturaDB.sol_payMethod (payMethodID, name, apiURL, secretKey, [key], logoIconURL, enabled)
		VALUES
		(1, 'Tarjeta de Crédito', 'https://api.payments.com/creditcard', 
		 CAST('AES_Encrypted_Key_123' AS VARBINARY(255)), 
		 'pk_live_123456789', '/assets/icons/credit-card.png', 1),
    
		(2, 'Transferencia Bancaria', 'https://api.payments.com/banktransfer', 
		 CAST('AES_Encrypted_Key_456' AS VARBINARY(255)), 
		 'pk_live_987654321', '/assets/icons/bank-transfer.png', 1),
    
		(3, 'PayPal', 'https://api.payments.com/paypal', 
		 CAST('AES_Encrypted_Key_789' AS VARBINARY(255)), 
		 'pk_live_567891234', '/assets/icons/paypal.png', 1),
    
		(4, 'Sinpe Móvil', 'https://api.payments.com/sinpe', 
		 CAST('AES_Encrypted_Key_321' AS VARBINARY(255)), 
		 'pk_live_432187654', '/assets/icons/mobile-payment.png', 1),
    
		(5, 'Efectivo', 'https://api.payments.com/cash', 
		 CAST('AES_Encrypted_Key_654' AS VARBINARY(255)), 
		 'pk_live_876543219', '/assets/icons/cash.png', 1);


		SET IDENTITY_INSERT solturaDB.sol_availablePayMethods ON;
		INSERT INTO solturaDB.sol_availablePayMethods (available_method_id, name, userID, token, expToken, 
														maskAccount, methodID)
		VALUES
		(1, 'VISA Platinum ****1234', 1, 'tok_visa_1234', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1234', 1),
		(2, 'Cuenta BAC Credomatic', 1, 'tok_bac_5678', DATEADD(YEAR, 6, GETDATE()), '****5678 (BAC)', 2),
		(3, 'PayPal Premium', 2, 'tok_paypal_9012', DATEADD(YEAR, 3, GETDATE()), 'pp_juan', 3),
		(4, 'Mastercard Gold ****4321', 3, 'tok_mc_4321', DATEADD(YEAR, 5, GETDATE()), '****-****-****-4321', 1),
		(5, 'Sinpe Móvil BAC', 3, 'tok_sinpe_8765', DATEADD(YEAR, 12, GETDATE()), '8888-8888 (SINPE)', 4),
		(6, 'Efectivo en Sucursal', 4, 'tok_cash_0000', DATEADD(YEAR, 50, GETDATE()), 'EFECTIVO-001', 5),
		(7, 'VISA Infinite ****1111', 5, 'tok_visa_1111', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1111', 1),
		(8, 'Mastercard Black ****2222', 6, 'tok_mc_2222', DATEADD(YEAR, 5, GETDATE()), '****-****-****-2222', 1),
		(9, 'PayPal Business', 7, 'tok_paypal_biz', DATEADD(YEAR, 3, GETDATE()), 'pp_sofia', 3),
		(10, 'Cuenta BCR', 8, 'tok_bcr_3333', DATEADD(YEAR, 7, GETDATE()), '****3333 (BCR)', 2),
		(11, 'Sinpe Móvil BCR', 9, 'tok_sinpe_bcr', DATEADD(YEAR, 10, GETDATE()), '7777-7777', 4),
		(12, 'Efectivo Express', 10, 'tok_cash_exp', DATEADD(YEAR, 2, GETDATE()), 'EFECTIVO-002', 5),
		(13, 'VISA Signature ****4444', 11, 'tok_visa_4444', DATEADD(YEAR, 4, GETDATE()), '****-****-****-4444', 1),
		(14, 'Mastercard Platinum ****5555', 12, 'tok_mc_5555', DATEADD(YEAR, 5, GETDATE()), '****-****-****-5555', 1),
		(15, 'PayPal Personal', 13, 'tok_paypal_per', DATEADD(YEAR, 3, GETDATE()), 'pp_isabel', 3),
		(16, 'Cuenta Scotiabank', 14, 'tok_scotia_666', DATEADD(YEAR, 6, GETDATE()), '****6666 (Scotia)', 2),
		(17, 'Sinpe Móvil BN', 15, 'tok_sinpe_bn', DATEADD(YEAR, 8, GETDATE()), '6666-6666', 4),
		(18, 'Efectivo VIP', 16, 'tok_cash_vip', DATEADD(YEAR, 3, GETDATE()), 'EFECTIVO-VIP', 5),
		(19, 'VISA Classic ****7777', 17, 'tok_visa_7777', DATEADD(YEAR, 3, GETDATE()), '****-****-****-7777', 1),
		(20, 'Mastercard Standard ****8888', 18, 'tok_mc_8888', DATEADD(YEAR, 4, GETDATE()), '****-****-****-8888', 1),
		(21, 'PayPal Family', 19, 'tok_paypal_fam', DATEADD(YEAR, 2, GETDATE()), 'pp_adriana', 3),
		(22, 'Cuenta Popular', 20, 'tok_popular_999', DATEADD(YEAR, 5, GETDATE()), '****9999 (Popular)', 2),
		(23, 'Sinpe Móvil Popular', 21, 'tok_sinpe_pop', DATEADD(YEAR, 7, GETDATE()), '9999-9999', 4),
		(24, 'Efectivo Rápido', 22, 'tok_cash_fast', DATEADD(YEAR, 1, GETDATE()), 'EFECTIVO-FAST', 5),
		(25, 'VISA Oro ****0000', 23, 'tok_visa_0000', DATEADD(YEAR, 3, GETDATE()), '****-****-****-0000', 1),
		(26, 'Mastercard Oro ****1111', 24, 'tok_mc_1111', DATEADD(YEAR, 4, GETDATE()), '****-****-****-1111', 1),
		(27, 'PayPal Student', 25, 'tok_paypal_std', DATEADD(YEAR, 2, GETDATE()), 'pp_diana', 3),
		(28, 'Cuenta Nacional', 26, 'tok_nacional_222', DATEADD(YEAR, 5, GETDATE()), '****2222 (Nacional)', 2),
		(29, 'Sinpe Móvil Nacional', 27, 'tok_sinpe_nac', DATEADD(YEAR, 6, GETDATE()), '2222-2222', 4),
		(30, 'Efectivo Standard', 28, 'tok_cash_std', DATEADD(YEAR, 2, GETDATE()), 'EFECTIVO-STD', 5);
		SET IDENTITY_INSERT solturaDB.sol_availablePayMethods OFF;
    
		SET IDENTITY_INSERT solturaDB.sol_payments ON;
		INSERT INTO solturaDB.sol_payments (paymentID, availableMethodID, currency_id, amount, date_pay, confirmed, 
		result, auth, [reference], charge_token,[description], error, checksum, methodID)
		VALUES
		(1, 1, 1, 15000.00, GETDATE(), 1, 'Aprobado', 'AUTH123', 'REF-1001', 
		 CAST('charge_tok_123' AS VARBINARY(255)), 'Pago membresía básica', NULL, 
		 CAST('checksum_123' AS VARBINARY(250)), 1),
		(2, 3, 2, 50.00, DATEADD(DAY, -5, GETDATE()), 1, 'Completado', 'AUTH456', 'REF-1002', 
		 CAST('charge_tok_456' AS VARBINARY(255)), 'Pago membresía premium', NULL, 
		 CAST('checksum_456' AS VARBINARY(250)), 3),
		(3, 4, 1, 20000.00, DATEADD(DAY, -2, GETDATE()), 0, 'Procesando', 'AUTH789', 'REF-1003', 
		 CAST('charge_tok_789' AS VARBINARY(255)), 'Pago anual', NULL, 
		 CAST('checksum_789' AS VARBINARY(250)), 4),
		(4, 2, 1, 10000.00, DATEADD(DAY, -7, GETDATE()), 0, 'Rechazado', 'AUTH321', 'REF-1004', 
		 CAST('charge_tok_321' AS VARBINARY(255)), 'Pago servicios adicionales', 'Fondos insuficientes', 
		 CAST('checksum_321' AS VARBINARY(250)), 2),
		(5, 6, 1, 5000.00, DATEADD(DAY, -1, GETDATE()), 1, 'Completado', 'AUTH654', 'REF-1005', 
		 CAST('charge_tok_654' AS VARBINARY(255)), 'Pago en oficina', NULL, 
		 CAST('checksum_654' AS VARBINARY(250)), 5),
		 (6, 7, 2, 75.00, DATEADD(DAY, -10, GETDATE()), 1, 'Aprobado', 'AUTH202', 'REF-1006', 
		 CAST('charge_tok_202' AS VARBINARY(255)), 'Pago corporativo', NULL, 
		 CAST('checksum_202' AS VARBINARY(250)), 1),
    
		(7, 8, 1, 22000.00, DATEADD(DAY, -7, GETDATE()), 1, 'Completado', 'AUTH303', 'REF-1007', 
		 CAST('charge_tok_303' AS VARBINARY(255)), 'Pago anual premium', NULL, 
		 CAST('checksum_303' AS VARBINARY(250)), 1),
    
		(8, 9, 1, 12000.00, DATEADD(DAY, -4, GETDATE()), 1, 'Aprobado', 'AUTH404', 'REF-1008', 
		 CAST('charge_tok_404' AS VARBINARY(255)), 'Pago estudiantil', NULL, 
		 CAST('checksum_404' AS VARBINARY(250)), 3),
    
		(9, 10, 2, 60.00, DATEADD(DAY, -15, GETDATE()), 1, 'Completado', 'AUTH505', 'REF-1009', 
		 CAST('charge_tok_505' AS VARBINARY(255)), 'Pago promocional', NULL, 
		 CAST('checksum_505' AS VARBINARY(250)), 3),
    
		(10, 11, 1, 25000.00, DATEADD(DAY, -20, GETDATE()), 1, 'Aprobado', 'AUTH606', 'REF-1010', 
		 CAST('charge_tok_606' AS VARBINARY(255)), 'Pago gobierno', NULL, 
		 CAST('checksum_606' AS VARBINARY(250)), 2),
    
		(11, 12, 1, 17000.00, DATEADD(DAY, -1, GETDATE()), 0, 'Procesando', 'AUTH707', 'REF-1011', 
		 CAST('charge_tok_707' AS VARBINARY(255)), 'Pago semestral', NULL, 
		 CAST('checksum_707' AS VARBINARY(250)), 1),
    
		(12, 13, 2, 85.00, DATEADD(DAY, -2, GETDATE()), 0, 'Procesando', 'AUTH808', 'REF-1012', 
		 CAST('charge_tok_808' AS VARBINARY(255)), 'Pago internacional', NULL, 
		 CAST('checksum_808' AS VARBINARY(250)), 1),
    
		(13, 14, 1, 19000.00, DATEADD(DAY, -3, GETDATE()), 0, 'Procesando', 'AUTH909', 'REF-1013', 
		 CAST('charge_tok_909' AS VARBINARY(255)), 'Pago empresarial', NULL, 
		 CAST('checksum_909' AS VARBINARY(250)), 2),
    
		(14, 15, 1, 8000.00, DATEADD(DAY, -5, GETDATE()), 0, 'Procesando', 'AUTH010', 'REF-1014', 
		 CAST('charge_tok_010' AS VARBINARY(255)), 'Pago básico', NULL, 
		 CAST('checksum_010' AS VARBINARY(250)), 4),
    
		(15, 16, 2, 45.00, DATEADD(DAY, -8, GETDATE()), 0, 'Procesando', 'AUTH111', 'REF-1015', 
		 CAST('charge_tok_111' AS VARBINARY(255)), 'Pago prueba', NULL, 
		 CAST('checksum_111' AS VARBINARY(250)), 3),
		
		(16, 17, 1, 10000.00, DATEADD(DAY, -7, GETDATE()), 0, 'Rechazado', 'AUTH222', 'REF-1016', 
		 CAST('charge_tok_222' AS VARBINARY(255)), 'Pago servicios', 'Fondos insuficientes', 
		 CAST('checksum_222' AS VARBINARY(250)), 2),
    
		(17, 18, 1, 21000.00, DATEADD(DAY, -10, GETDATE()), 0, 'Rechazado', 'AUTH333', 'REF-1017', 
		 CAST('charge_tok_333' AS VARBINARY(255)), 'Pago anual plus', 'Tarjeta expirada', 
		 CAST('checksum_333' AS VARBINARY(250)), 1),
    
		(18, 19, 2, 55.00, DATEADD(DAY, -12, GETDATE()), 0, 'Rechazado', 'AUTH444', 'REF-1018', 
		 CAST('charge_tok_444' AS VARBINARY(255)), 'Pago membresía', 'Límite excedido', 
		 CAST('checksum_444' AS VARBINARY(250)), 3),
    
		(19, 20, 1, 13000.00, DATEADD(DAY, -15, GETDATE()), 0, 'Rechazado', 'AUTH555', 'REF-1019', 
		 CAST('charge_tok_555' AS VARBINARY(255)), 'Pago familiar', 'Cuenta suspendida', 
		 CAST('checksum_555' AS VARBINARY(250)), 4),
    
		(20, 21, 1, 9000.00, DATEADD(DAY, -18, GETDATE()), 0, 'Rechazado', 'AUTH666', 'REF-1020', 
		 CAST('charge_tok_666' AS VARBINARY(255)), 'Pago estudiantil', 'Autenticación fallida', 
		 CAST('checksum_666' AS VARBINARY(250)), 5),
    
		-- Pagos varios (21-25)
		(21, 22, 2, 65.00, DATEADD(DAY, -22, GETDATE()), 1, 'Completado', 'AUTH777', 'REF-1021', 
		 CAST('charge_tok_777' AS VARBINARY(255)), 'Pago promoción', NULL, 
		 CAST('checksum_777' AS VARBINARY(250)), 3),
    
		(22, 23, 1, 28000.00, DATEADD(DAY, -25, GETDATE()), 1, 'Aprobado', 'AUTH888', 'REF-1022', 
		 CAST('charge_tok_888' AS VARBINARY(255)), 'Pago corporativo plus', NULL, 
		 CAST('checksum_888' AS VARBINARY(250)), 1),
    
		(23, 24, 1, 7500.00, DATEADD(DAY, -30, GETDATE()), 0, 'Reembolsado', 'AUTH999', 'REF-1023', 
		 CAST('charge_tok_999' AS VARBINARY(255)), 'Pago especial', 'Reembolsado por solicitud', 
		 CAST('checksum_999' AS VARBINARY(250)), 2),
    
		(24, 25, 2, 95.00, DATEADD(DAY, -35, GETDATE()), 1, 'Completado', 'AUTH000', 'REF-1024', 
		 CAST('charge_tok_000' AS VARBINARY(255)), 'Pago internacional plus', NULL, 
		 CAST('checksum_000' AS VARBINARY(250)), 1),
    
		(25, 1, 1, 30000.00, DATEADD(DAY, -40, GETDATE()), 1, 'Aprobado', 'AUTH121', 'REF-1025', 
		 CAST('charge_tok_121' AS VARBINARY(255)), 'Pago anual gold', NULL, 
		 CAST('checksum_121' AS VARBINARY(250)), 1);
			SET IDENTITY_INSERT solturaDB.sol_payments OFF;

		SET IDENTITY_INSERT solturaDB.sol_deals ON;
		INSERT INTO solturaDB.sol_deals (dealId,partnerId,dealDescription,sealDate,endDate,solturaComission,discount,isActive)
		VALUES
		(1, 1, 'Promoción de verano: 15% descuento en membresías de gimnasio', 
		 '2023-06-01', '2023-08-31', 15.00, 15.00, 1),
		(2, 2, '2x1 en cines los miércoles', 
		 '2023-05-15', '2023-12-31', 10.00, 50.00, 1),
		(3, 3, '10% de descuento en compras mayores a ₡30,000', 
		 '2023-04-01', '2023-09-30', 12.50, 10.00, 1),
		(4, 4, 'Promoción Black Friday: 20% descuento en todos los servicios', 
		 '2023-11-01', '2023-11-30', 18.00, 20.00, 0), 
		(5, 5, 'Parqueo gratuito los fines de semana', 
		 '2023-07-01', '2024-01-31', 8.00, 100.00, 1),
		(6, 6, 'Combo familiar: 4 entradas + palomitas grandes + 4 bebidas', 
		 '2023-03-01', '2023-12-31', 12.00, 25.00, 1),
		(7, 7, 'Descuento del 15% en pedidos a través de la app', 
		 '2023-05-01', '2023-10-31', 10.00, 15.00, 1),
		(8, 1, 'Paquete deportivo: Gimnasio + Parqueo + Comida saludable', 
		 '2023-06-15', '2023-09-15', 20.00, 25.00, 1),
		(9, 1, 'Promoción de inicio de año: Matrícula gratis', 
		 '2023-01-01', '2023-01-31', 5.00, 100.00, 0),
		(10, 2, 'Descuentos para estudiantes los jueves', 
		 '2023-02-01', '2023-12-31', 7.50, 15.00, 1);
		SET IDENTITY_INSERT solturaDB.sol_deals OFF;
        
		SET IDENTITY_INSERT solturaDB.sol_featureTypes ON;
        INSERT INTO solturaDB.sol_featureTypes (featureTypeID, type)
		VALUES 
		(1, 'Gimnasios'),
		(2, 'Salud'),
		(3, 'Parqueos'),
		(4, 'Entretenimiento'),
		(5, 'Restaurantes'),
		(6, 'Viajes'),
		(7, 'Educación');
		SET IDENTITY_INSERT solturaDB.sol_featureTypes OFF;
		
		SET IDENTITY_INSERT solturaDB.sol_planFeatures ON;
		INSERT INTO solturaDB.sol_planFeatures (planFeatureID,dealId,description,unit,consumableQuantity,enabled,isRecurrent,scheduleID,featureTypeID)
		VALUES
		(1, 1, 'Acceso completo a instalaciones del gimnasio', 'visitas', 30, 1, 1, 1, 1),
		(2, 5, 'Acceso a áreas de parqueo exclusivas', 'horas', 60, 1, 1, 1, 2),
		(3, 1, 'Uso de instalaciones de spa y relajación', 'visitas', 4, 1, 1, 3, 3),
		(4, 1, 'Sesiones de masaje incluidas', 'sesiones', 2, 1, 1, 3, 4),
		(5, 8, 'Acceso a plataforma con entrenadores virtuales', 'sesiones', 12, 1, 1, 2, 5),
		(6, 6, 'Programas recreativos para niños', 'actividades', 8, 1, 1, 2, 6),
		(7, 5, 'Acceso a área de piscina familiar', 'visitas', 15, 1, 1, 1, 7);
		SET IDENTITY_INSERT solturaDB.sol_planFeatures OFF;

		SET IDENTITY_INSERT solturaDB.sol_featuresPerPlans ON;
		INSERT INTO solturaDB.sol_featuresPerPlans (featurePerPlansID,planFeatureID,planID,enabled)
		VALUES
		(1, 1, 1, 1),  
		(2, 2, 1, 1),  
		(3, 3, 1, 0),  
		(4, 1, 3, 1),
		(5, 2, 3, 1),
		(6, 3, 3, 1),  
		(7, 4, 3, 1), 
		(8, 1, 21, 1),
		(9, 5, 21, 1),
		(10, 6, 22, 1),
		(11, 7, 22, 1);
		SET IDENTITY_INSERT solturaDB.sol_featuresPerPlans OFF;
    
		SET IDENTITY_INSERT solturaDB.sol_featurePrices ON;
		INSERT INTO solturaDB.sol_featurePrices (featurePriceID,originalPrice,discountedPrice,finalPrice,currency_id,"current",variable,planFeatureID)
		VALUES
		(1, 15000.00, 13500.00, 13500.00, 1, 1, 0, 1),  
		(2, 5000.00, 5000.00, 5000.00, 1, 1, 0, 2), 
		(3, 20000.00, 18000.00, 18000.00, 1, 1, 0, 3), 
		(4, 10000.00, 10000.00, 10000.00, 1, 1, 1, 4), 
		(5, 30.00, 27.00, 27.00, 2, 1, 0, 1), 
		(6, 10.00, 9.00, 9.00, 2, 1, 0, 2),
		(7, 40.00, 36.00, 36.00, 2, 1, 0, 3), 
		(8, 8000.00, 7200.00, 7200.00, 1, 1, 0, 5), 
		(9, 12000.00, 10000.00, 10000.00, 1, 1, 0, 6), 
		(10, 15000.00, 12000.00, 12000.00, 1, 1, 0, 7);
		SET IDENTITY_INSERT solturaDB.sol_featurePrices OFF;

		SET IDENTITY_INSERT solturaDB.sol_featureAvailableLocations ON;
		INSERT INTO solturaDB.sol_featureAvailableLocations (locationID,featurePerPlanID,partnerAddressId,available)
		VALUES
		(1, 1, 1, 1),  
		(2, 1, 2, 1), 
		(3, 1, 5, 1),  
		(4, 2, 3, 1), 
		(5, 2, 5, 1), 
		(6, 3, 1, 1),
		(7, 10, 4, 1),
		(8, 11, 5, 1);
		SET IDENTITY_INSERT solturaDB.sol_featureAvailableLocations OFF;

        SET IDENTITY_INSERT solturaDB.sol_planTransactionTypes ON;
        INSERT INTO solturaDB.sol_planTransactionTypes (planTransactionTypeID, type)
        VALUES
        (1, 'Activación de plan'),
        (2, 'Renovación de plan'),
        (3, 'Upgrade de plan'),
        (4, 'Cancelación de plan'),
        (5, 'Pago de factura');
        SET IDENTITY_INSERT solturaDB.sol_planTransactionTypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactionTypes ON;
        INSERT INTO solturaDB.sol_transactionTypes (transactionTypeID, name)
        VALUES
        (1, 'Pago'),
        (2, 'Reembolso'),
        (3, 'Ajuste'),
        (4, 'Transferencia'),
        (5, 'Cargo recurrente');
        SET IDENTITY_INSERT solturaDB.sol_transactionTypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes ON;
        INSERT INTO solturaDB.sol_transactionSubtypes (transactionSubtypeID, name)
        VALUES
        (1, 'Tarjeta de crédito'),
        (2, 'Transferencia bancaria'),
        (3, 'Efectivo'),
        (4, 'Wallet digital'),
        (5, 'Pago móvil');
        SET IDENTITY_INSERT solturaDB.sol_transactionSubtypes OFF;

        SET IDENTITY_INSERT solturaDB.sol_planTransactions ON;
        INSERT INTO solturaDB.sol_planTransactions (planTransactionID,planTransactionTypeID,date,postTime,amount,checksum,userID,associateID,partnerAddressId)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 100.00, 0x123456, 1, 1, 1),
        (2, 2, '2023-02-20', GETDATE(), 120.00, 0x123457, 2, 2, 2),
        (3, 3, '2023-03-10', GETDATE(), 150.00, 0x123458, 3, 3, 3),
        (4, 4, '2023-04-05', GETDATE(), 0.00, 0x123459, 4, 4, NULL),
        (5, 5, '2023-05-12', GETDATE(), 80.00, 0x123460, 5, 5, 5);
        SET IDENTITY_INSERT solturaDB.sol_planTransactions OFF;

        SET IDENTITY_INSERT solturaDB.sol_transactions ON;
        INSERT INTO solturaDB.sol_transactions (transactionsID,payment_id,date,postTime,refNumber,user_id, checksum,exchangeRate,convertedAmount,
												transactionTypesID,transactionSubtypesID,amount,exchangeCurrencyID)
        VALUES
        (1, 1, '2023-01-15', GETDATE(), 'INV-001', 1, 0x654321, 1.0, 100.00, 1, 1, 100.00, 1),
        (2, 2, '2023-02-20', GETDATE(), 'INV-002', 2, 0x654322, 555.556, 55555.60, 1, 2, 100.00, 2),
        (3, 3, '2023-03-10', GETDATE(), 'INV-003', 3, 0x654323, 17.5, 1750.00, 1, 3, 100.00, 1),
        (4, 4, '2023-04-05', GETDATE(), 'RFND-001', 4, 0x654324, 555.556, 5555.56, 2, 4, 10.00, 2),
        (5, 5, '2023-05-12', GETDATE(), 'ADJ-001', 5, 0x654325, 1.0, 50.00, 3, 4, 50.00, 1);
        SET IDENTITY_INSERT solturaDB.sol_transactions OFF;

		SET IDENTITY_INSERT solturaDB.sol_balances ON;
		INSERT INTO solturaDB.sol_balances (balanceID,amount,expirationDate,lastUpdate,balanceTypeID,planFeatureID,userId)
		VALUES
		(1, 15000.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 1, 1, 1),
		(2, 12000.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 3, 2),
		(3, 18000.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 2, 3),
		(4, 9000.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 3, 5, 4),
		(5, 21000.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 6, 5),
		(6, 7500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 2, 4, 6),
		(7, 16500.00, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 4, 7, 7),
		(8, 13500.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 1, 7, 8),
		(9, 19500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 2, 3, 9),
		(10, 10500.00, DATEADD(MONTH, 5, GETDATE()), GETDATE(), 1, 1, 10),
		(11, 22500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 11),
		(12, 8500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 4, 12),
		(13, 17500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 2, 13),
		(14, 11500.00, DATEADD(MONTH, 7, GETDATE()), GETDATE(), 4, 7, 14),
		(15, 24500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 6, 15),
		(16, 9500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 2, 3, 16),
		(17, 15500.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 1, 2, 17),
		(18, 20500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 18),
		(19, 12500.00, DATEADD(MONTH, 3, GETDATE()), GETDATE(), 2, 4, 19),
		(20, 18500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 1, 1, 20),
		(21, 6500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 4, 7, 21),
		(22, 23500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 2, 22),
		(23, 14500.00, DATEADD(MONTH, 5, GETDATE()), GETDATE(), 2, 3, 23),
		(24, 9500.00, DATEADD(MONTH, 1, GETDATE()), GETDATE(), 1, 6, 24),
		(25, 21500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 3, 5, 25),
		(26, 13500.00, DATEADD(MONTH, 4, GETDATE()), GETDATE(), 1, 1, 26),
		(27, 17500.00, DATEADD(YEAR, 1, GETDATE()), GETDATE(), 2, 4, 27),
		(28, 10500.00, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 4, 7, 28),
		(29, 25500.00, DATEADD(YEAR, 2, GETDATE()), GETDATE(), 1, 1, 29),
		(30, 8500.00, DATEADD(MONTH, 2, GETDATE()), GETDATE(), 2, 3, 30);
		SET IDENTITY_INSERT solturaDB.sol_balances OFF;

        COMMIT TRANSACTION;
        PRINT 'Todas las tablas fueron pobladas exitosamente con el formato solicitado';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error al poblar las tablas: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
EXEC sp_PopulateTables;
```


---
## Demostraciones T-SQL
--



 1. Cursor local, mostrando que no es visible fuera de la sesi�n de la base de datos

Crea un cursor LOCAL que solo es visible dentro de la sesión actual, demostrando que no puede ser accedido desde otra sesión.

```sql
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
```



2. Cursor global, accesible desde otras sesiones de la base de datos

Crea un cursor GLOBAL que permanece accesible desde otras sesiones, permitiendo continuar el procesamiento donde se quedó.

```sql
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
```


3. Uso de un trigger (por ejemplo, para log de inserciones en pagos).

Crea un trigger AFTER INSERT que registra en una tabla de logs cada nuevo pago insertado en la tabla sol_payments.

```sql
    -- 3. Uso de un trigger (por ejemplo, para log de inserciones en pagos).
    USE solturaDB;
    GO
    ALTER TABLE solturaDB.sol_logs
    ALTER COLUMN computer NVARCHAR(75) NULL;
    ALTER TABLE solturaDB.sol_logs
    ALTER COLUMN trace NVARCHAR(100) NULL;
    ALTER TABLE solturaDB.sol_logs
    ALTER COLUMN checksum varbinary(250) NULL;
    GO
    CREATE OR ALTER TRIGGER tr_log_payment_insert_3
    ON solturaDB.sol_payments
    AFTER INSERT
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO solturaDB.sol_logs (
            description, 
            postTime, 
            computer, 
            username, 
            trace, 
            referenceId1, 
            value1, 
            checksum, 
            logSeverityID, 
            logTypesID, 
            logSourcesID
        )
        SELECT 
            'Nuevo pago - Monto: ' + CAST(ISNULL(i.amount, 0) AS VARCHAR) + ' ' + 
            ISNULL((SELECT TOP 1 acronym FROM solturaDB.sol_currencies WHERE currency_id = i.currency_id ORDER BY currency_id), 'UNK'),
            GETDATE(),
            ISNULL(HOST_NAME(), 'UNKNOWN'),
            ISNULL(SYSTEM_USER, 'system'),
            'PAYMENT_INSERT',
            i.paymentID,
            'M�todo: ' + ISNULL((SELECT TOP 1 name FROM solturaDB.sol_availablePayMethods 
                WHERE available_method_id = i.availableMethodID ORDER BY available_method_id), 'DESCONOCIDO'),
            HASHBYTES('SHA2_256', CAST(i.paymentID AS NVARCHAR(50)) + CAST(ISNULL(i.amount, 0) AS NVARCHAR(20))),
            ISNULL((SELECT TOP 1 logSererityID FROM solturaDB.sol_logsSererity WHERE name = 'Info' ORDER BY logSererityID), 1),
            ISNULL((SELECT TOP 1 logTypesID FROM solturaDB.sol_logTypes WHERE name = 'Payment' ORDER BY logTypesID), 1),
            ISNULL((SELECT TOP 1 logSourcesID FROM solturaDB.sol_logSources WHERE name = 'PaymentSystem' ORDER BY logSourcesID), 1)
        FROM inserted i;
    END;
    GO
```



 4. Uso de sp_recompile, c�mo podr�a estar recompilando todos los SP existentes cada cierto tiempo?

Genera dinámicamente un script para recompilar todos los procedimientos almacenados de la base de datos, útil para actualizar planes de ejecución.

```sql
    -- 4. Uso de sp_recompile, c�mo podr�a estar recompilando todos los SP existentes cada cierto tiempo?
    USE solturaDB;
    GO
    DECLARE @sql NVARCHAR(MAX) = '';
    SELECT @sql = @sql + 'EXEC sp_recompile ''' + SCHEMA_NAME(schema_id) + '.' + name + ''';' + CHAR(13)
    FROM solturaDB.sys.procedures;
    PRINT ' Script para recompilar todos los SPs:';
    PRINT @sql;
    EXEC sp_executesql @sql; -- Descomentar a su propio riesgo
    GO
```



5. Uso de MERGE para sincronizar datos de planes por ejemplo.

Sincroniza datos de planes entre una tabla origen y destino, actualizando registros existentes o insertando nuevos cuando no existen.

```sql
--5. Uso de MERGE para sincronizar datos de planes por ejemplo.
USE solturaDB;
GO
SET IDENTITY_INSERT solturaDB.sol_plans ON
MERGE INTO solturaDB.sol_plans AS target
USING (
    SELECT 21 AS planID, 'Joven Deportista - Atletas' AS description, 5 AS planTypeID UNION ALL
    SELECT 11, 'Full Modern Family - Familiar Plus', 4 UNION ALL
	SELECT 12, 'Professional Joven - Carrera', 4 UNION ALL
	SELECT 7, 'Plan Familiar (4 personas)', 4 UNION ALL
    SELECT 22, 'Familia de Verano (Vacacional)', 4 UNION ALL
    SELECT 23, 'Viajero Frecuente - Millas', 6 UNION ALL
	SELECT 30,  '    N�mada Digital - Remoto Global', 15 UNION ALL
    SELECT 24, 'N�mada Digital', 6
) AS source
ON target.planID = source.planID
WHEN MATCHED AND (target.description <> source.description OR target.planTypeID <> source.planTypeID) THEN
    UPDATE SET 
        target.description = source.description,
        target.planTypeID = source.planTypeID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (planID, description, planTypeID)
    VALUES (source.planID, source.description, source.planTypeID);
SET IDENTITY_INSERT solturaDB.sol_plans OFF
SELECT planID, description, planTypeID 
FROM solturaDB.sol_plans
ORDER BY planID;
GO
``` 



6. COALESCE para manejar valores nulos en configuraciones de usuario.

Maneja valores nulos en configuraciones de usuario devolviendo el primer valor no nulo de una lista de columnas/expresiones.

``` sql
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
``` 



7. SUBSTRING para extraer partes de descripciones.
8. LTRIM para limpiar strings.

Extrae partes de descripciones y limpia espacios en blanco al inicio de strings para presentación consistente.

``` sql
--7 SUBSTRING para extraer partes de descripciones.
--8 LTRIM para limpiar strings.
    USE solturaDB;
    GO
    SELECT 
        planID,
        description AS original_desc,
        LTRIM(description) AS cleaned_desc,
        SUBSTRING(LTRIM(description), 1, 20) AS short_desc,
        CASE 
            WHEN CHARINDEX('-', description) > 0 
            THEN SUBSTRING(description, CHARINDEX('-', description) + 1, LEN(description))
            WHEN CHARINDEX('(', description) > 0 
            THEN SUBSTRING(description, CHARINDEX('(', description), CHARINDEX(')', description) - CHARINDEX('(', description) + 1)
            ELSE ''
        END AS category_info
    FROM solturaDB.sol_plans;
    GO
``` 



9. AVG con agrupamiento (ej. promedio de montos pagados por usuario).

Calcula el promedio de montos pagados agrupados por usuario, mostrando también conteo y suma total.

``` sql
    --9. AVG con agrupamiento (ej. promedio de montos pagados por usuario).
    USE solturaDB;
    GO
    SELECT 
        u.userID,
        u.firstName + ' ' + u.lastName AS member_name,
        COUNT(p.paymentID) AS payment_count,
        AVG(p.amount) AS avg_payment_amount, -- aqui esta el avg :)
        SUM(p.amount) AS total_paid,
        (SELECT COUNT(*) FROM solturaDB.sol_userPlans up WHERE up.userID = u.userID) AS active_plans,
        STRING_AGG(apm.name, ', ') AS payment_methods_used
    FROM solturaDB.sol_users u
    JOIN solturaDB.sol_availablePayMethods apm ON u.userID = apm.userID
    JOIN solturaDB.sol_payments p ON apm.available_method_id = p.availableMethodID
    GROUP BY u.userID, u.firstName, u.lastName
    ORDER BY avg_payment_amount DESC;
    GO
``` 



10. TOP para mostrar top 5 planes m�s populares.

Selecciona solo los 5 planes más populares basados en cantidad de suscriptores, ordenados descendentemente.

```sql
    --10. TOP para mostrar top 5 planes m�s populares.
    USE solturaDB;
    GO
    SELECT TOP 5
        p.planID,
        p.description AS plan_name,
        pt.type AS plan_type,
        COUNT(up.userPlanID) AS subscriber_count,
        (SELECT AVG(pp.amount) 
        FROM solturaDB.sol_planPrices pp 
        WHERE pp.planID = p.planID AND pp."current" = 1) AS avg_price
    FROM solturaDB.sol_plans p
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
    LEFT JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    LEFT JOIN solturaDB.sol_userPlans up ON pp.planPriceID = up.planPriceID AND up.enabled = 1
    GROUP BY p.planID, p.description, pt.type
    ORDER BY subscriber_count DESC;
    GO
```




11. && en que caso se usa

No se utiliza && en T-SQL, si no que se usa AND. && genera error de sintaxis en T-SQL

```sql
--11. && en que caso se usa
print '   &&   no se usa en T-SQL, se utiliza AND, && da error de sintaxis'
```



12. SCHEMABINDING demostrar que efectivamente funciona en SPs, vistas, funciones.

Demuestra cómo previene modificaciones en tablas referenciadas por vistas, protegiendo la integridad de los objetos vinculados.

```sql
--12. SCHEMABINDING demostrar que efectivamente funciona en SPs, vistas, funciones.
USE solturaDB;
GO
IF OBJECT_ID('vw_member_subscriptions', 'V') IS NOT NULL
    DROP VIEW vw_member_subscriptions;
GO
CREATE VIEW vw_member_subscriptions
WITH SCHEMABINDING
AS
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    u.email,
    COUNT_BIG(*) AS subscription_count,
    SUM(CAST(pp.amount AS DECIMAL(10,2))) AS monthly_cost,
    MAX(up.adquisition) AS last_subscription_date
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_plans p ON pp.planID = p.planID
WHERE up.enabled = 1 AND pp.[current] = 1
GROUP BY u.userID, u.firstName, u.lastName, u.email;
GO

PRINT 'PRUEBA DE SCHEMABINDING ';
PRINT 'Intentando modificar una columna referenciada...';
GO
BEGIN TRY
    ALTER TABLE solturaDB.sol_users ALTER COLUMN firstName NVARCHAR(100);
    PRINT 'ERROR: SCHEMABINDING no est� funcionando (se permiti� la modificaci�n)';
END TRY
BEGIN CATCH
    PRINT 'SCHEMABINDING funciona correctamente:';
    PRINT 'Error: ' + ERROR_MESSAGE()  + '     <<<<<<<    prueba que el schemabinding funciona bien';
END CATCH;
GO
PRINT 'Vista en results table';
SELECT TOP 5 * FROM vw_member_subscriptions;
GO
```



 13. WITH ENCRYPTION demostrar que es posible encriptar un SP y que no lo violenten.    
 14. EXECUTE AS para ejecutar SP con impersonificaci�n, es posible? qu� significa eso

Muestra cómo encriptar el código de un procedimiento almacenado para proteger la propiedad intelectual y ejecuta un procedimiento con los permisos de otro usuario (impersonificación), permitiendo control granular de acceso.

```sql
    -- 13. WITH ENCRYPTION demostrar que es posible encriptar un SP y que no lo violenten.    
    -- 14. EXECUTE AS para ejecutar SP con impersonificaci�n, es posible? qu� significa eso
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
    --  Crea usuario (para impersonificaci�n)
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'app_executor')
        CREATE USER app_executor WITHOUT LOGIN;
    GO
    -- Otorgar permisos limitados a la tabla creada
    GRANT SELECT ON dbo.sol_payments TO app_executor;
    GO
    -- procedimiento con encriptaci�n y impersonificaci�n
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
    PRINT ' Confirmar que el c�digo est� encriptado (debe dar null en la tabla de results )';
    SELECT 
        OBJECT_NAME(object_id) AS Procedimiento,
        definition AS CodigoFuente
    FROM sys.sql_modules
    WHERE object_id = OBJECT_ID('sp_demo_secure');
    GO
    PRINT ''
    PRINT ' Ejecutar procedimiento ( como app_executor con impersonificaci�n , funciona) ';
    EXEC sp_demo_secure;
    PRINT 'es posible, EXECUTE AS ejecuta un procedimiento almacenado con los permisos de otro usuario diferente al que lo est� llamando, es decir, a traves de la impersonificaci�n puede ejecutar procedimientos, triggers y funciones.'
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

```



15. UNION entre planes individuales y empresariales por ejemplo. 

Combina resultados de consultas sobre planes básicos y familiares en un solo conjunto de resultados unificado.

```sql
--15. UNION entre planes individuales y empresariales por ejemplo. 
    USE solturaDB;
    GO
    SELECT 
        p.planID,
        p.description AS plan_name,
        'B�sico' AS plan_category,
        pp.amount AS monthly_price,
        (SELECT COUNT(*) 
        FROM solturaDB.sol_userPlans up
        JOIN solturaDB.sol_planPrices pp2 ON up.planPriceID = pp2.planPriceID
        WHERE pp2.planID = p.planID AND up.enabled = 1) AS subscribers
    FROM solturaDB.sol_plans p
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID AND pt.type LIKE '%B�sico%'
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    UNION ALL
    SELECT 
        p.planID,
        p.description AS plan_name,
        'Familiar' AS plan_category,
        pp.amount AS monthly_price,
        (SELECT COUNT(*) 
        FROM solturaDB.sol_userPlans up
        JOIN solturaDB.sol_planPrices pp2 ON up.planPriceID = pp2.planPriceID
        WHERE pp2.planID = p.planID AND up.enabled = 1) AS subscribers
    FROM solturaDB.sol_plans p
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID AND pt.type LIKE '%Familiar%'
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    ORDER BY plan_category, monthly_price DESC;
    GO
```



16. DISTINCT para evitar duplicados en servicios asignados por ejemplo.

 Elimina duplicados al listar características de planes, mostrando cada combinación única de feature, tipo y precio.

```sql
-- 16. DISTINCT para evitar duplicados en servicios asignados por ejemplo.
    USE solturaDB;
    GO
    SELECT DISTINCT
        pf.planFeatureID,
        pf.description AS feature,
        ft.type AS feature_type,
        fp.finalPrice AS base_price
    FROM solturaDB.sol_planFeatures pf
    JOIN solturaDB.sol_featureTypes ft ON pf.featureTypeID = ft.featureTypeID
    JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID AND fp."current" = 1
    JOIN solturaDB.sol_featuresPerPlans fpp ON pf.planFeatureID = fpp.planFeatureID
    JOIN solturaDB.sol_plans p ON fpp.planID = p.planID
    WHERE pf.enabled = 1
    ORDER BY feature_type, feature;
    GO

```
---
## Mantenimiento de la Seguridad


Crear usuarios de prueba


```sql
CREATE LOGIN usuario WITH PASSWORD = '654321';
CREATE LOGIN empleado WITH PASSWORD = '123456';
CREATE LOGIN manager WITH PASSWORD = '456789';


USE solturaDB;
CREATE USER usuario FOR LOGIN usuario;
CREATE USER empleado FOR LOGIN empleado;
CREATE USER manager FOR LOGIN manager;
```

Mostrar cómo permitir o denegar acceso a la base de datos, del todo poder verla o no, poder conectarse o no

```sql
-- Denegar acceso completo a la base de datos (revocar permisos de conexión)
DENY CONNECT TO usuario;

-- PRUEBA DE CONEXIÓN RESTRINGIDA
USE solturaDB;
EXECUTE AS USER = 'usuario';

SELECT firstName FROM solturaDB.sol_users; -- Cualquier consulta simple

-- Esto también verifica si el usuario puede conectarse a la DB
SELECT HAS_DBACCESS('usuario') AS TieneAcceso;

-- Luego para volver a permitir:
GRANT CONNECT TO usuario;
```


Conceder solo permisos de SELECT sobre una tabla a un usuario específico. Será posible crear roles y que existan roles que si puedan hacer ese select sobre esa tabla y otros Roles que no puedan? Demuestrelo con usuarios y roles pertinentes.

```

```

Permitir ejecución de ciertos SPs y denegar acceso directo a las tablas que ese SP utiliza, será que aunque tengo las tablas restringidas, puedo ejecutar el SP?

```

```

RLS - row level security

El RLS en el sistema de soltura se implementó de manera que cada usuario respectivo solo pueda ver los métodos de pago (tarjetas) que le pertenecen

```sql
-- Crear login a nivel de servidor
CREATE LOGIN admin WITH PASSWORD = 'admin123';

-- Crear usuario dentro de la base de datos 
USE solturaDB;
CREATE USER admin FOR LOGIN admin;

GRANT SELECT ON solturaDB.sol_availablePayMethods TO "admin";
GRANT SELECT ON solturaDB.sol_availablePayMethods TO usuario;


CREATE FUNCTION solturaDB.fn_filtrarPorUsuario(@user_id INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS permitido
    WHERE 
        (
            SESSION_CONTEXT(N'user_id') IS NOT NULL AND 
            @user_id = CAST(SESSION_CONTEXT(N'user_id') AS INT)
        )
        OR
        USER_NAME() = 'admin'
		OR USER_NAME() = 'dbo';


CREATE SECURITY POLICY solturaDB.securityPolicyAvailablePayMethods
ADD FILTER PREDICATE solturaDB.fn_filtrarPorUsuario(userID)
ON solturaDB.sol_availablePayMethods
WITH (STATE = ON);
```



```sql
--PRUEBAS 
-- Usuario sin session_context: no puede ver nada
EXECUTE AS USER = 'usuario';
EXEC sp_set_session_context @key = N'user_id', @value = NULL;
SELECT * FROM solturaDB.sol_availablePayMethods;  -- No mostrará resultados
REVERT;
```



```sql
-- Usuario con session_context: solo puede ver sus filas
EXECUTE AS USER = 'usuario';
EXEC sp_set_session_context @key = N'user_id', @value = 5;  -- Asignamos un user_id específico
SELECT * FROM solturaDB.sol_availablePayMethods;  -- Solo verá las filas con user_id = 5
REVERT;
```



```sql
-- Usuario admin: debe ver todas las filas
EXECUTE AS USER = 'admin';
EXEC sp_set_session_context @key = N'user_id', @value = NULL;
SELECT * FROM solturaDB.sol_availablePayMethods;  -- Verá todas las filas
REVERT;
```

Crear un certificado y llave asimétrica.
Crear una llave simétrica.
Cifrar datos sensibles usando cifrado simétrico y proteger la llave privada con las llaves asimétrica definidas en un certificado del servidor.

```sql
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'safePassword123';

CREATE CERTIFICATE CertificadoDeCifrado
WITH SUBJECT = 'Cifrado de Token';

CREATE ASYMMETRIC KEY SolturaLlaveAsimetrica
    WITH ALGORITHM = RSA_2048;

CREATE SYMMETRIC KEY SolturaLlaveSimetrica
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE CertificadoDeCifrado;
```

Crear un SP que descifre los datos protegidos usando las llaves anteriores.

Este SP lo que hace es descifrar los identificadores personales de cada usuario para canjear los beneficios de sus planes.

```sql
CREATE PROCEDURE solturaDB.SP_DesencriptarTokens
AS
BEGIN
    OPEN SYMMETRIC KEY SolturaLlaveSimetrica
    DECRYPTION BY CERTIFICATE CertificadoDeCifrado;

    SELECT 
        associateID,
        CONVERT(varchar, DecryptByKey(token)) AS token,
        userID,
        identificationTypeID
    FROM solturaDB.sol_userAssociateIdentifications;

    CLOSE SYMMETRIC KEY SolturaLlaveSimetrica;
END
```


---
## Consultas Misceláneas

1. 
Crear una vista indexada con al menos 4 tablas (ej. usuarios, suscripciones, pagos, servicios). La vista debe ser dinámica, no una vista materializada con datos estáticos. Demuestre que si es dinámica.
```sql
--Crear una vista indexada con al menos 4 tablas (ej. usuarios, suscripciones, pagos, servicios). La vista debe ser din�mica, no una vista materializada con datos estáticos. Demuestre que si es din�mica.
USE solturaDB;
GO
-- crea la vista con SCHEMABINDING
IF OBJECT_ID('dbo.vw_user_subscription_details', 'V') IS NOT NULL
    DROP VIEW dbo.vw_user_subscription_details;
GO
CREATE VIEW dbo.vw_user_subscription_details
WITH SCHEMABINDING
AS
SELECT 
    u.userID,
    u.firstName,
    u.lastName,
    u.email,
    p.planID,
    p.description AS planName,
    pt.type AS planType,
    pp.amount AS monthlyPrice,
    pp.planPriceID,
    up.userPlanID,
    p.planTypeID
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_plans p ON pp.planID = p.planID
JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
WHERE up.enabled = 1 AND pp.[current] = 1;
GO
CREATE UNIQUE CLUSTERED INDEX IX_vw_user_subscription_details       --aqui la indexaci�n
ON dbo.vw_user_subscription_details (userID, planID);
GO
IF OBJECT_ID('dbo.vw_user_subscription_aggregates', 'V') IS NOT NULL
    DROP VIEW dbo.vw_user_subscription_aggregates;
GO
CREATE VIEW dbo.vw_user_subscription_aggregates
AS
SELECT 
    v.userID,
    v.firstName + ' ' + v.lastName AS fullName,
    v.planName,
    v.planType,
    v.monthlyPrice,
    COUNT(fpp.featurePerPlansID) AS featureCount,
    SUM(CAST(fp.finalPrice AS DECIMAL(10,2))) AS totalFeatureValue
FROM dbo.vw_user_subscription_details v
JOIN solturaDB.sol_featuresPerPlans fpp ON v.planID = fpp.planID
JOIN solturaDB.sol_planFeatures pf ON fpp.planFeatureID = pf.planFeatureID
JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID AND fp.[current] = 1
GROUP BY v.userID, v.firstName, v.lastName, v.planName, v.planType, v.monthlyPrice;
GO
BEGIN TRANSACTION;
SELECT TOP 1 firstName, lastName, planName, monthlyPrice 
FROM dbo.vw_user_subscription_details 
WHERE userID = 1;
UPDATE solturaDB.sol_planPrices 
SET amount = amount * 1.1 -- Aumento del 10%
WHERE planPriceID IN (SELECT planPriceID FROM solturaDB.sol_userPlans WHERE userID = 1);
-- Ver cambios en la vista
SELECT TOP 1 firstName, lastName, planName, monthlyPrice 
FROM dbo.vw_user_subscription_details 
WHERE userID = 1;
ROLLBACK TRANSACTION; -- Revertir cambios de demostraci�n
-- Consultas de ejemplo usando la vista indexada
SELECT 
    planType,
    COUNT(DISTINCT userID) AS totalUsers,
    AVG(monthlyPrice) AS avgMonthlyPrice
FROM dbo.vw_user_subscription_details
GROUP BY planType
ORDER BY totalUsers DESC;
-- usando la vista de agregados
SELECT 
    planType,
    COUNT(DISTINCT userID) AS totalUsers,
    AVG(totalFeatureValue) AS avgFeatureValue
FROM dbo.vw_user_subscription_aggregates
GROUP BY planType
ORDER BY totalUsers DESC;
```

2.
Crear un procedimiento almacenado transaccional que realice una operación del sistema, relacionado a subscripciones, pagos, servicios, transacciones o planes, y que dicha operación requiera insertar y/o actualizar al menos 3 tablas.
```sql
--Crear un procedimiento almacenado transaccional que realice una operaci�n del sistema, relacionado a subscripciones, pagos, servicios, transacciones o planes, y que dicha operaci�n requiera insertar y/o actualizar al menos 3 tablas.
USE solturaDB;
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_RenovarSuscripcionAutomatica')
DROP PROCEDURE dbo.sp_RenovarSuscripcionAutomatica;
GO
CREATE PROCEDURE dbo.sp_RenovarSuscripcionAutomatica
    @userID INT,
    @planPriceID INT,
    @paymentMethodID INT,
    @currencyID INT,
    @resultado BIT OUTPUT,
    @mensaje VARCHAR(200) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @transactionID INT;
    DECLARE @paymentID INT;
    DECLARE @userPlanID INT;
    DECLARE @monto DECIMAL(12,2);
    DECLARE @planID INT;
    DECLARE @nuevoSaldo DECIMAL(10,2) = 0;
    DECLARE @token VARBINARY(255) = CONVERT(VARBINARY(255), 'AUTO_' + CONVERT(VARCHAR(36), NEWID()));
    DECLARE @checksum VARBINARY(250) = CONVERT(VARBINARY(250), HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), GETDATE())));
    DECLARE @refNumber VARCHAR(50) = 'REN-' + CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
    DECLARE @authCode VARCHAR(60) = 'AUTH-' + CONVERT(VARCHAR(20), GETDATE(), 112) + '-' + RIGHT('00000' + CAST(ABS(CHECKSUM(NEWID())) % 100000 AS VARCHAR(5)), 5);
    DECLARE @randomSubtype INT = CAST(ABS(CHECKSUM(NEWID())) % 5 + 1 AS INT);
	DECLARE @defaultScheduleID INT = (SELECT TOP 1 scheduleID FROM solturaDB.sol_schedules WHERE name = 'Renovaci�n Autom�tica');
        IF @defaultScheduleID IS NULL
    BEGIN
        INSERT INTO solturaDB.sol_schedules (
            name, repit, repetitions, recurrencyType, endDate, startDate
        )
        VALUES (
            'Renovaci�n Autom�tica', 0, 0, 0, DATEADD(YEAR, 10, GETDATE()), GETDATE()
        );
        SET @defaultScheduleID = SCOPE_IDENTITY();
    END
    BEGIN TRY
        BEGIN TRANSACTION;
        SELECT @monto = pp.amount, @planID = pp.planID
        FROM solturaDB.sol_planPrices pp
        WHERE pp.planPriceID = @planPriceID AND pp.[current] = 1;
        IF @monto IS NULL
        BEGIN
            SET @resultado = 0;
            SET @mensaje = 'El plan especificado no existe o no est� activo';
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_payments (
            availableMethodID, currency_id, amount, date_pay,
            confirmed, result, auth, reference,
            charge_token, description, error, checksum, methodID
        )
        VALUES (
            @paymentMethodID, @currencyID, @monto, GETDATE(),
            1, 'Renovaci�n autom�tica', @authCode, @refNumber,
            @token, 'Renovaci�n autom�tica', '', @checksum, @paymentMethodID
        );
        SET @paymentID = SCOPE_IDENTITY();
        SELECT @userPlanID = userPlanID 
        FROM solturaDB.sol_userPlans 
        WHERE userID = @userID AND enabled = 1;
        IF @userPlanID IS NOT NULL
        BEGIN
            UPDATE solturaDB.sol_userPlans
            SET planPriceID = @planPriceID,
                scheduleID = @defaultScheduleID, 
                adquisition = GETDATE(),
                enabled = 1
            WHERE userPlanID = @userPlanID;
        END
        ELSE
        BEGIN
            INSERT INTO solturaDB.sol_userPlans (
                userID, planPriceID, scheduleID, adquisition, enabled
            )
            VALUES (
                @userID, @planPriceID, @defaultScheduleID, GETDATE(), 1
            );
            SET @userPlanID = SCOPE_IDENTITY();
        END
        INSERT INTO solturaDB.sol_transactions (
            payment_id, date, postTime, refNumber,
            user_id, checksum, exchangeRate, convertedAmount,
            transactionTypesID, transactionSubtypesID, amount, exchangeCurrencyID
        )
        VALUES (
            @paymentID, GETDATE(), GETDATE(), @refNumber,
            @userID, @checksum, 1.0, @monto,
            1, @randomSubtype, @monto, @currencyID
        );
        SET @transactionID = SCOPE_IDENTITY();
        IF EXISTS (SELECT 1 FROM solturaDB.sol_balances WHERE userID = @userID AND balanceTypeID = 1 AND expirationDate > GETDATE())
        BEGIN
            UPDATE solturaDB.sol_balances
            SET amount = amount - @monto,
                lastUpdate = GETDATE()
            WHERE userID = @userID AND balanceTypeID = 1 AND expirationDate > GETDATE();

            SET @nuevoSaldo = (SELECT amount FROM solturaDB.sol_balances WHERE userID = @userID AND balanceTypeID = 1);
        END
        -- Registrar en logs
        INSERT INTO solturaDB.sol_logs (
            description, postTime, computer, username,
            trace, referenceId1, referenceId2, value1,
            checksum, logSeverityID, logTypesID, logSourcesID
        )
        VALUES (
            'Renovaci�n autom�tica', GETDATE(), HOST_NAME(), SYSTEM_USER,
            '', @userID, @transactionID, CAST(@monto AS VARCHAR(50)),
            @checksum, 1, 3, 1
        );
        COMMIT TRANSACTION;
        SET @resultado = 1;
        SET @mensaje = 'Renovaci�n exitosa. Nuevo saldo: ' + ISNULL(CAST(@nuevoSaldo AS VARCHAR(20)), '0.00');
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @resultado = 0;
        SET @mensaje = 'Error al renovar suscripci�n: ' + ERROR_MESSAGE();
        INSERT INTO solturaDB.sol_logs (
            description, postTime, computer, username,
            trace, referenceId1, value1, value2,
            checksum, logSeverityID, logTypesID, logSourcesID
        )
        VALUES (
            'Error en renovaci�n autom�tica', GETDATE(), HOST_NAME(), SYSTEM_USER,
            '', @userID, ERROR_MESSAGE(), ERROR_PROCEDURE(),
            @checksum, 3, 3, 1
        );
    END CATCH
END;
GO
DECLARE @resultado BIT, @mensaje VARCHAR(200);
IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_users WHERE userID = 1)
    INSERT INTO solturaDB.sol_users (userID, email, firstName, lastName, password, enabled)
    VALUES (1, 'test@example.com', 'Test', 'User', 0x00, 1);
IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_planPrices WHERE planPriceID = 1)
    INSERT INTO solturaDB.sol_planPrices (planPriceID, planID, amount, currency_id, postTime, "current")
    VALUES (1, 1, 100.00, 1, GETDATE(), 1);

-- ejecucion de procedimiento
EXEC dbo.sp_RenovarSuscripcionAutomatica 
    @userID = 1,
    @planPriceID = 1,
    @paymentMethodID = 1,
    @currencyID = 1,
    @resultado = @resultado OUTPUT,
    @mensaje = @mensaje OUTPUT;
-- resultados
SELECT 
    'Resultado' = CASE WHEN @resultado = 1 THEN '�xito' ELSE 'Fallo' END,
    'Mensaje' = @mensaje,
    'Detalles' = 'PagoID: ' + ISNULL((SELECT TOP 1 CAST(paymentID AS VARCHAR) FROM solturaDB.sol_payments ORDER BY paymentID DESC), 'N/A') +
                ', TransID: ' + ISNULL((SELECT TOP 1 CAST(transactionsID AS VARCHAR) FROM solturaDB.sol_transactions ORDER BY transactionsID DESC), 'N/A') +
                ', UserPlan: ' + ISNULL((SELECT TOP 1 CAST(userPlanID AS VARCHAR) FROM solturaDB.sol_userPlans ORDER BY userPlanID DESC), 'N/A');

-- detalles de las tablas afectadas
SELECT TOP 1 
    '�ltimo Pago' = 'ID: ' + CAST(paymentID AS VARCHAR) + 
                   ', Monto: ' + CAST(amount AS VARCHAR) + 
                   ', M�todo: ' + CAST(methodID AS VARCHAR) + 
                   ', Fecha: ' + CONVERT(VARCHAR, date_pay, 120)
FROM solturaDB.sol_payments 
ORDER BY paymentID DESC;
SELECT TOP 1 
    '�ltima Transacci�n' = 'ID: ' + CAST(t.transactionsID AS VARCHAR) + 
                         ', Monto: ' + CAST(t.amount AS VARCHAR) + 
                         ', Tipo: ' + ISNULL(tt.name, 'N/A') + 
                         ', Fecha: ' + CONVERT(VARCHAR, t.date, 120)
FROM solturaDB.sol_transactions t
LEFT JOIN solturaDB.sol_transactionTypes tt ON t.transactionTypesID = tt.transactionTypeID
ORDER BY t.transactionsID DESC;
SELECT TOP 1 
    'UserPlan Actualizado' = 'ID: ' + CAST(up.userPlanID AS VARCHAR) + 
                           ', PlanID: ' + CAST(up.planPriceID AS VARCHAR) + 
                           ', ScheduleID: ' + CAST(up.scheduleID AS VARCHAR) + 
                           ', Estado: ' + CASE WHEN up.enabled = 1 THEN 'Activo' ELSE 'Inactivo' END
FROM solturaDB.sol_userPlans up
ORDER BY up.userPlanID DESC;

```

3. 
Escribir un SELECT que use CASE para crear una columna calculada que agrupe dinámicamente datos (por ejemplo, agrupar cantidades de usuarios por plan en rangos de monto, no use este ejemplo).
```sql
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

```

4. 
```sql
```

5. 
```sql
```

6. 
Crear un procedimiento almacenado transaccional que llame a otro SP transaccional, el cual a su vez llame a otro SP transaccional. Cada uno debe modificar al menos 2 tablas. Se debe demostrar que es posible hacer COMMIT y ROLLBACK con ejemplos exitosos y fallidos sin que haya interrumpción de la ejecución correcta de ninguno de los SP en ninguno de los niveles del llamado.

```sql
USE solturaDB;
GO

CREATE OR ALTER PROCEDURE sp_RegistrarPago
    @AvailableMethodID INT,
    @CurrencyID INT,
    @Amount DECIMAL(10,2),
    @Description NVARCHAR(255),
    @UserID INT,
    @PaymentID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_availablePayMethods WHERE available_method_id = @AvailableMethodID AND userID = @UserID)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'M�todo de pago no disponible para el usuario';
            ROLLBACK;
            RETURN;
        END
        DECLARE @MethodID INT;
        SELECT @MethodID = methodID FROM solturaDB.sol_availablePayMethods WHERE available_method_id = @AvailableMethodID;

        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_payMethod WHERE payMethodID = @MethodID AND enabled = 1)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'M�todo de pago no habilitado';
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_payments (
            availableMethodID, currency_id, amount, date_pay, confirmed,
            result, auth, [reference], charge_token, [description],
            error, checksum, methodID
        )
        VALUES (
            @AvailableMethodID, @CurrencyID, @Amount, GETDATE(), 0,
            'Procesando', NEWID(), 'REF-' + CAST(NEXT VALUE FOR sol_payment_ref_seq AS NVARCHAR(20)),
            CAST('charge_tok_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(255)),
            @Description, NULL,
            CAST('checksum_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(250)),
            @MethodID
        );

        SET @PaymentID = SCOPE_IDENTITY();

        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Pago registrado exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;

        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_RegistrarPago: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ProcesarCompraDeal
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @PaymentID INT;
    DECLARE @CurrencyID INT = 1;
    DECLARE @Amount DECIMAL(10,2);
    DECLARE @PartnerID INT;
    DECLARE @Comision DECIMAL(5,2);
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM solturaDB.sol_deals WHERE dealId = @DealID AND isActive = 1)
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Deal no disponible o no activo';
            ROLLBACK;
            RETURN;
        END
        SELECT
            @Amount = fp.finalPrice,
            @PartnerID = d.partnerId,
            @Comision = d.solturaComission
        FROM solturaDB.sol_deals d
        JOIN solturaDB.sol_planFeatures pf ON d.dealId = pf.dealId
        JOIN solturaDB.sol_featurePrices fp ON pf.planFeatureID = fp.planFeatureID
        WHERE d.dealId = @DealID AND fp."current" = 1;

        DECLARE @DescriptionDeal NVARCHAR(255);
        SET @DescriptionDeal = 'Compra de deal ' + CAST(@DealID AS NVARCHAR);

        EXEC sp_RegistrarPago
            @AvailableMethodID, @CurrencyID, @Amount,
            @DescriptionDeal, @UserID,
            @PaymentID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;

        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        INSERT INTO solturaDB.sol_transactions (
            payment_id, date, postTime, refNumber, user_id, checksum,
            exchangeRate, convertedAmount, transactionTypesID,
            transactionSubtypesID, amount, exchangeCurrencyID
        )
        VALUES (
            @PaymentID, GETDATE(), GETDATE(), 'TXN-' + CONVERT(NVARCHAR(20), NEXT VALUE FOR sol_txn_ref_seq),
            @UserID, CAST('checksum_txn_' + CAST(NEWID() AS NVARCHAR(50)) AS VARBINARY(250)),
            1.0, @Amount, 1,
            CASE
                WHEN @AvailableMethodID IN (1,4,7,13) THEN 1 -- Tarjeta de cr�dito
                WHEN @AvailableMethodID IN (2,10,16) THEN 2 -- Transferencia bancaria
                WHEN @AvailableMethodID IN (5,6,12) THEN 3 -- Efectivo
                ELSE 4 
            END,
            @Amount, 1
        );
        SET @TransactionID = SCOPE_IDENTITY();
        DECLARE @ComisionAmount DECIMAL(10,2) = @Amount * (@Comision / 100);

        INSERT INTO solturaDB.sol_balances (
            amount, expirationDate, lastUpdate, balanceTypeID, userId
        )
        VALUES (
            @ComisionAmount, DATEADD(MONTH, 6, GETDATE()), GETDATE(), 1, @UserID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra de deal procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ProcesarCompraDeal: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ComprarDealPremium
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM solturaDB.sol_userPlans up
            JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
            JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
            WHERE up.userID = @UserID
            AND up.enabled = 1
            AND pt.type IN ('Premium', 'Gold - Acceso Total', 'Empresarial Avanzado')
        )
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Usuario no tiene un plan premium para acceder a este deal';
            ROLLBACK;
            RETURN;
        END
        EXEC sp_ProcesarCompraDeal
            @DealID, @UserID, @AvailableMethodID,
            @TransactionID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;
        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        UPDATE solturaDB.sol_payments
        SET confirmed = 1, result = 'Aprobado'
        WHERE paymentID = (
            SELECT payment_id FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra premium procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ComprarDealPremium: ' + ERROR_MESSAGE();
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE sp_ComprarDealPremium
    @DealID INT,
    @UserID INT,
    @AvailableMethodID INT,
    @TransactionID INT OUTPUT,
    @Exito BIT OUTPUT,
    @Mensaje NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM solturaDB.sol_userPlans up
            JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
            JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
            WHERE up.userID = @UserID
            AND up.enabled = 1
            AND pt.type IN ('Premium', 'Gold - Acceso Total', 'Empresarial Avanzado')
        )
        BEGIN
            SET @Exito = 0;
            SET @Mensaje = 'Usuario no tiene un plan premium para acceder a este deal';
            ROLLBACK;
            RETURN;
        END
        EXEC sp_ProcesarCompraDeal
            @DealID, @UserID, @AvailableMethodID,
            @TransactionID OUTPUT, @Exito OUTPUT, @Mensaje OUTPUT;
        IF @Exito = 0
        BEGIN
            ROLLBACK;
            RETURN;
        END
        UPDATE solturaDB.sol_payments
        SET confirmed = 1, result = 'Aprobado'
        WHERE paymentID = (
            SELECT payment_id FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID
        );
        COMMIT;
        SET @Exito = 1;
        SET @Mensaje = 'Compra premium procesada exitosamente';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        SET @Exito = 0;
        SET @Mensaje = 'Error en sp_ComprarDealPremium: ' + ERROR_MESSAGE();
    END CATCH
END;
GO



--Probar los procedures -> Esta ejecuci�n fallar�, puesto que un usuario con un plan no premiun, intenta acceder a un plan premiun
DECLARE @TransactionID INT, @Exito BIT, @Mensaje NVARCHAR(500);
EXEC sp_ComprarDealPremium 
    @DealID = 1, 
    @UserID = 2, 
    @AvailableMethodID = 2,
    @TransactionID = @TransactionID OUTPUT, 
    @Exito = @Exito OUTPUT, 
    @Mensaje = @Mensaje OUTPUT;
SELECT @Exito AS Exito, @Mensaje AS Mensaje, @TransactionID AS TransactionID;
SELECT * FROM solturaDB.sol_payments WHERE paymentID IN (SELECT payment_id 
														FROM solturaDB.sol_transactions 
														WHERE transactionsID = @TransactionID);
SELECT * FROM solturaDB.sol_transactions WHERE transactionsID = @TransactionID;
```

7. 
Será posible que haciendo una consulta SQL en esta base de datos se pueda obtener un JSON para ser consumido por alguna de las pantallas de la aplicación que tenga que ver con los planes, subscripciones, servicios o pagos. Justifique cuál pantalla podría requerir esta consulta.

Esta consulta puede ser requerida en alguna pantalla cuando algún usuario quiera ver información sobre su supscripción actual.
```sql
USE solturaDB;
GO

DECLARE @UserID INT = 1;

SELECT
    (SELECT TOP 1
        p.description AS planName,
        pt.type AS planType,
        pp.amount AS planAmount,
        c.symbol AS currencySymbol
    FROM solturaDB.sol_userPlans up
    JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    JOIN solturaDB.sol_currencies c ON pp.currency_id = c.currency_id
    WHERE up.userID = @UserID AND up.enabled = 1
    ORDER BY up.adquisition DESC
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS planInfo,
    (SELECT
        pf.description AS featureDescription,
        ft.type AS featureType,
        (SELECT TOP 1 fp.finalPrice FROM solturaDB.sol_featurePrices fp 
		JOIN solturaDB.sol_planFeatures plf ON fp.planFeatureID = plf.planFeatureID 
		WHERE plf.planFeatureID = fpp.planFeatureID AND fp."current" = 1 ORDER BY fp.featurePriceID DESC) AS featurePrice
    FROM solturaDB.sol_featuresPerPlans fpp
    JOIN solturaDB.sol_planFeatures pf ON fpp.planFeatureID = pf.planFeatureID
    JOIN solturaDB.sol_featureTypes ft ON pf.featureTypeID = ft.featureTypeID
    WHERE fpp.planID = (SELECT TOP 1 up.planPriceID FROM solturaDB.sol_userPlans up 
						WHERE up.userID = @UserID AND up.enabled = 1 ORDER BY up.adquisition DESC)
    FOR JSON PATH) AS features,
    (SELECT TOP 5 -- Obtener los 5 pagos m�s recientes
        pay.paymentID,
        pay.date_pay,
        pay.amount,
        c2.symbol AS paymentCurrencySymbol,
        pay.result,
        pm.name AS paymentMethod
    FROM solturaDB.sol_payments pay
    JOIN solturaDB.sol_availablePayMethods apm ON pay.availableMethodID = apm.available_method_id
    JOIN solturaDB.sol_payMethod pm ON apm.methodID = pm.payMethodID
    JOIN solturaDB.sol_currencies c2 ON pay.currency_id = c2.currency_id
    WHERE apm.userID = @UserID
    ORDER BY pay.date_pay DESC
    FOR JSON PATH) AS recentPayments
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
GO



--Esta consulta puede ser requerida en alguna pantalla cuando alg�n usuario quiera ver informaci�n sobre su supscripci�n actual
```

8. 
Podrá su base de datos soportar un SP transaccional que actualice los contratos de servicio de un proveedor, el proveedor podría ya existir o ser nuevo, si es nuevo, solo se inserta. Las condiciones del contrato del proveedor, deben ser suministradas por un Table-Valued Parameter (TVP), si las condiciones son sobre items existentes, entonces se actualiza o inserta realizando las modificacinoes que su diseño requiera, si son condiciones nuevas, entonces se insertan.
```sql
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



--Forma de probar el query :D 
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
```

9. 
```sql
```

10. 
Configurar una tabla de bitácora en otro servidor SQL Server accesible vía Linked Servers con impersonación segura desde los SP del sistema. Ahora haga un SP genérico para que cualquier SP en el servidor principal, pueda dejar bitácora en la nueva tabla que se hizo en el Linked Server.
```sql
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
```



---
## Concurrencia

---
# Adquisiones en Costa Rica y Migración de datos

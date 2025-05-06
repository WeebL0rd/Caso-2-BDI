
-- 1. CREACIÓN DE USUARIOS Y CONTROL DE ACCESO

-- Crear login y usuarios de prueba
CREATE LOGIN usuario WITH PASSWORD = '654321';
CREATE LOGIN empleado WITH PASSWORD = '123456';
CREATE LOGIN manager WITH PASSWORD = '456789';


USE solturaDB;
CREATE USER usuario FOR LOGIN usuario;
CREATE USER empleado FOR LOGIN empleado;
CREATE USER manager FOR LOGIN manager;

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

-- Regresar a la cuenta de administrador
REVERT;








-- 2. PERMISOS SELECT Y ROLES PERSONALIZADOS

-- Quitar permisos por defecto para hacer SELECT en sol_payments
REVOKE SELECT ON solturaDB.sol_payments TO PUBLIC;

-- Otorgar solo a manager
GRANT SELECT ON solturaDB.sol_payments TO manager;


-- PRUEBAS DE PERMISO DE SELECT A UN USUARIO ESPECÍFICO
-- Ejemplo con la tabla de pagos, que contiene la información de los pagos realizados
-- usuario no podrá acceder
EXECUTE AS USER = 'usuario';
SELECT * FROM solturaDB.sol_payments; -- Error
REVERT;

-- empleado no podrá acceder
EXECUTE AS USER = 'empleado';
SELECT * FROM solturaDB.sol_payments; -- Error
REVERT;

-- manager sí podrá
EXECUTE AS USER = 'manager';
SELECT * FROM solturaDB.sol_payments; -- OK
REVERT;




-- ROLES PERSONALIZADOS
-- Crear dos roles
USE solturaDB;
CREATE ROLE AccesoRestringido;
CREATE ROLE SoloLectura;

-- Conceder permiso SELECT al rol SoloLectura
ALTER ROLE AccesoRestringido ADD MEMBER usuario;
ALTER ROLE SoloLectura ADD MEMBER empleado;

DENY SELECT ON solturaDB.sol_payments TO AccesoRestringido;
GRANT SELECT ON solturaDB.sol_payments TO SoloLectura;


-- PRUEBAS DE PERMISO DE SELECT A UN USUARIO ESPECÍFICO

-- usuario en rol AccesoRestringido
EXECUTE AS USER = 'usuario';
SELECT * FROM solturaDB.sol_payments; -- Denegado
REVERT;

-- empleado en rol SoloLectura (antes tenía restringido el acceso a la tabla, pero ahora accede por el rol)
EXECUTE AS USER = 'empleado';
SELECT * FROM solturaDB.sol_payments; -- OK
REVERT;










-- 3. PERMISOS SOBRE STORED PROCEDURES

-- Denegar acceso a las tablas
DENY SELECT ON solturaDB.sol_deals TO usuario;
DENY SELECT ON solturaDB.sol_partners TO usuario;


-- Crear SP 
CREATE PROCEDURE [solturaDB].[SP_verDealsdePartners]
WITH EXECUTE AS OWNER
AS
BEGIN
	SET NOCOUNT ON

    SELECT p.name AS "Partner", d.dealDescription, d.sealDate, d.endDate, d.discount, d.solturaComission, d.isActive
	FROM sol_deals d
	INNER JOIN sol_partners p ON d.partnerId = p.partnerId 
END;

-- PRUEBAS DE EJECUCIÓN

-- el usuario no puede utilizar el SP si no se le da permiso explícitamete
-- Actuar como el usuario sin permiso
EXECUTE AS USER = 'usuario';

-- Probar acceso directo a las tablas (esperado: error)
SELECT * FROM solturaDB.sol_deals;       
SELECT * FROM solturaDB.sol_partners;   
-- Probar ejecución del SP 
EXEC solturaDB.SP_verDealsdePartners;        -- Error: no tiene permiso

REVERT;

-- Con el permiso, ya debe poder ejecutarlo
GRANT EXECUTE ON solturaDB.SP_verDealsdePartners TO AccesoRestringido;

-- Actuar como el usuario nuevamente
EXECUTE AS USER = 'usuario';

-- Probar SP otra vez (esperado: funciona)
EXEC solturaDB.SP_verDealsdePartners;      
-- Probar acceso directo (sigue sin funcionar)
SELECT * FROM solturaDB.sol_deals;       
SELECT * FROM solturaDB.sol_partners;    

REVERT;

select * from solturaDB.sol_balances;




-- PARA BORRAR
USE solturaDB;
GRANT SELECT ON solturaDB.sol_payments TO PUBLIC;

DROP PROCEDURE solturaDB.SP_verDealsdePartners;

DROP ROLE AccesoRestringido;
DROP ROLE SoloLectura;

DROP USER usuario;
DROP USER empleado;
DROP USER manager;

USE master;

DROP LOGIN usuario;
DROP LOGIN empleado;
DROP LOGIN manager;



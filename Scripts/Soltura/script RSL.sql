-- 4. ROW LEVEL SECURITY

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

--PRUEBAS 
-- Usuario sin session_context: no puede ver nada
EXECUTE AS USER = 'usuario';
EXEC sp_set_session_context @key = N'user_id', @value = NULL;
SELECT * FROM solturaDB.sol_availablePayMethods;  -- No mostrar� resultados
REVERT;


-- Usuario con session_context: solo puede ver sus filas
EXECUTE AS USER = 'usuario';
EXEC sp_set_session_context @key = N'user_id', @value = 5;  -- Asignamos un user_id espec�fico
SELECT * FROM solturaDB.sol_availablePayMethods;  -- Solo ver� las filas con user_id = 5
REVERT;


-- Usuario admin: debe ver todas las filas
EXECUTE AS USER = 'admin';
EXEC sp_set_session_context @key = N'user_id', @value = NULL;
SELECT * FROM solturaDB.sol_availablePayMethods;  -- Ver� todas las filas
REVERT;


---- Eliminar la pol�tica de RLS
--DROP SECURITY POLICY solturaDB.securityPolicyAvailablePayMethods;

---- Eliminar la funci�n RLS
--DROP FUNCTION solturaDB.fn_filtrarPorUsuario;


---- Primero, debemos eliminar el usuario de la base de datos
--USE solturaDB;
--DROP USER admin;

---- Luego, eliminamos el login asociado
--DROP LOGIN admin;
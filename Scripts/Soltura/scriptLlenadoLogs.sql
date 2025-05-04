USE solturaDB;
GO
-- Insertar fuentes comunes de logs (sol_logSources)
INSERT INTO solturaDB.sol_logSources ( name)
VALUES 
    ('PaymentSystem'),     -- Sistema de pagos
    ( 'UserManagement'),    -- Gestión de usuarios
    ( 'Subscription'),      -- Sistema de suscripciones
    ( 'API'),               -- Llamadas a la API
    ( 'Database'),          -- Operaciones de base de datos
    ( 'Scheduler'),         -- Procesos programados
    ( 'MobileApp'),         -- Aplicación móvil
    ( 'WebPortal');         -- Portal web

-- Insertar tipos de logs con descripciones (sol_logTypes)
INSERT INTO solturaDB.sol_logTypes (
    name, 
    reference1Description, 
    reference2Description, 
    value1Description, 
    value2Description
)
VALUES 
    ( 'Payment', 'PaymentID', 'UserID', 'Amount', 'PaymentMethod'),  -- Registros de pagos
    ( 'User', 'UserID', 'RoleID', 'Action', 'Details'),              -- Acciones de usuario
    ( 'Subscription', 'PlanID', 'UserID', 'OldPlan', 'NewPlan'),     -- Cambios de suscripción
    ( 'Error', 'ErrorCode', 'LineNumber', 'Message', 'Context'),     -- Errores del sistema
    ( 'Audit', 'EntityID', 'ModifiedBy', 'FieldChanged', 'NewValue'),-- Auditorías
    ( 'Security', 'UserID', 'IPAddress', 'Action', 'Status'),        -- Eventos de seguridad
    ( 'APIRequest', 'Endpoint', 'Status', 'Parameters', 'Response'), -- Llamadas API
    ( 'Maintenance', 'TaskID', 'Duration', 'Details', 'Result');     -- Mantenimiento

-- Insertar niveles de severidad estándar
INSERT INTO solturaDB.sol_logsSererity ( name)
VALUES 
    ( 'Info'),       -- Información general
    ( 'Warning'),    -- Advertencia
    ( 'Error'),      -- Error
    ( 'Critical'),   -- Error crítico
    ( 'Debug');      -- Depuración


USE solturaDB;
GO
-- Insertar fuentes comunes de logs (sol_logSources)
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


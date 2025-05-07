SELECT
    r.session_id,
    r.blocking_session_id,
    r.status,
    r.wait_type,
    t.text AS running_sql
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.status = 'suspended';

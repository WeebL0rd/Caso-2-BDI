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
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
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


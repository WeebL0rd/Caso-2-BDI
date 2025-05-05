--10. TOP para mostrar top 5 planes más populares.
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
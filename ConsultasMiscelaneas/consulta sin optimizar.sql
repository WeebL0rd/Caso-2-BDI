
WITH ActivePlans AS (
    SELECT userID, planPriceID
    FROM solturaDB.sol_userPlans
    WHERE adquisition > '2024-01-01'
),
UserTotalPayments AS (
    SELECT user_id, SUM(amount) AS total_paid
    FROM solturaDB.sol_transactions
    GROUP BY user_id
),
HighSpenders AS (
    SELECT user_id
    FROM solturaDB.sol_transactions
    GROUP BY user_id
    HAVING SUM(amount) > 150000
)
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    COUNT(DISTINCT up.planPriceID) AS totalPlans,
    AVG(CAST(pp.amount AS FLOAT)) AS avgPlanAmount,
    SUM(p.amount) AS totalPayments,
    CASE 
        WHEN ut.total_paid > 250000 THEN 'VIP'
        WHEN ut.total_paid > 100000 THEN 'Premium'
        ELSE 'Standard'
    END AS userTier,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM HighSpenders hs 
            WHERE hs.user_id = u.userID
        ) THEN 1
        ELSE 0
    END AS isHighSpender
FROM solturaDB.sol_users u
JOIN solturaDB.sol_userPlans up ON u.userID = up.userID
JOIN solturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
JOIN solturaDB.sol_transactions t ON u.userID = t.user_id
JOIN solturaDB.sol_payments p ON t.payment_id = p.paymentID
LEFT JOIN UserTotalPayments ut ON u.userID = ut.user_id
WHERE p.confirmed = 1 
  AND u.email NOT IN ('test@example.com', 'spam@example.com')
GROUP BY u.userID, u.firstName, u.lastName, ut.total_paid
ORDER BY totalPayments DESC;

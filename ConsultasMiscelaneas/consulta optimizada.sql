USE solturaDB;
GO

;WITH ValidPayments AS (
    SELECT p.paymentID, p.amount, t.user_id
    FROM SolturaDB.sol_payments p
    INNER JOIN SolturaDB.sol_transactions t ON p.paymentID = t.payment_id
    WHERE p.confirmed = 1
),
UserTotalPayments AS (
    SELECT user_id, SUM(amount) AS total_paid
    FROM ValidPayments
    GROUP BY user_id
),
ActivePlans AS (
    SELECT userID, planPriceID
    FROM SolturaDB.sol_userPlans
    WHERE adquisition > '2024-01-01'
),
PlanAmounts AS (
    SELECT planPriceID, amount
    FROM SolturaDB.sol_planPrices
),
HighSpenders AS (
    SELECT user_id
    FROM UserTotalPayments
    WHERE total_paid > 150000
)
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS fullName,
    COUNT(DISTINCT ap.planPriceID) AS totalPlans,
    AVG(CAST(pa.amount AS FLOAT)) AS avgPlanAmount,
    ISNULL(ut.total_paid, 0) AS totalPayments,
    CASE 
        WHEN ut.total_paid > 250000 THEN 'VIP'
        WHEN ut.total_paid > 100000 THEN 'Premium'
        ELSE 'Standard'
    END AS userTier,
    CASE 
        WHEN hs.user_id IS NOT NULL THEN 1 ELSE 0
    END AS isHighSpender
FROM SolturaDB.sol_users u
LEFT JOIN ActivePlans ap ON u.userID = ap.userID
LEFT JOIN PlanAmounts pa ON ap.planPriceID = pa.planPriceID
LEFT JOIN UserTotalPayments ut ON u.userID = ut.user_id
LEFT JOIN HighSpenders hs ON u.userID = hs.user_id
WHERE u.email NOT IN ('test@example.com', 'spam@example.com')
GROUP BY u.userID, u.firstName, u.lastName, ut.total_paid, hs.user_id
ORDER BY totalPayments DESC;

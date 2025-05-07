USE solturaDB;
GO

-- Usuarios con planes activos
WITH UsersWithPlans AS (
    SELECT DISTINCT u.userID
    FROM SolturaDB.sol_users u
    JOIN SolturaDB.sol_userPlans up ON u.userID = up.userID
    JOIN SolturaDB.sol_planPrices pp ON up.planPriceID = pp.planPriceID
    WHERE up.enabled = 1
),

-- Usuarios con pagos v�lidos 
UsersWithPayments AS (
    SELECT DISTINCT t.user_id
    FROM SolturaDB.sol_transactions t
    JOIN SolturaDB.sol_payments p ON t.payment_id = p.paymentID
    WHERE p.confirmed = 1
)

-- Usuarios que tienen plan Y han hecho pagos v�lidos
SELECT u.userID, u.firstName + ' ' + u.lastName AS fullName, 'Plan y pago v�lido' AS estado
FROM SolturaDB.sol_users u
WHERE u.userID IN (
    SELECT userID FROM UsersWithPlans
    INTERSECT
    SELECT user_id FROM UsersWithPayments
)

UNION ALL

--Usuarios que tienen plan PERO NO han hecho pagos v�lidos
SELECT u.userID, u.firstName + ' ' + u.lastName AS fullName, 'Plan sin pago v�lido' AS estado
FROM SolturaDB.sol_users u
WHERE u.userID IN (
    SELECT userID FROM UsersWithPlans
    EXCEPT
    SELECT user_id FROM UsersWithPayments
)
ORDER BY estado, fullName;

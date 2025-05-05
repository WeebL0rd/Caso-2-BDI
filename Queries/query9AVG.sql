--9. AVG con agrupamiento (ej. promedio de montos pagados por usuario).
USE solturaDB;
GO
SELECT 
    u.userID,
    u.firstName + ' ' + u.lastName AS member_name,
    COUNT(p.paymentID) AS payment_count,
    AVG(p.amount) AS avg_payment_amount, -- aqui esta el avg :)
    SUM(p.amount) AS total_paid,
    (SELECT COUNT(*) FROM solturaDB.sol_userPlans up WHERE up.userID = u.userID) AS active_plans,
    STRING_AGG(apm.name, ', ') AS payment_methods_used
FROM solturaDB.sol_users u
JOIN solturaDB.sol_availablePayMethods apm ON u.userID = apm.userID
JOIN solturaDB.sol_payments p ON apm.available_method_id = p.availableMethodID
GROUP BY u.userID, u.firstName, u.lastName
ORDER BY avg_payment_amount DESC;
GO

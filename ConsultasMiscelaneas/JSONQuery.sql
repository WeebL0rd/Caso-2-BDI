USE solturaDB;
GO

DECLARE @UserID INT = 1;

SELECT
    (SELECT TOP 1
        p.description AS planName,
        pt.type AS planType,
        pp.amount AS planAmount,
        c.symbol AS currencySymbol
    FROM solturaDB.sol_userPlans up
    JOIN solturaDB.sol_plans p ON up.planPriceID = p.planID
    JOIN solturaDB.sol_planTypes pt ON p.planTypeID = pt.planTypeID
    JOIN solturaDB.sol_planPrices pp ON p.planID = pp.planID AND pp."current" = 1
    JOIN solturaDB.sol_currencies c ON pp.currency_id = c.currency_id
    WHERE up.userID = @UserID AND up.enabled = 1
    ORDER BY up.adquisition DESC
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS planInfo,
    (SELECT
        pf.description AS featureDescription,
        ft.type AS featureType,
        (SELECT TOP 1 fp.finalPrice FROM solturaDB.sol_featurePrices fp 
		JOIN solturaDB.sol_planFeatures plf ON fp.planFeatureID = plf.planFeatureID 
		WHERE plf.planFeatureID = fpp.planFeatureID AND fp."current" = 1 ORDER BY fp.featurePriceID DESC) AS featurePrice
    FROM solturaDB.sol_featuresPerPlans fpp
    JOIN solturaDB.sol_planFeatures pf ON fpp.planFeatureID = pf.planFeatureID
    JOIN solturaDB.sol_featureTypes ft ON pf.featureTypeID = ft.featureTypeID
    WHERE fpp.planID = (SELECT TOP 1 up.planPriceID FROM solturaDB.sol_userPlans up 
						WHERE up.userID = @UserID AND up.enabled = 1 ORDER BY up.adquisition DESC)
    FOR JSON PATH) AS features,
    (SELECT TOP 5 -- Obtener los 5 pagos más recientes
        pay.paymentID,
        pay.date_pay,
        pay.amount,
        c2.symbol AS paymentCurrencySymbol,
        pay.result,
        pm.name AS paymentMethod
    FROM solturaDB.sol_payments pay
    JOIN solturaDB.sol_availablePayMethods apm ON pay.availableMethodID = apm.available_method_id
    JOIN solturaDB.sol_payMethod pm ON apm.methodID = pm.payMethodID
    JOIN solturaDB.sol_currencies c2 ON pay.currency_id = c2.currency_id
    WHERE apm.userID = @UserID
    ORDER BY pay.date_pay DESC
    FOR JSON PATH) AS recentPayments
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
GO



--Esta consulta puede ser requerida en alguna pantalla cuando algún usuario quiera ver información sobre su supscripción actual
DECLARE payment_cursor CURSOR FOR
SELECT paymentID
FROM solturaDB.sol_payments
WHERE confirmed = 1
ORDER BY paymentID;

DECLARE @paymentID INT;

OPEN payment_cursor;

FETCH NEXT FROM payment_cursor INTO @paymentID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Bloquea el registro mientras está dentro de la transacción
    UPDATE solturaDB.sol_payments
    SET description = CONCAT(description, ' (Verificado)')
    WHERE paymentID = @paymentID;

    -- Simula procesamiento lento
    WAITFOR DELAY '00:00:05';

    FETCH NEXT FROM payment_cursor INTO @paymentID;
END

CLOSE payment_cursor;
DEALLOCATE payment_cursor;

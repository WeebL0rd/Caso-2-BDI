-- Sesión B corregida (inserción de pagos)
USE solturaDB;
GO

-- Espera 2s para que Sesión A ejecute la primera lectura
WAITFOR DELAY '00:00:02';

BEGIN TRANSACTION;

INSERT INTO SolturaDB.sol_payments (
    availableMethodID,
    currency_id,
    amount,
    date_pay,
    confirmed,
    result,
    auth,
    reference,
    charge_token,
    description,
    checksum,
    methodID
)
VALUES
    (1,                     -- availableMethodID
     1,                     -- currency_id
     50.00,                 -- amount
     GETDATE(),             -- date_pay
     1,                     -- confirmed
     'Aprobado',            -- result
     'AUTH_B1',             -- auth
     'REF_B1',              -- reference
     CAST('tokentest1' AS VARBINARY(255)),  -- charge_token
     'Prueba B1',           -- description
     HASHBYTES('SHA2_256','PruebaB1'),      -- checksum
     1),                    -- methodID

    (1,                     -- availableMethodID
     1,                     -- currency_id
     75.00,                 -- amount
     GETDATE(),             -- date_pay
     1,                     -- confirmed
     'Aprobado',            -- result
     'AUTH_B2',             -- auth
     'REF_B2',              -- reference
     CAST('tokentest2' AS VARBINARY(255)),  -- charge_token
     'Prueba B2',           -- description
     HASHBYTES('SHA2_256','PruebaB2'),      -- checksum
     1);                    -- methodID

COMMIT;

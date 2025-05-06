-- 5. LLAVES SIMETRICAS Y ASIMETRICAS

select * from solturaDB.sol_userAssociateIdentifications;

ALTER TABLE solturaDB.sol_userAssociateIdentifications
ALTER COLUMN token VARBINARY(MAX) NOT NULL;


CREATE CERTIFICATE CertificadoDeCifrado
WITH SUBJECT = 'Cifrado de Token';

CREATE ASYMMETRIC KEY SolturaLlaveAsimetrica
    WITH ALGORITHM = RSA_2048;

CREATE SYMMETRIC KEY SolturaLlaveSimetrica
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE CertificadoDeCifrado;

CREATE PROCEDURE solturaDB.SP_DesencriptarTokens
AS
BEGIN
    OPEN SYMMETRIC KEY SolturaLlaveSimetrica
    DECRYPTION BY CERTIFICATE CertificadoDeCifrado;

    SELECT 
        associateID,
        CONVERT(varchar, DecryptByKey(token)) AS token,
        userID,
        identificationTypeID
    FROM solturaDB.sol_userAssociateIdentifications;

    CLOSE SYMMETRIC KEY SolturaLlaveSimetrica;
END





-- PRUEBAS
-- Abrir la llave para poder desencriptar
OPEN SYMMETRIC KEY SolturaLlaveSimetrica
DECRYPTION BY CERTIFICATE CertificadoDeCifrado;

-- Ver valores cifrados y descifrados al mismo tiempo (Ya estos fueron cifrados en los inserts)
SELECT 
    associateID,
    token AS TokenCifrado,
    CONVERT(varchar, DecryptByKey(token)) AS TokenDesencriptado,
    userID,
    identificationTypeID
FROM solturaDB.sol_userAssociateIdentifications;

-- Cerrar la llave
CLOSE SYMMETRIC KEY SolturaLlaveSimetrica;
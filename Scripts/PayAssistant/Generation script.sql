use pay_assistant_db;

-- Prodecure para insertar nombres
DELIMITER //
CREATE PROCEDURE llenarNombres()
BEGIN
	DECLARE i INT DEFAULT 1;
    
    WHILE i <= 40 DO
		SET @nombre = NULL;
		SET @apellido = NULL;
		SELECT ELT(FLOOR(1 + RAND() * 10), 'Carlos', 'Ana', 'Luis', 'María', 'Juan','Pedro', 'Laura', 'Miguel', 'Sofía', 'José') INTO @nombre;
		SELECT ELT(FLOOR(1 + RAND() * 10), 'Pérez', 'Gómez', 'Rodríguez', 'López', 'Martínez','Hernández', 'García', 'Sánchez', 'Torres', 'Ramírez') INTO @apellido;
		INSERT INTO pay_users (email, first_name, last_name, password) VALUES (
        CONCAT(@nombre, @apellido, i, '@gmail.com'),
        @nombre,
        @apellido,
        SHA2(CONCAT('password_', i),512)
        );
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

call llenarNombres();


-- Inserción de países, estados y ciudades
INSERT INTO pay_countries (`name`) VALUES
    ('Costa Rica'),
    ('Estados Unidos'),
    ('España'),
    ('México'),
    ('Argentina'),
    ('Chile'),
    ('Colombia'),
    ('Perú'),
    ('Brasil'),
    ('Francia');

INSERT INTO pay_states (`name`, country_id) VALUES
    ('Cartago', 1),
    ('Alajuela', 1),
    ('Florida', 2),
    ('Texas', 2),
    ('Buenos Aires', 5),
    ('Córdoba', 5),
    ('Madrid', 3),
    ('Barcelona', 3),
    ('São Paulo', 9),
    ('Lima', 8);       
    
INSERT INTO pay_city (`name`, state_id) VALUES
    ('Parrita', 1),
    ('Santa Ana', 2),
    ('Miami', 3),
    ('Austin', 4),
    ('Mar del Plata', 5),
    ('Villa Carlos Paz', 6),
    ('Sevilla', 7),
    ('Sitges', 8),
    ('Campinas', 9),
    ('Arequipa', 10);

-- Procedure para insertar direcciones 
DELIMITER //
CREATE PROCEDURE llenarDirecciones()
BEGIN
	DECLARE i INT DEFAULT 1;
    
    WHILE i <= 40 DO
        INSERT INTO pay_addresses (line1, zipcode, geoposition, city_id) VALUES (
            CONCAT('Calle ', i, ' #', FLOOR(RAND() * 100)), 
            LPAD(FLOOR(RAND() * 99999), 5, '0'), 
            POINT(RAND() * 180 - 90, RAND() * 360 - 180), 
            FLOOR(1 + RAND() * 10)
        );

        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;


call llenarDirecciones();


-- Procedure para insertar direcciones de usuarios
DELIMITER //
CREATE PROCEDURE llenarDireccionesPorUsuario()
BEGIN
	DECLARE i INT DEFAULT 1;
    
    WHILE i <= 40 DO
        INSERT INTO pay_users_adresses (user_id, address_id) VALUES (i,i);
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL llenarDireccionesPorUsuario();

INSERT INTO pay_currencies (`name`, acronym, symbol, country_id) VALUES
	('Colón Costarricense', 'CRC', '₡', 1),
    ('Dólar Estadounidense', 'USD', '$', 2);
    
-- Inserción del exhange rate entre el colón y el dólar
INSERT INTO pay_exchange_currencies (source_id, destiny_id, start_date, exchange_rate)
VALUES (2, 1, '2025-03-21', 492.00);

-- Inserción de las subscripciones
INSERT INTO pay_assistant_db.pay_subscriptions (description) VALUES
    ('Básico'),
    ('Estándar'),
    ('Premium');

-- Inserción de los precios de subscripciones por mes
INSERT INTO pay_assistant_db.pay_plan_prices (subscrition_Id, amount, currency_id, postTime, endDate) VALUES
    (1, 9.99, 2, NOW(), '2025-12-31'),
    (2, 19.99, 2, NOW(), '2025-12-31'),
    (3, 29.99, 2, NOW(), '2025-12-31');

    
-- Inserción de los beneficios por los planes
INSERT INTO pay_assistant_db.pay_plan_features (`description`, enabled, dataType) VALUES
    ('Acceso a soporte 24/7', 1, 'Boolean'),
    ('Límite de transacciones mensuales', 1, 'Integer'),
    ('Descuentos especiales', 1, 'Boolean');
    
-- Inserción de los beneficios por cada plan de subscripcion dando detalles
INSERT INTO pay_assistant_db.pay_plan_features_subscriptions (plan_features_id, subscription_id, `value`, enabled) VALUES
(1, 1, 'No', 1),
(2, 1, '50', 1),
(1, 2, 'Sí', 1),
(2, 2, '200', 1),
(1, 3, 'Sí', 1),
(2, 3, 'Sin límite', 1),
(3, 3, 'Sí', 1);

-- Cambiar si es necesario crear un schedule para cada plan por usuario
-- Inserción de los schedules
INSERT INTO pay_assistant_db.pay_schedules (`name`, repit, repetitions, recurrencyType, startDate, endDate) VALUES
    ('Pago Básico Mensual', 1, 12, 1, NOW(), '2026-12-31'),  -- Mensual
    ('Pago Estándar Anual', 0, 1, 2, NOW(), '2026-12-31'),  -- Anual
    ('Pago Premium Mensual', 1, 12, 1, NOW(), '2026-12-31');  -- Mensual
    
-- Inserción de los schedules details
INSERT INTO pay_assistant_db.pay_schedules_details (schedule_id, baseDate, datePart, last_execute, next_execute, `description`, detail) VALUES
	(1, NOW(), '2025-01-01', NULL, '2025-01-01', 'Primer pago mensual', 'Pago mensual de la suscripción Básica'),
	(1, NOW(), '2025-02-01', NULL, '2025-02-01', 'Pago mensual', 'Pago mensual de la suscripción Básica'),
	(2, NOW(), '2025-01-01', NULL, '2025-01-01', 'Primer pago anual', 'Pago anual de la suscripción Estándar'),
	(3, NOW(), '2025-01-01', NULL, '2025-01-01', 'Primer pago mensual', 'Pago mensual de la suscripción Premium'),
	(3, NOW(), '2025-02-01', NULL, '2025-02-01', 'Pago mensual', 'Pago mensual de la suscripción Premium');

DELIMITER //
CREATE PROCEDURE subscripcionesPorUsuario()
BEGIN
	DECLARE i INT DEFAULT 1;
    
    WHILE i <= 40 DO
		SET @primerPago = NULL;
		SET @primerPago = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 200) DAY); -- Fecha aleatoria en los últimos 200 días
        SET @fechaSub = @primerPago;
        
		WHILE @fechaSub <= NOW() DO
			SET @mensual = FLOOR(1 + RAND() * 2);
            
            INSERT INTO pay_users_plan_prices (user_id, plan_prices_id, adquision, enabled, schedule_id) VALUES(
				i,
				FLOOR(1 + RAND() * 3),
                @fechaSub,
                1,
                @mensual
                );
            
            SET @fechaSub = DATE_ADD(@fechaSub, INTERVAL 1 MONTH);
		END WHILE;
        
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

call subscripcionesPorUsuario();
    

-- Inserción de la severidad de los logs, sources, y tipos
INSERT INTO pay_logs_severity (`name`) VALUES
	('DEBUG'),
    ('INFO'),
    ('WARNING'),
    ('ERROR');
INSERT INTO pay_log_sources (`name`) VALUES
	('Aplicación'),
    ('Base de datos'),
    ('Usuario'),
    ('Sistema');
INSERT INTO pay_log_types (`name`,reference1_description) VALUES
	('Transaction', 'UserId'),
    ('Error', 'UserId'),
    ('Access', 'UserId'),
    ('Configuration', 'UserId');
INSERT INTO pay_log_types (`name`,reference1_description,reference2_description) VALUES ('Payment AI configuration', 'user_id', 'analyzed_text_id');

    
-- Procedure para llenar logs
DELIMITER //
CREATE PROCEDURE llenarLogs()
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE randNum INT DEFAULT 1;
    
    WHILE i <= 100 DO
		-- Hace un número random de usuario al que le va a registrar el log
        SET randNum = FLOOR(1 + RAND() * 40);
		
        SET @descripcion = NULL;
		SELECT ELT(FLOOR(1 + RAND() * 10), 
						'User logueado', 
						'Creación de pago recurrente exitosa', 
						'Pago de factura completado', 
						'Error al procesar pago', 
						'Usuario actualizado correctamente', 
						'Nuevo método de pago agregado', 
						'Pago rechazado por tarjeta no válida', 
						'Cambio de configuración de usuario guardado', 
						'Usuario eliminado del sistema', 
						'Intento fallido de inicio de sesión') INTO @descripcion;
        
        SET @postTime = NULL;
		SET @postTime = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 480) DAY); -- Fecha aleatoria en los últimos 200 días
		SET @postTime = DATE_ADD(DATE(@postTime), INTERVAL FLOOR(RAND() * 24) HOUR);
		SET @postTime = DATE_ADD(@postTime, INTERVAL FLOOR(RAND() * 60) MINUTE);
        
        SET @dispositivo = NULL;
		SELECT ELT(FLOOR(1 + RAND() * 6), 'Laptop', 'Smartphone', 'Tablet', 'PC', 'Smartwatch', 'Servidor') INTO @dispositivo;
        
        SET @modulo = NULL;
		SELECT ELT(FLOOR(1 + RAND() * 10), 
			'Autenticación de Usuario', 
			'Gestión de Pagos', 
			'Procesamiento de Tarjetas', 
			'Pagos Recurrentes', 
			'Generación de Facturas', 
			'Notificaciones', 
			'Historial de Pagos', 
			'Gestión de Métodos de Pago', 
			'Soporte al Cliente', 
			'Análisis de IA y Recomendaciones') INTO @modulo;
        
		INSERT INTO pay_logs (`description`, postTime, computer, username, trace, `checksum`, referenceId1, log_severity_id, log_types_id, log_sources_id) VALUES (
        @descripcion,
		@postTime,
        @dispositivo,
        CONCAT('usuario_', randnum),
        @modulo,
        SHA2(CONCAT(@descripcion,DATE_FORMAT(@postTime, '%Y-%m-%d %H:%i:%s'),@dispositivo, CONCAT('usuario_', randnum), randnum, @modulo), 512),
        randnum,
        FLOOR(1 + RAND() * 3), 
        FLOOR(1 + RAND() * 3),
        FLOOR(1 + RAND() * 3));
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

call llenarLogs();

DELIMITER //
CREATE PROCEDURE llenarLogsEventos()
BEGIN
	DECLARE i INT DEFAULT 1;
    
    WHILE i <= 90 DO
        
        SET @postTime = NULL;
		SET @postTime = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 480) DAY); -- Fecha aleatoria en los últimos 200 días
		SET @postTime = DATE_ADD(DATE(@postTime), INTERVAL FLOOR(RAND() * 24) HOUR);
		SET @postTime = DATE_ADD(@postTime, INTERVAL FLOOR(RAND() * 60) MINUTE);
        
        SET @dispositivo = NULL;
		SELECT ELT(FLOOR(1 + RAND() * 6), 'Laptop', 'Smartphone', 'Tablet', 'PC', 'Smartwatch', 'Servidor') INTO @dispositivo;
        
		SET @descripcion = NULL;
		SELECT ELT(FLOOR(1 + RAND() * 35), 
			'Fallo de interpretación de voz demasiado baja',  
			'Fallo de interpretación por pronunciación ambigua',  
			'Fallo por superposición de voces en el audio',  
			'Fallo por cortes en la grabación de voz',  
			'Fallo por error en la separación de palabras',  
			'Fallo por ruido de fondo demasiado alto',  
			'Fallo por interferencia de otros sonidos (música, claxon, etc.)',  
			'Fallo por eco en el audio que distorsiona palabras',  
			'Fallo por voz entrecortada debido a mala calidad del micrófono',  
			'Fallo por distorsión del audio en la compresión',  
			'Fallo por sobrecarga en el volumen del audio',  
			'Fallo por confusión entre nombres similares',  
			'Fallo por nombre dividido en dos partes por error',  
			'Fallo por interpretación errónea de un nombre común',  
			'Fallo por confusión con apellidos',   
			'Fallo por inclusión de caracteres no válidos en el nombre',  
			'Fallo por cifras numéricas mal interpretadas',  
			'Fallo por conversión errónea de moneda',  
			'Fallo por error en la transcripción de montos decimales',  
			'Fallo por separadores de miles mal reconocidos',  
			'Fallo por omisión de un número en la transcripción',  
			'Fallo por detección de datos financieros incorrectos',  
			'Fallo por confusión entre cantidades y conceptos',  
			'Fallo por método de pago inexistente o no soportado',  
			'Fallo por confusión entre tarjetas de crédito y débito',  
			'Fallo por no detección de la plataforma de pago correcta',  
			'Fallo por omisión del banco asociado al método de pago',  
			'Fallo por error en la interpretación del número de cuenta',  
			'Fallo por confusión entre fechas escritas con distintos formatos',  
			'Fallo por error en la conversión de fechas habladas a texto',  
			'Fallo por interpretación errónea de una fecha en palabras',  
			'Fallo por confusión entre meses con nombres similares',  
			'Fallo por error en la interpretación de fechas repetitivas',  
			'Fallo por pérdida de datos en la transcripción',   
			'Fallo por fallo en la normalización del audio antes de la interpretación'  
		) INTO @descripcion;
        
		INSERT INTO pay_logs (`description`, postTime, computer, username, trace, `checksum`, referenceId1, referenceId2, log_severity_id, log_types_id, log_sources_id) VALUES (
			@descripcion,
			@postTime,
			@dispositivo,
			CONCAT('usuario_', MOD(i,40)),
			'Pagos Recurrentes IA',
			SHA2(CONCAT('Fallo de interpretación',DATE_FORMAT(@postTime, '%Y-%m-%d %H:%i:%s'),@dispositivo, CONCAT('usuario_', MOD(i,40)), MOD(i,40), i, 'Pagos Recurrentes'), 512),
			MOD(i,40), -- user_id
			i, -- analyzed_text_id
			4, -- severity: ERROR
			5, -- log type: Payment configuration
			4); -- source: Sistema
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL llenarLogsEventos();



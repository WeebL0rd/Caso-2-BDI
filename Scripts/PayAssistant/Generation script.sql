use pay_assistant_db;

DELIMITER //
CREATE PROCEDURE llenarNombres()
BEGIN
    -- Declarar las variables temporales
    DECLARE i INT DEFAULT 1;
    DECLARE totalNombres INT DEFAULT 50;  -- Número de nombres
    DECLARE totalApellidos INT DEFAULT 50;  -- Número de apellidos
    
    -- Crear el loop para insertar los datos
    WHILE i <= 1050 DO
        -- Elegir un nombre y apellido aleatorio usando ELT()
        SET @nombre = ELT(FLOOR(1 + RAND() * totalNombres), 
            'Carlos', 'Ana', 'Luis', 'María', 'Juan', 'Pedro', 'Laura', 'Miguel', 'Sofía', 'José',
            'Andrea', 'Diego', 'Lucía', 'Javier', 'Valeria', 'Fernando', 'Camila', 'Raúl', 'Daniela', 'Manuel',
            'Paula', 'Ricardo', 'Elena', 'Héctor', 'Isabel', 'Francisco', 'Patricia', 'Alejandro', 'Rosa', 'Ángel',
            'Marta', 'Gabriel', 'Clara', 'Julio', 'Emma', 'Sebastián', 'Teresa', 'Nicolás', 'Noelia', 'Iván',
            'Lorena', 'Álvaro', 'Irene', 'Tomás', 'Marina', 'Adrián', 'Sara', 'Pablo', 'Alicia', 'Rubén');
        
        SET @apellido = ELT(FLOOR(1 + RAND() * totalApellidos), 
            'Pérez', 'Gómez', 'Rodríguez', 'López', 'Martínez', 'Hernández', 'García', 'Sánchez', 'Torres', 'Ramírez',
            'Flores', 'Vargas', 'Ortega', 'Morales', 'Delgado', 'Cruz', 'Navarro', 'Romero', 'Aguilar', 'Silva',
            'Mendoza', 'Reyes', 'Guerrero', 'Castro', 'Jiménez', 'Ramos', 'Vega', 'Herrera', 'Molina', 'Paredes',
            'Campos', 'Suárez', 'Mejía', 'Salazar', 'Rivas', 'Cardenas', 'Bravo', 'Fuentes', 'Escobar', 'Villarreal',
            'Valenzuela', 'Correa', 'Alvarado', 'Montes', 'Peña', 'Medina', 'Figueroa', 'Estrada', 'Acosta', 'Ponce');
        
        -- Insertar en la tabla principal
        INSERT INTO pay_users (email, first_name, last_name, password) 
        VALUES (
            CONCAT(@nombre, @apellido, i, '@gmail.com'),
            @nombre,
            @apellido,
            SHA2(CONCAT('password_', i), 512)
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
    
    WHILE i <= 1050 DO
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
    
    WHILE i <= 1000 DO
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
    ('Estándar'),
    ('Premium');

-- Inserción de los precios de subscripciones por mes
INSERT INTO pay_assistant_db.pay_plan_prices (subscrition_Id, amount, currency_id, postTime, endDate) VALUES
    (1, 9.99, 2, NOW(), '2025-12-31'),
    (2, 39.99, 2, NOW(), '2025-12-31');

    
-- Inserción de los beneficios por los planes
INSERT INTO pay_assistant_db.pay_plan_features (`description`, enabled, dataType) VALUES
    ('Acceso a soporte 24/7', 1, 'Boolean'),
    ('Límite de transacciones mensuales', 1, 'Integer'),
    ('Límite de creación de pagos recurrentes', 1, 'Integer');
    
-- Inserción de los beneficios por cada plan de subscripcion dando detalles
INSERT INTO pay_assistant_db.pay_plan_features_subscriptions (plan_features_id, subscription_id, `value`, enabled) VALUES
(1, 1, 'No', 1),
(2, 1, '50', 1),
(1, 2, 'Sí', 1),
(2, 2, '200', 1),
(3, 1, '5', 1);

-- Cambiar si es necesario crear un schedule para cada plan por usuario
-- Inserción de los schedules
INSERT INTO pay_assistant_db.pay_schedules (`name`, repit, repetitions, recurrencyType, startDate ) VALUES
    ('Pago Estándar Mensual', 1, 12, 1, NOW()),  -- Mensual
    ('Pago Premium Anual', 0, 1, 2, NOW());  -- Anual
    
    
-- Inserción de los schedules details
INSERT INTO pay_assistant_db.pay_schedules_details (schedule_id, baseDate, datePart, last_execute, next_execute, `description`, detail) VALUES
	(1, NOW(), '2025-01-01', NULL, '2025-02-01', 'Pago mensual', 'Pago mensual de la suscripción Estándar'),
	(2, NOW(), '2025-01-01', NULL, '2026-01-01', 'Pago anual', 'Pago anual de la suscripción Premium');

DELIMITER //
CREATE PROCEDURE subscripcionesPorUsuario()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE fechaSub DATE;

    WHILE i <= 1050 DO
        SET fechaSub = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 100) DAY);

        IF i <= 735 THEN
            -- 70%: Plan Estándar mensual
            INSERT INTO pay_users_plan_prices (user_id, plan_prices_id, adquision, enabled, schedule_id)
            VALUES (
                i,
                1,
                fechaSub,
                1,
                1
            );
        ELSE
            -- 30%: Plan Premium anual
            INSERT INTO pay_users_plan_prices (user_id, plan_prices_id, adquision, enabled, schedule_id)
            VALUES (
                i,
                2,
                fechaSub,
                1,
                2
            );
        END IF;

        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

call subscripcionesPorUsuario();


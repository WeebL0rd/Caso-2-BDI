
USE solturaDB
INSERT INTO solturaDB.sol_countries (name)
VALUES
('Costa Rica'),
('Estados Unidos'),
('México'),
('España');
INSERT INTO solturaDB.sol_states (name, countryID)
VALUES
('San José', 1),
('Alajuela', 1),
('Cartago', 1),
('Heredia', 1),
('Guanacaste', 1),
('Puntarenas', 1),
('Limón', 1),
('California', 2),
('Texas', 2),
('Florida', 2),
('Nueva York', 2),
('Ciudad de México', 3),
('Jalisco', 3),
('Nuevo León', 3),
('Madrid', 4),
('Barcelona', 4),
('Valencia', 4);
SET IDENTITY_INSERT solturaDB.sol_city ON;
INSERT INTO solturaDB.sol_city (cityID, stateID, name)
VALUES
(1, 1, 'San José'),
(2, 1, 'Escazú'),
(3, 1, 'Santa Ana'),
(4, 2, 'Alajuela'),
(5, 2, 'Grecia'),
(6, 2, 'San Ramón'),
(7, 8, 'Los Ángeles'),
(8, 8, 'San Francisco'),
(9, 8, 'San Diego'),
(10, 12, 'Ciudad de México'),
(11, 12, 'Coyoacán'),
(12, 12, 'Polanco'),
(13, 15, 'Madrid'),
(14, 15, 'Alcobendas'),
(15, 15, 'Las Rozas');

SET IDENTITY_INSERT solturaDB.sol_city OFF;
SET IDENTITY_INSERT solturaDB.sol_addresses ON;
INSERT INTO solturaDB.sol_addresses (addressid, line1, line2, zipcode, geoposition, cityID)
VALUES
(1, 'Avenida Central', 'Calle 25', '10101', 
 geometry::Point(9.9281, -84.0907, 4326), 1),
(2, 'Centro Comercial Multiplaza', 'Local #45', '10203', 
 geometry::Point(9.9186, -84.1118, 4326), 2),
(3, 'Calle Vieja', 'Frente a la iglesia', '10901', 
 geometry::Point(9.9326, -84.1826, 4326), 3),
(4, 'Hollywood Boulevard 123', 'Sector 5', '90028', 
 geometry::Point(34.1016, -118.3389, 4326), 7),
(5, 'Gran Vía 78', 'Piso 3', '28013', 
 geometry::Point(40.4194, -3.7055, 4326), 13);
SET IDENTITY_INSERT solturaDB.sol_addresses OFF;
INSERT INTO solturaDB.sol_currencies (name, acronym, symbol, countryID)
VALUES
('Colón Costarricense', 'CRC', '₡', 1),
('Dólar Estadounidense', 'USD', '$', 2);
SET IDENTITY_INSERT solturaDB.sol_exchangeCurrencies ON;
INSERT INTO solturaDB.sol_exchangeCurrencies (exchangeCurrencyID, sourceID, destinyID, startDate, endDate, exchange_rate, enabled, currentExchange)
VALUES
(1, 1, 2, '2025-05-01', NULL, 0.0018, 1, 1),
(2, 2, 1, '2025-05-01', NULL, 555.556, 1, 1);
SET IDENTITY_INSERT solturaDB.sol_exchangeCurrencies OFF;


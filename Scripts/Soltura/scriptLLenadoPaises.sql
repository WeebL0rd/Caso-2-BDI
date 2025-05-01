--POBLAR DATOS DE PA�SES, ESTADOS, CIUDADES, Y MONEDAS
use solturaDB

INSERT INTO solturaDB.sol_countries (name)
VALUES
('Costa Rica'),
('Estados Unidos'),
('M�xico'),
('Espa�a');


INSERT INTO solturaDB.sol_states (name, countryID)
VALUES
-- Costa Rica
('San Jos�', 1),
('Alajuela', 1),
('Cartago', 1),
('Heredia', 1),
('Guanacaste', 1),
('Puntarenas', 1),
('Lim�n', 1),

-- Estados Unidos
('California', 2),
('Texas', 2),
('Florida', 2),
('Nueva York', 2),

-- M�xico
('Ciudad de M�xico', 3),
('Jalisco', 3),
('Nuevo Le�n', 3),

-- Espa�a
('Madrid', 4),
('Barcelona', 4),
('Valencia', 4);


SET IDENTITY_INSERT solturaDB.sol_city ON;

INSERT INTO solturaDB.sol_city (cityID, stateID, name)
VALUES
-- San Jos�, Costa Rica
(1, 1, 'San Jos�'),
(2, 1, 'Escaz�'),
(3, 1, 'Santa Ana'),

-- Alajuela, Costa Rica
(4, 2, 'Alajuela'),
(5, 2, 'Grecia'),
(6, 2, 'San Ram�n'),

-- California, USA
(7, 8, 'Los �ngeles'),
(8, 8, 'San Francisco'),
(9, 8, 'San Diego'),

-- Ciudad de M�xico, M�xico
(10, 12, 'Ciudad de M�xico'),
(11, 12, 'Coyoac�n'),
(12, 12, 'Polanco'),

-- Madrid, Espa�a
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
(5, 'Gran V�a 78', 'Piso 3', '28013', 
 geometry::Point(40.4194, -3.7055, 4326), 13);


INSERT INTO solturaDB.sol_currencies (name, acronym, symbol, countryID)
VALUES
('Col�n Costarricense', 'CRC', '?', 1),
('D�lar Estadounidense', 'USD', '$', 2);
SET IDENTITY_INSERT solturaDB.sol_addresses OFF;
USE solturaDB
GO


INSERT INTO solturaDB.sol_partners_identifications_types(name) 
VALUES 
('Jurídico'),
('Cédula'),
('Gobierno')


INSERT INTO solturaDB.sol_enterprise_size (size) 
VALUES 
('Pequeña'),
('Mediana'),
('Grande')


SET IDENTITY_INSERT solturaDB.sol_partners ON;
INSERT INTO solturaDB.sol_partners (partnerId, name, registerDate, state, identificationtypeId, enterpriseSizeid, identification) 
VALUES
(1, 'ElectroProveedores S.A.', GETDATE(), 1, 1, 3, '3-101-205045'),
(2, 'Tienda XYZ Descuentos', GETDATE(), 1, 1, 2, '3-102-456789'),
(3, 'SuperAhorro Limitado', GETDATE(), 1, 1, 2, '3-103-123456'),
(4, 'MegaTienda Cuponera', GETDATE(), 1, 1, 3, '3-104-789123'),
(5, 'Parqueo Seguro VIP', GETDATE(), 1, 1, 2, '3-105-456123'),
(6, 'Cinépolis', GETDATE(), 1, 1, 3, '3-106-321654'),
(7, 'McDonalds', GETDATE(), 1, 1, 2, '3-107-098324');
SET IDENTITY_INSERT solturaDB.sol_partners OFF;

INSERT INTO solturaDB.sol_partner_addresses (partnerId, addressid)
VALUES
(1, 1),  
(2, 2),  
(3, 2),  
(4, 5), 
(5, 3),  
(6, 4);

CREATE TABLE Room 
AS
(SELECT DISTINCT id, accommodates, bathrooms, bedrooms, beds, bed_type,
amenities, square_feet, price, weekly_price, monthly_price, security_deposit FROM Listings2);

ALTER TABLE Listings2
DROP COLUMN bathrooms,
DROP COLUMN bedrooms;

ALTER TABLE Room 
ADD FOREIGN KEY(id) REFERENCES Listings2(id);

ALTER TABLE Listings2
DROP COLUMN accommodates,
DROP COLUMN beds, 
DROP COLUMN bed_type,
DROP COLUMN amenities, 
DROP COLUMN square_feet, 
DROP COLUMN price, 
DROP COLUMN weekly_price, 
DROP COLUMN monthly_price, 
DROP COLUMN security_deposit;
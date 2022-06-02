CREATE TABLE Location
AS (SELECT DISTINCT id, street, neighbourhood, neighbourhood_cleansed, city, state,
zipcode, market, smart_location, country_code, country, latitude, longitude,
is_location_exact FROM Listings2);

ALTER TABLE Listings2
DROP COLUMN smart_location,
DROP COLUMN is_location_exact;

ALTER TABLE Location
ADD FOREIGN KEY(id) REFERENCES Listings2(id);

ALTER TABLE Listings2
DROP CONSTRAINT Listings2_neighbourhood_cleansed_fkey;

ALTER TABLE Listings2
DROP COLUMN street, 
DROP COLUMN neighbourhood, 
DROP COLUMN neighbourhood_cleansed, 
DROP COLUMN city, 
DROP COLUMN state,
DROP COLUMN zipcode, 
DROP COLUMN market,
DROP COLUMN country_code, 
DROP COLUMN country, 
DROP COLUMN latitude, 
DROP COLUMN longitude;


ALTER TABLE Location
ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES Neighbourhoods(neighbourhood);

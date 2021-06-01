

CREATE TABLE Amenity
AS
(SELECT Distinct(regexp_split_to_table(Amenities,','))AS amenity_name FROM Room);

UPDATE Amenity SET amenity_name = replace(amenity_name,'{','');
UPDATE Amenity SET amenity_name = replace(amenity_name,'"','');
UPDATE Amenity SET amenity_name = replace(amenity_name,'}','');

ALTER TABLE Amenity 
ADD amenity_id SERIAL;

ALTER TABLE Amenity 
ADD PRIMARY KEY(amenity_id);

CREATE TABLE AmenityToRoom AS(
SELECT room.id, amenity.amenity_id
FROM amenity
JOIN room
ON room.amenities LIKE '%' || amenity.amenity_name || '%'
ORDER BY room.id
)

ALTER TABLE AmenityToRoom 
ADD FOREIGN KEY (amenity_id) REFERENCES Amenity(amenity_id);

ALTER TABLE Room
DROP COLUMN amenities






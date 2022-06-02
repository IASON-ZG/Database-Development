/*Find the hosts which have more than 10 listings that have a room type = Εntire home/apt
Output: 81 rows
*/

SELECT Host.id,COUNT(Listing2.id)
FROM Host
LEFT OUTER JOIN Listing2
ON Host.id = Listing2.host_id
WHERE Listing2.room_type ='Entire home/apt'
GROUP BY Host.id
HAVING COUNT(Listing2.id) > 10


/*Find the rooms that have a total number of amenities greater of 15 
Output:9710 rows
*/

Select Room.id AS RoomId,COUNT(amenitytoroom.amenity_id) AS NumberofAmenities
FROM Room
JOIN amenitytoroom 
ON Room.id = amenitytoroom.id
GROUP BY Room.id
HAVING COUNT(amenitytoroom.amenity_id) > 15
ORDER BY NumberofAmenities DESC

/*Find the number of hosts each neighbourhood has 
Output:45
*/
SELECT Location.neighbourhood_cleansed,COUNT(Host.id)
FROM Location
LEFT OUTER JOIN HOST 
ON LOCATION.neighbourhood = Host.neighbourhood
GROUP BY Location.neighbourhood_cleansed


/* Find the Rooms in deascelating order of price in which the number of beds is greater than 4 and the neihgbourhood they are located is either 'ΖΑΠΠΕΙΟ’ or 'ΑΚΡΟΠΟΛΗ'
Output:38 rows
*/

SELECT Room.id, Room.price,Room.beds , Location.neighbourhood_cleansed 
FROM Room
JOIN Location 
ON Room.id=Location.id
WHERE (Location.neighbourhood_cleansed = 'ΖΑΠΠΕΙΟ' OR  Location.neighbourhood_cleansed = 'ΑΚΡΟΠΟΛΗ') AND Room.beds > 4
ORDER BY price 


/* Find how many listings each of the three neighbourhoods(ΓΟΥΒΑ,ΓΟΥΔΙ,ΓΚΑΖΙ) has
Output: 3 rows
*/
SELECT COUNT(Location.id), geolocation.properties_neighbourhood
FROM Location
FULL OUTER JOIN Geolocation
ON Location.neighbourhood_cleansed = geolocation.properties_neighbourhood
WHERE (Location.neighbourhood_cleansed = 'ΓΟΥΔΙ' OR Location.neighbourhood_cleansed = 'ΓΟΥΒΑ' OR Location.neighbourhood_cleansed = 'ΓΚΑΖΙ') 
GROUP BY geolocation.properties_neighbourhood
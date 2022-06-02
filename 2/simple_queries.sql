
/* Find for each host the price of the most expensive listing he has in a descending order of price.
Output: 6,363

SELECT DISTINCT Listings.host_id, Max(Listings.price::double precision) AS Most_expensive_Listing
FROM Listings
GROUP BY Listings.host_id
ORDER BY Most_expensive_Listing DESC

/* Find the number of all the reviewers with the name Steven
Output:318
SELECT COUNT(DISTINCT reviewer_id) FROM Reviews
WHERE reviewer_name ='Steven';

/*Find the top 20 listings with the most reviews
Output :20 rows

SELECT Listings.id,COUNT(reviews.listing_id)
FROM Listings
LEFT OUTER JOIN Reviews
ON Listings.id = Reviews.listing_id
GROUP BY Listings.id
ORDER BY COUNT(reviews.listing_id) DESC
LIMIT 20

/* Show all available rooms in order of date that have more or equal to 3 bedrooms
Output: 244,992 rows

SELECT Listings.id,Listings.price,Listings.bedrooms, Calendar.date
FROM Listings
INNER JOIN Calendar
ON Listings.id = Calendar.listing_id
WHERE Listings.bedrooms >= 3 and calendar.available = True
ORDER BY Calendar.date;


/* Find the cheapest room in each neighbourhood
Output:45 rows

SELECT Neighbourhoods.neighbourhood,min(Listings.price) 
FROM Listings 
INNER JOIN Neighbourhoods 
ON Listings.neighbourhood_cleansed = Neighbourhoods.neighbourhood
GROUP BY Neighbourhoods.neighbourhood

/* Find the total dates each room was booked during the christmas holidays
Output:11,541 rows

SELECT Listings.id, COUNT(CASE WHEN NOT Calendar.available THEN 1 END)
FROM Listings
JOIN Calendar
ON Listings.id = Calendar.listing_id 
WHERE Calendar.date BETWEEN '2020-12-20' AND '2020-12-31'
GROUP BY Listings.id

/* Show the latest 5 reviews of the listing with the id of 59663
Output = 5 rows

SELECT Listings.id, Reviews.comments,Reviews.date
FROM Listings
JOIN Reviews
ON Listings.id = Reviews.listing_id
WHERE Listings.id = 59663 
ORDER BY Reviews.date DESC 
LIMIT 5


/* Find the 40 cheapest available listings in order of date 
Output = 40 rows

SELECT Listings.id, Listings.price , Calendar.date
FROM Listings
JOIN Calendar
ON Listings.id = Calendar.listing_id 
WHERE (Listings.price::double precision BETWEEN 20 AND 40) AND Calendar.available = 'True'
ORDER BY Listings.price
LIMIT 40

/* Find all the neighbourhoods with a latitude that begins with 23.74
Output:11 rows
Select Neighbourhoods.neighbourhood
From Neighbourhoods
FULL OUTER JOIN Geolocation
ON Geolocation.properties_neighbourhood=Neighbourhoods.neighbourhood
Where Geolocation.geometry_coordinates_0_0_0_0 LIKE '23.74%'


/* Find all availabel listings on 08-04-2020 that have an Entire home/apt as room type in 'ΑΝΩ ΠΑΤΗΣΙΑ 
Output:45 rows
Select Listings.id,Listings.price,Listings.neighbourhood_cleansed 
FROM Listings
INNER JOIN Calendar
ON Listings.id = Calendar.listing_id
WHERE Listings.room_type = 'Entire home/apt'AND Listings.neighbourhood_cleansed = 'ΑΝΩ ΠΑΤΗΣΙΑ' AND Calendar.available = 'True' 
AND Calendar.date = '2020-04-08'



/*Find how many listings ,with accommodates of more than 5 , each neighbourhood has 
Output:45 rows

SELECT Neighbourhoods.neighbourhood,COUNT(Listings.id)
FROM Neighbourhoods
LEFT OUTER JOIN Listings
ON Neighbourhoods.neighbourhood=Listings.neighbourhood_cleansed and accommodates >= 4
GROUP BY Neighbourhoods.neighbourhood


/*Find how many listings and how many reveiews each host has ordered by number of reviews
Output:6,363 rows

SELECT Listings.host_id,COUNT(DISTINCT Listings.id)AS number_of_listings,COUNT(Reviews.listing_id) AS number_of_reviews
FROM Listings
LEFT OUTER JOIN Reviews
ON Listings.id = Reviews.listing_id
GROUP BY Listings.host_id
ORDER BY number_of_reviews DESC


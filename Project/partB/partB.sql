
//----------------1ST QUERY----------------//
SELECT COUNT(id),EXTRACT(YEAR FROM release_date)
FROM movies_metadata
GROUP BY EXTRACT(YEAR FROM release_date)
ORDER BY EXTRACT(YEAR FROM release_date)

Output: 136 rows

//----------------PREPERATION OF THE DATA----------------//

CREATE TABLE GenreTemp AS (Select unnest(genres[:][1:1])AS id, unnest(genres[:][2:2] )AS genre
FROM movies_metadatatemp)

UPDATE genretemp 
SET id = replace(id,'id','');
UPDATE genretemp 
SET id = replace(id,''': ','');
UPDATE genretemp 
SET id = replace(id,'''','');

UPDATE genretemp 
SET genre = replace(genre,'name','');
UPDATE genretemp 
SET genre = replace(genre,''': ','');
UPDATE genretemp 
SET genre = replace(genre,'''','');

ALTER TABLE Genretemp
ALTER COLUMN id TYPE INT
USING id::integer;

ALTER TABLE Genretemp
ALTER COLUMN genre TYPE VARCHAR(40)

CREATE TABLE Genre AS (SELECT DISTINCT (id),genre FROM GenreTemp);

ALTER TABLE Genre
ADD PRIMARY KEY (id);

CREATE TABLE GenreToMovie AS(
SELECT Genre.id AS Genre_id, movies_metadata.id AS Movie_id
FROM movies_metadata
JOIN Genre
ON movies_metadata.genres LIKE '%' || Genre.genre || '%'
ORDER BY Genre.id)

ALTER TABLE movies_metadata DROP COLUMN genres;

//----------------2ND QUERY----------------//
SELECT Genre,COUNT(Movie_id)
FROM GenretoMovie,Genre
WHERE Genre_id = Genre.id
GROUP BY (Genre)
ORDER BY COUNT(Movie_id) DESC;

Output: 20 rows 

//----------------3RD QUERY----------------//

SELECT Genre,EXTRACT(YEAR FROM movies_metadata.release_date) AS Release_Year,COUNT(Movie_id)
FROM GenretoMovie,movies_metadata,Genre
WHERE movies_metadata.id = Genretomovie.movie_id AND Genre.id = Genre_id
GROUP BY ROLLUP(Release_Year,Genre);

Output: 2173 rows

//----------------4TH QUERY----------------//

SELECT Genre,AVG(CAST (vote_average AS FLOAT)) AS Average_Rating
FROM GenretoMovie,movies_metadata,Genre
WHERE movies_metadata.id = Genretomovie.movie_id AND Genre.id = Genre_id
GROUP BY ROLLUP(Genre)
ORDER BY Genre;

Output: 20 rows

//----------------5TH QUERY----------------//

SELECT userid,COUNT(movieid) AS Number_of_Ratings
FROM Ratings
GROUP BY (userid)
ORDER BY Number_of_Ratings DESC;
Output: 270,896 rows

//----------------6TH QUERY----------------//

SELECT userid,AVG(CAST(rating AS FLOAT)) AS Average_Rating_of_User
FROM Ratings
GROUP BY (userid);

Output: 270,896 rows

//----------------VIEW----------------//

CREATE VIEW Average_Ratings AS
SELECT userid,COUNT(movieid) AS Number_of_Ratings,AVG(CAST(rating AS FLOAT)) AS Average_Rating_of_User
FROM Ratings
GROUP BY (userid);

//----------------BONUS QUERY(6.2)----------------//

SELECT COUNT(userid),Average_Rating_of_User FROM(
SELECT userid,AVG(CAST(rating AS FLOAT)) AS Average_Rating_of_User
FROM Ratings
GROUP BY (userid)) AS Users
GROUP BY (Average_Rating_of_User);

Output: 45,948 rows





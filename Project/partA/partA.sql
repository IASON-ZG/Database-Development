create table CreditsTemp(
   cast_of_movie text,
   crew text,
   id int
);

create table KeywordsTemp(
   id int,
   keywords text
);

create table LinksTemp(
   movieId int,
   imdbId int,
   tmdbId int
);

create table Movies_MetadataTemp(
   adult varchar(10),
   belongs_to_collection varchar(190),
   budget int,
   genres varchar(270),
   homepage varchar(250),
   id int,
   imdb_id varchar(10),
   original_language varchar(10),
   original_title varchar(110),
   overview varchar(1000),
   popularity varchar(10),
   poster_path varchar(40),
   production_companies varchar(1260),
   production_countries varchar(1040),
   release_date date,
   revenue bigint,
   runtime varchar(10),
   spoken_languages varchar(770),
   status varchar(20),
   tagline varchar(300),
   title varchar(110),
   video varchar(10),
   vote_average varchar(10),
   vote_count int
);

create table Ratings(
    userId int,
    movieId int
    rating varchar(10)
    timestamp int
);

create table Ratings_Small(
   userId int,
   movieId int,
   rating varchar(10),
   timestamp int
);


create table Credits
AS (SELECT distinct(id),cast_of_movie ,crew 
FROM Creditstemp);

create table Keywords
AS (SELECT DISTINCT(id) , keywords
FROM keywordstemp);

create table Links
AS (SELECT DISTINCT(movieId) , imdbId,tmdbId
FROM Linkstemp);

create table Movies_Metadata
AS (SELECT DISTINCT(id) ,adult,belongs_to_collection,budget ,genres,homepage,imdb_id,original_language
,original_title,overview ,popularity ,poster_path ,production_companies ,production_countries ,release_date ,revenue ,runtime ,spoken_languages ,
status ,tagline ,title,video,vote_average ,vote_count 
FROM Movies_Metadatatemp);


DELETE FROM Credits 
WHERE id NOT IN 
(SELECT id FROM Movies_Metadata);

DELETE FROM Keywords 
WHERE id NOT IN 
(SELECT id FROM Movies_Metadata);

DELETE FROM Links 
WHERE movieId NOT IN 
(SELECT id FROM Movies_Metadata);

DELETE FROM Ratings 
WHERE movieId NOT IN 
(SELECT id FROM Movies_Metadata);

DELETE FROM Ratings_Small
WHERE movieId NOT IN 
(SELECT id FROM Movies_Metadata);

DROP TABLE CreditsTemp;

DROP TABLE GenreTemp;

DROP TABLE KeywordsTemp;

DROP TABLE LinksTemp;

DROP TABLE Movies_metadataTemp;

ALTER TABLE Movies_Metadata
ADD PRIMARY KEY (id);

ALTER TABLE Ratings
ADD PRIMARY KEY(movieId,userId);

ALTER TABLE Ratings_Small
ADD PRIMARY KEY(movieId,userId);

ALTER TABLE Credits
ADD FOREIGN KEY (id) REFERENCES Movies_Metadata(id);

ALTER TABLE Keywords
ADD FOREIGN KEY (id) REFERENCES Movies_Metadata(id);

ALTER TABLE Links
ADD FOREIGN KEY (movieId) REFERENCES Movies_Metadata(id);

ALTER TABLE Ratings
ADD FOREIGN KEY (movieId) REFERENCES Movies_Metadata(id);

ALTER TABLE Ratings_Small
ADD FOREIGN KEY (movieId) REFERENCES Movies_Metadata(id);

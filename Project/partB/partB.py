import psycopg2
import matplotlib.pyplot as plt
plt.style.use('seaborn-whitegrid')
import numpy as np
import pdb

host = ""
dbname = "Movies"
user = ""
password = ""
sslmode = "require"


conn_string = "host={0} user={1} dbname={2} password={3} sslmode={4}".format(host, user, dbname, password, sslmode)
conn = psycopg2.connect(conn_string)
print("Connection established")

cursor = conn.cursor()
print("")

# QUERY 1
cursor.execute("SELECT COUNT(id),EXTRACT(YEAR FROM release_date) FROM movies_metadata GROUP BY EXTRACT(YEAR FROM release_date) ORDER BY EXTRACT(YEAR FROM release_date);")
rows = cursor.fetchall()
print ("QUERY 1")
print("")
print("Number of movies per Year")
number_of_movies =[]
years =[]
for row in rows:
    if row[1] is not None:
        number_of_movies.append(row[0])
        years.append(int(row[1]))
fig = plt.figure(figsize = (10,5))
plt.bar(years,number_of_movies,color ="black",width = 0.5)
plt.xlabel("Years")
plt.ylabel("Number of Movies")
plt.title("Number of Movies per year")
plt.show()






print("")
print ("-----------------------------------")
print("")

# QUERY 2
cursor.execute("SELECT Genre,COUNT(Movie_id) FROM GenretoMovie,Genre WHERE Genre_id = Genre.id GROUP BY (Genre) ORDER BY COUNT(Movie_id) DESC;")
rows = cursor.fetchall()


print ("QUERY 2")
print("")
print("Number of Movies per Genre")
Genres=[]
Number_of_Movies_2=[]
for row in rows:
    if str(row[0]) == "Science Fiction":
        Genres.append("Sci-Fi")
    else:
        Genres.append(str(row[0]))
    Number_of_Movies_2.append(row[1])
fig = plt.figure(figsize = (10,5))
plt.bar(Genres,Number_of_Movies_2,color ="black",width = 0.2)
plt.xlabel("Genre")
plt.ylabel("Number of Movies")
plt.title("Number of Movies per Genre")
plt.show()


print("")
print ("-----------------------------------")
print("")


# QUERY 3 
cursor.execute("SELECT Genre,EXTRACT(YEAR FROM movies_metadata.release_date) AS Release_Year,COUNT(Movie_id) FROM GenretoMovie,movies_metadata,Genre WHERE movies_metadata.id = Genretomovie.movie_id AND Genretomovie.genre_id = Genre.id GROUP BY ROLLUP(Release_Year,Genre);")
rows = cursor.fetchall()


print ("QUERY 3")
print("")
print ("Number of movies per Genre and per Year")
Genres_3=[]
Release_year=[]
Number_of_Movies_3=[]
for row in rows:
    if (row[0] is not None and row[1] is not None):
        Genres_3.append(row[0])
        Release_year.append(row[1])
        Number_of_Movies_3.append(row[2])
Genres_id = np.array(Genres_3)
#FROM QUERY 2 WE USE THE GENRES LIST
counter = 1
Genres_in_text =""
for genre in Genres:
    if genre == "Sci-Fi":
        genre = "Science Fiction"
    Genres_id=np.where(Genres_id == genre,counter,Genres_id)
    Genres_in_text =Genres_in_text+str(counter)+"="+str(genre)+'\n'
    counter = counter + 1

fig = plt.figure()
ax = plt.axes(projection ='3d')
ax.scatter(Genres_id,Release_year,Number_of_Movies_3,c=Number_of_Movies_3,cmap='viridis')
plt.tick_params(axis='x', which='major', labelsize=10)
plt.xlabel("Genre")
plt.ylabel("Year Released")
plt.gcf().text(0.8,0.5,s=Genres_in_text,fontsize=11)
plt.grid(True)
plt.title("Number of movies per Genre and per Year")
plt.show()


print("")
print ("-----------------------------------")
print("")


# QUERY 4
cursor.execute("SELECT Genre,AVG(CAST (vote_average AS FLOAT)) AS Average_Rating FROM GenretoMovie,movies_metadata,Genre WHERE movies_metadata.id = Genretomovie.movie_id AND Genre.id = Genre_id GROUP BY ROLLUP(Genre) ORDER BY Genre;")
rows = cursor.fetchall()

print ("QUERY 4")
print("")
print("Average rating per Genre")
Genres_4=[]
Average_Rating=[]
for row in rows:
    if str(row[0]) == "Science Fiction":
        Genres_4.append("Sci-Fi")
    else:
        Genres_4.append(str(row[0]))
    Average_Rating.append(row[1])


#Visualization
fig = plt.figure(figsize = (10,5))
plt.bar(Genres_4,Average_Rating,color ="black",width = 0.2)
plt.xlabel("Genre")
plt.ylabel("Average Rating")
plt.title("Average rating per Genre")
plt.show()


print("")
print ("-----------------------------------")
print("")

# QUERY 5
print("Wating for query to complete this one takes a bit of time...")
cursor.execute("SELECT userid,COUNT(movieid) AS Number_of_Ratings FROM Ratings GROUP BY (userid) ORDER BY Number_of_Ratings DESC;")
rows = cursor.fetchall()

print("")
print ("QUERY 5")
print("")
print("Number of ratings per User")


users=[]
Number_of_Ratings_5=[]
for row in rows:
    users.append(row[0])
    Number_of_Ratings_5.append(row[1])

# #Visualization
#fig = plt.figure(figsize = (2,10))
plt.scatter(users,Number_of_Ratings_5,color ="black",alpha=0.3)
plt.ylim([0,Number_of_Ratings_5[0]+100])
plt.xlabel("User id")
plt.ylabel("Number of Ratings")
plt.title("Number of ratings per User")
plt.show()

print("")
print ("-----------------------------------")   
print("")

# QUERY 6
print("Wating for query to complete this one takes a bit of time...")
cursor.execute("SELECT userid,AVG(CAST(rating AS FLOAT)) AS Average_Rating_of_User FROM Ratings GROUP BY (userid);")
rows = cursor.fetchall()

print("")
print ("QUERY 6")
print("")
print ("Average rating of User")
users_6=[]
average_rating_of_user_6=[]
for row in rows:
    users_6.append(row[0])
    average_rating_of_user_6.append(row[1])

plt.scatter(users_6,average_rating_of_user_6,color ="Green",alpha=0.3)
# plt.ylim([0,Number_of_Ratings_5[0]+100])
plt.xlabel("User id")
plt.ylabel("Average Rating")
plt.title("Average rating of User")
plt.show()


print("")
print ("-----------------------------------")   
print("")

# Query 6.2
print("Wating for query to complete this one takes a bit of time...")
cursor.execute("SELECT COUNT(userid),Average_Rating_of_User FROM(SELECT userid,AVG(CAST(rating AS FLOAT)) AS Average_Rating_of_User FROM Ratings GROUP BY (userid)) AS Users GROUP BY (Average_Rating_of_User);")
rows = cursor.fetchall()

print("")
print ("QUERY 6.2")
print("")
print ("Number of Users per Rating Score")
users_count=[]
average_rating_of_user_7=[]
for row in rows:
    users_count.append(row[0])
    average_rating_of_user_7.append(float(row[1]))


plt.scatter(average_rating_of_user_7,users_count,color ="Black",alpha=0.3)
plt.xlabel("Average Rating Score")
plt.ylabel("Number of Users")
plt.title("Number of Users per Average rating score")
plt.show()


print("")
print ("-----------------------------------")   
print("")


# View

print("Fetching the data using the view...")
cursor.execute("SELECT * from average_ratings")
rows = cursor.fetchall()

print("")
# Data for the scatterplot
area = np.pi*2
number_of_ratings=[]
average_rating_of_user=[]
print("Scatterplot for the view Average_ratings")
for row in rows:
    number_of_ratings.append(row[1])
    average_rating_of_user.append(row[2])

plt.scatter(average_rating_of_user,number_of_ratings,area,color='black',alpha = 0.3)
plt.xlabel('Average rating of user')
plt.ylabel('Number of Ratings')
plt.title("Correlation between number of ratings and average rating")
plt.show()
    
print("Queries Completed!")


cursor.close()
conn.close()

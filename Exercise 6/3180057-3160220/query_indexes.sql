
\\---------------------------------1ST QUERY INDEX---------------------------------//

	CREATE INDEX FIRST_QUERY ON Listing2(host_id);

\\---------------------------------2ND QUERY INDEX---------------------------------//
	 	
		------------------NO CORRECT INDEX------------------
	1ο)CREATE INDEX SECOND_QUERY ON price(guests_included,price)
	2o)CREATE INDEX SECOND_QUERY ON price(guests_included,price)
	   WHERE (guests_included > 5 AND price >40 );
	3o)CREATE INDEX SECOND_QUERY_1 ON price(guests_included);
	   CREATE INDEX SECOND_QUERY_2 ON price(price);

\\---------------------------------3RD QUERY INDEX---------------------------------//
		

	---------------------------INEFFICIENT INDEX---------------------------
	
	CREATE INDEX THIRD_QUERY ON Listing2(id)


	---------------------------EFFICIENT INDEX---------------------------
	
	CREATE INDEX THIRD_QUERY ON Listing2(id)
	WHERE (room_type = 'Entire home/apt')
		

\\---------------------------------4TH QUERY INDEX---------------------------------//
		
	---------------------------NO CORRECT INDEX--------------------------
	CREATE INDEX FORTH_QUERY_1 ON Room(id);
	CREATE INDEX FORTH_QUERY_2 ON amenitytoroom(id);


\\---------------------------------5TH QUERY INDEX---------------------------------//

	---------------------------NO CORRECT INDEX--------------------------
	1ο)CREATE INDEX FIFTH_QUERY_1 ON Host(neighbourhood,id)
	   CREATE INDEX FIFTH_QUERY_2 ON Location(neighbourhood,neighbourhood_cleansed)
	2o)CREATE INDEX FIFTH_QUERY ON Host(neighbourhood,id)
	3ο)CREATE INDEX FIFTH_QUERY ON Location(neighbourhood,neighbourhood_cleansed)


\\---------------------------------6TH QUERY INDEX---------------------------------//

	CREATE INDEX SIXTH_QUERY_1 ON Location(neighbourhood_cleansed);
	CREATE INDEX SIXTH_QUERY_2 ON Room(id,beds)
	WHERE (beds > 4 );

\\---------------------------------7TH QUERY INDEX---------------------------------//

	CREATE INDEX SEVENTH_QUERY_1 ON Location(neighbourhood_cleansed,id);
ALTER TABLE Listings
ALTER COLUMN license TYPE varchar(1000);

Adding Primary and Foreign Keys:

	Calendar:
		
		ALTER TABLE Calendar
		ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);

	Listings:
		ALTER TABLE Listings
		ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES Neighbourhoods(neighbourhood)


	Listings_Summary:
		ALTER TABLE Listings_Summary
		ADD FOREIGN KEY (neighbourhood) REFERENCES Neighbourhoods(neighbourhood)
		
		ALTER TABLE Listings_Summary
		ADD FOREIGN KEY (id) REFERENCES Listings(id);

	Reviews:

		ALTER TABLE REVIEWS
		ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);
	

	Reviews-summary:

		ALTER TABLE Reviews_Summary
		ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);
		

	Geolocation:

		ALTER TABLE Geolocation
		ADD FOREIGN KEY (properties_neighbourhood) REFERENCES Neighbourhoods(neighbourhood)
	
	

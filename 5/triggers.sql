
\\---------------PROCEDURE---------------//

CREATE FUNCTION log_Listings_count_changes()
    RETURNS trigger AS
$$
BEGIN
IF (TG_OP = 'INSERT') THEN
	UPDATE Host
	SET listings_count = listings_count + 1
	WHERE Host.id = NEW.host_id;
	RETURN NEW;
ELSIF (TG_OP = 'DELETE')THEN
	UPDATE Host
	SET listings_count = listings_count - 1
	WHERE Host.id = OLD.host_id;
	RETURN OLD;
END IF;
END;
$$ LANGUAGE plpgsql;


\\---------------POSTGRES_TRIGGER---------------//

CREATE TRIGGER Listings_count_changes
AFTER DELETE OR INSERT
ON Listing2
FOR EACH ROW
EXECUTE PROCEDURE log_Listings_count_changes();





/* WHENEVER A NEW REVIEW FOR A LISTING IS ADDED THE NUMBER_OF_REVIEWS OF THE LISTING IS INCREASED AND THE DATE OF THE LAST REVIEW IS UPDATED*/

\\---------------PROCEDURE---------------//
CREATE FUNCTION log_Listings_reviews_changes()
	RETURNS trigger AS
$$
BEGIN
	UPDATE Listing2
	SET number_of_reviews = number_of_reviews + 1, last_review = NEW.date
	WHERE Listing2.id = NEW.listing_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


\\---------------POSTGRES_TRIGGER---------------//

CREATE TRIGGER Listings_reviews_changes
AFTER INSERT
ON Review2
FOR EACH ROW 
EXECUTE PROCEDURE log_Listings_reviews_changes();




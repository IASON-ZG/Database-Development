UPDATE Calendar2
SET price = REPLACE(price,'$',''), adjusted_price = REPLACE(adjusted_price,'$','');

UPDATE Calendar2
SET price = REPLACE(price,',',''),adjusted_price = REPLACE(adjusted_price,',','');

ALTER TABLE Calendar2
ALTER COLUMN price TYPE float USING price::double precision,
ALTER COLUMN adjusted_price TYPE float USING adjusted_price::double precision,
ALTER COLUMN available TYPE boolean;
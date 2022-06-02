CREATE TABLE Price
AS
(SELECT id, price, weekly_price, monthly_price, security_deposit, cleaning_fee,
guests_included, extra_people, minimum_nights, maximum_nights,
minimum_minimum_nights, maximum_minimum_nights, minimum_maximum_nights,
maximum_maximum_nights, minimum_nights_avg_ntm, maximum_nights_avg_ntm FROM Listings2);

UPDATE Price
SET price = REPLACE(price,'$',''), weekly_price = REPLACE(weekly_price,'$','')
,monthly_price = REPLACE(monthly_price,'$',''),security_deposit = REPLACE(security_deposit,'$','') , cleaning_fee = REPLACE(cleaning_fee,'$',''),
extra_people=REPLACE(extra_people,'$','');


UPDATE Price
SET price = REPLACE(price,',',''), weekly_price = REPLACE(weekly_price,',','')
,monthly_price = REPLACE(monthly_price,',',''),security_deposit = REPLACE(security_deposit,',','') , cleaning_fee = REPLACE(cleaning_fee,',',''),
extra_people=REPLACE(extra_people,',','');


ALTER TABLE Price
ALTER COLUMN  price TYPE float USING price::double precision,
ALTER COLUMN  weekly_price TYPE float USING weekly_price::double precision,
ALTER COLUMN  monthly_price TYPE float USING monthly_price::double precision,
ALTER COLUMN  security_deposit TYPE float USING security_deposit::double precision,
ALTER COLUMN  cleaning_fee TYPE float USING cleaning_fee::double precision,
ALTER COLUMN  extra_people TYPE float USING extra_people::double precision,
ALTER COLUMN minimum_nights_avg_ntm TYPE float USING minimum_nights_avg_ntm::double precision,
ALTER COLUMN  maximum_nights_avg_ntm TYPE float USING maximum_nights_avg_ntm::double precision;

ALTER TABLE Listings2
DROP COLUMN price,
DROP COLUMN weekly_price,
DROP COLUMN monthly_price,


ALTER TABLE Price
ADD FOREIGN KEY (id) REFERENCES Listings2(id)


ALTER TABLE Listings2
DROP COLUMN security_deposit,
DROP COLUMN cleaning_fee,
DROP COLUMN guests_included,
DROP COLUMN extra_people,
DROP COLUMN minimum_nights,
DROP COLUMN maximum_nights,
DROP COLUMN minimum_minimum_nights,
DROP COLUMN maximum_minimum_nights,
DROP COLUMN minimum_maximum_nights,
DROP COLUMN maximum_maximum_nights,
DROP COLUMN minimum_nights_avg_ntm,
DROP COLUMN maximum_nights_avg_ntm;


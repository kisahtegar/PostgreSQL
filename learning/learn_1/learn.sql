-- =========================================================
-- # DATA TYPE.
-- (https://www.postgresql.org/docs/current/datatype.html)


-- =========================================================
--                        [TABLE]
-- =========================================================
-- # How to create table with Postgres.
create table person (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(150),
	gender VARCHAR(11) NOT NULL,
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50)
);

-- # DROP/DELETE TABLE
DROP TABLE person;

-- # Insert records into tables.
INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    email)
values ('Jake', 'Jones', 'MALE', DATE '1990-01-10', 'jake@gmail.com');

-- =========================================================
-- # Adding bunch of mock data.
-- https://mockaroo.com

-- This using for running sql file now in (learning/learn_1/mock/person.sql)
\i /Users/User/Downloads/person.sql


-- =========================================================
--                       [SELECT]
-- =========================================================
-- # SELECT READ OPPERATION.
SELECT * FROM person;

-- # Shorting data
SELECT * FROM person ORDER BY country_of_birth;
SELECT * FROM person ORDER BY country_of_birth ASC; -- Aa --> Zz
SELECT * FROM person ORDER BY country_of_birth DESC; -- Zz --> Aa
SELECT * FROM person ORDER BY id, email; -- combine

-- # Removing duplicates
SELECT country_of_birth FROM person ORDER BY country_of_birth;	
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth;
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;

-- GROUP BY 
SELECT country_of_birth FROM person GROUP BY country_of_birth;
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth; -- Counting total
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth ORDER BY country_of_birth;
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) > 5 ORDER BY country_of_birth; -- Count must > 5

-- # WHERE CLAUSE, filter data based on condition
SELECT * FROM person WHERE gender = 'Female';
SELECT * FROM person WHERE gender = 'Male' AND country_of_birth = 'Poland';
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China');
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China') AND last_name = 'Ayars';
SELECT * FROM person WHERE country_of_birth = 'Poland' OR country_of_birth = 'China', OR country_of_birth = 'China';

-- USING IN KEYWORD
SELECT * FROM person WHERE country_of_birth IN ('China', 'Brazil', 'France');
SELECT * FROM person WHERE country_of_birth IN ('China', 'Brazil', 'France') ORDER BY country_of_birth;

-- BETWEEN
SELECT * FROM person WHERE date_of_birth BETWEEN DATE '2022-01-01' AND '2022-05-01';

-- LIKE
SELECT * FROM person WHERE email LIKE '%wikimedia.org';
SELECT * FROM person WHERE email LIKE '%google.%';
SELECT * FROM person WHERE email LIKE '______@%';
SELECT * FROM person WHERE email LIKE '_____n@%';
SELECT * FROM person WHERE country_of_birth ILIKE 'p%'; -- ILIKE will ignore uppercase 

-- # Comparison Operators
SELECT 1 = 1; -- True
SELECT 1 = 2; -- False
SELECT 1 <= 2; -- True
SELECT 1 >= 2; -- False
SELECT 1 <> 2; -- True (1 != 2)

-- # LIMIT OFFSET and FETCH
SELECT * FROM person LIMIT 5;
SELECT * FROM person OFFSET 5 LIMIT 5;
SELECT * FROM person OFFSET 5;
SELECT * FROM person OFFSET 5 FETCH FIRST 5 ROW ONLY;

-- # MIN, MAX & AVG
SELECT MAX(price) FROM car; -- MAXIMUM NUM
SELECT MIN(price) FROM car; -- MINIMUM NUM
SELECT AVG(price) FROM car; -- AVARAGE NUM
SELECT ROUND(AVG(price)) FROM car; -- ROUND AVARAGE NUM
SELECT make, model, MIN(price) FROM car GROUP BY make, model;
SELECT make MIN(price) FROM car GROUP BY make;

-- # SUM
SELECT SUM(price) FROM car;
SELECT make, SUM(price) FROM car GROUP BY make;

-- # ARITHMETIC OPERATORS
SELECT 10 + 2; -- 12
SELECT 10 - 2; -- 8
SELECT 10 / 2; -- 5
SELECT 10 * 2 + 8; -- 28

-- # WORKING WITH ARITHMETIC OPERATORS
SELECT id, make, model, price, price * .10 FROM car;
SELECT id, make, model, price, ROUND(price * .10, 2) FROM car; -- Discount 10%
SELECT id, make, model, price, ROUND(price * .10, 2), ROUND(price - (price * .10), 2) FROM car; -- Discount 10% and price - discount

-- # Alias
SELECT id, make, model, price AS original_price, ROUND(price * .10, 2) AS ten_percent_value, ROUND(price - (price * .10), 2) AS discount_after_10_percent FROM car; -- Discount 10% and price - discount

-- # Coalesce
SELECT COALESCE(1); -- can multiple argument.
SELECT COALESCE(email, 'Email not provided') FROM person; -- used when u have null column and want set default value null.

-- # NULLIF
SELECT NULLIF(10, 9); -- 10
SELECT NULLIF(10, 10); -- null
SELECT 10 / NULLIF(2, 9); -- 5
SELECT 10 / NULLIF(0, 0); -- null
SELECT COALESCE(10 / NULLIF(0, 0), 0); -- 0

-- # TIMESTAMPS & DATES
SELECT NOW(); -- 2021-12-02 22:14:35.645348+00
SELECT NOW()::DATE; -- 2021-12-02
SELECT NOW()::TIME; -- 22:14:35.645348
-- adding and subtracting dates
SELECT NOW() - INTERVAL '1 YEAR';
SELECT NOW() + INTERVAL '1 YEAR';
SELECT NOW() - INTERVAL '1 MONTHS';
SELECT NOW() + INTERVAL '1 MONTHS';
SELECT NOW()::DATE + INTERVAL '10 MONTHS';
SELECT (NOW() + INTERVAL '10 MONTHS')::DATE;
-- extracting fields from dates
SELECT EXTRACT(YEAR FROM NOW()); -- 2023
SELECT EXTRACT(MONTH FROM NOW()); -- 12
SELECT EXTRACT(DAY FROM NOW()); -- 30

-- # AGE FUNCTION
SELECT first_name, last_name, gender, country_of_birth, date_of_birth, AGE(NOW(), date_of_birth) AS age FROM person;

-- # Unique Constraints
SELECT email, COUNT(*) FROM person GROUP BY email HAVING COUNT(*) > 1;

ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE(email); -- make email unique
ALTER TABLE person ADD UNIQUE(email); -- same like top but postgres will automate name 
ALTER TABLE person DROP CONSTRAINT unique_email_address; -- delete

-- # Check Constraints
ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK(gender = 'Female' OR gender = 'Male'); --  this will checking gender must be Female or Male

-- # Deleting Records
DELETE FROM person WHERE id = 10;
DELETE FROM person WHERE gender = 'Female' AND country_of_birth = 'India';

-- # Updating Records
UPDATE person SET email = 'kisah@gmail.com' WHERE id = 9;
UPDATE person SET first_name = 'Kisah', last_name = 'Tegar', email = 'kisahtegar@gmail.com' WHERE id = 9;

-- # ON CONFLICT DO NOTHING
INSERT INTO person (id, first_name, last_name, gender, email, date_of_birth, country_of_birth) 
VALUES (9, 'Kisah', 'Tegar', 'Male', 'kisahtegar@gmail.com', DATE '2022-03-29', 'China')
ON CONFLICT (id) DO NOTHING; -- MAKE SURE NEED TO UNIQUE

-- # ON CONFLICT DO UPDATE
-- MAKE SURE NEED TO UNIQUE
INSERT INTO person (id, first_name, last_name, gender, email, date_of_birth, country_of_birth) 
VALUES (9, 'Kisah', 'Tegar', 'Male', 'kisahtegar@fire.uk', DATE '2022-03-29', 'China')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email; 

INSERT INTO person (id, first_name, last_name, gender, email, date_of_birth, country_of_birth) 
VALUES (9, 'Kisah', 'Abdi', 'Male', 'kisahtegar@fire.uk', DATE '2022-03-29', 'China')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email, last_name = EXCLUDED.last_name; 

-- # FOREIGN KEYS & RELATIONSHIPS
-- Adding Foreign Keys : person-car.sql
-- ! Updating Foreign Keys
UPDATE person SET car_id = 2 WHERE id = 1;

-- INNER JOINS: find if id match 
SELECT * FROM person JOIN car ON person.car_id = car.id; 
SELECT person.first_name, car.make, car.model, car.price FROM person JOIN car ON person.car_id = car.id; -- select what i wantS
SELECT * FROM person JOIN car USING (car_id);

-- LEFT JOINS: Include everyone if they have car or without car.
SELECT * FROM person LEFT JOIN car ON person.car_id = car.id;
SELECT * FROM person LEFT JOIN car ON person.car_id = car.id WHERE car.* IS NULL;

-- ! DELETING FOREIGN KEYS
DELETE FROM person WHERE id = 9000; -- first delete the person 
DELETE FROM car where id = 13; -- then delete the car 

-- # SEQUENCES
ALTER SEQUENCE person_id_seq RESTART WITH 5; -- Restarting next value id

-- # EXTENSIONS
SELECT * FROM pg_available_extensions; -- look all extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp"; -- install extensions
\df -- command list of functions
SELECT uuid_generate_v4(); -- Running function

-- # UUID IN ACTION
UPDATE person SET car_uid = '5810973b-6e1e-42a6-9366-ed69b4f7cdd9' WHERE person_uid = '43e39932-b95b-4849-ba81-7d39af204e61';
SELECT * FROM person JOIN car ON person.car_uid = car.car_uid;

-- # EXPORTING TO CSV
\copy (SELECT * FROM person) TO '/Path/result.csv' DELIMITER ',' CSV HEADER;
-- =========================================================
-- =========================================================
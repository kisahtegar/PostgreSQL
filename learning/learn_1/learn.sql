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



-- =========================================================
-- =========================================================
-- =========================================================
-- # DATA TYPE.
-- (https://www.postgresql.org/docs/current/datatype.html)


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


-- =========================================================
-- # Insert records into tables.
INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    email)
values ('Jake', 'Jones', 'MALE', DATE '1990-01-10', 'jake@gmail.com');


-- =========================================================
-- # SELECT READ OPPERATION.
SELECT * FROM person;


-- =========================================================
-- # Adding bunch of mock data.
-- https://mockaroo.com

-- This using for running sql file now in (learning/learn_1/mock/person.sql)
\i /Users/User/Downloads/person.sql


-- =========================================================
-- # Shorting data
SELECT * FROM person ORDER BY country_of_birth;
SELECT * FROM person ORDER BY country_of_birth ASC; -- Aa --> Zz
SELECT * FROM person ORDER BY country_of_birth DESC; -- Zz --> Aa
SELECT * FROM person ORDER BY id, email; -- combine


-- =========================================================
-- # Removing duplicates
SELECT country_of_birth FROM person ORDER BY country_of_birth;	
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth;
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;

-- =========================================================
-- WHERE CLAUSE, filter data based on condition
SELECT * FROM person WHERE gender = 'Female';
SELECT * FROM person WHERE gender = 'Male' AND country_of_birth = 'Poland';
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China');
SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = 'Poland' OR country_of_birth = 'China') AND last_name = 'Ayars';

-- =========================================================
-- Comparison Operators
SELECT 1 = 1; -- True
SELECT 1 = 2; -- False
SELECT 1 <= 2; -- True
SELECT 1 >= 2; -- False
SELECT 1 <> 2; -- True (1 != 2)


-- =========================================================
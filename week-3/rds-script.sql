CREATE DATABASE week_4_5;

\c week_4_5;

CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    name varchar(255)
);

INSERT INTO cars (name) VALUES ('bmw'), ('audi'), ('vw');

SELECT * FROM cars;
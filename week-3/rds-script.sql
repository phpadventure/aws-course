CREATE DATABASE week_4_1;

use week_4_1;

CREATE TABLE cars (
    id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(255),
    PRIMARY KEY (ID)
);

INSERT INTO cars ("name") VALUES("bmw"), ("audi"), ("vw");

SELECT * FROM cars;
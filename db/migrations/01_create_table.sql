CREATE TABLE space(
    id serial PRIMARY KEY, 
    customer_id int4, 
    name VARCHAR(60), 
    description VARCHAR(500), 
    price NUMERIC, 
    city VARCHAR(60) 
);

CREATE TABLE customer(
    id serial PRIMARY KEY, 
    email VARCHAR(60), 
    password VARCHAR(60)
);

CREATE TABLE booking(
    id serial PRIMARY KEY, 
    customer_id int4, 
    space_id int4, 
    request VARCHAR(10), 
    date_in DATE, 
    date_out DATE
);

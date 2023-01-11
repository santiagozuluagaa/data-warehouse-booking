--CREATE DATABASE booking_dw;
--\c booking_dw;
DROP TABLE IF EXISTS dim_host, dim_city, dim_lodging, dim_guest, dim_date, ft_booking;

CREATE TABLE dim_host(
	host_id INT PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	phone VARCHAR(10),
	email VARCHAR(80) NOT NULL,
	nacionality VARCHAR(20) NOT NULL,
	category VARCHAR(20)
);

CREATE TABLE dim_city(
	city_id INT PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	country VARCHAR(30) NOT NULL
);

CREATE TABLE dim_lodging(
	lodging_id INT PRIMARY KEY,
	host_id INT NOT NULL,
	city_id INT NOT NULL,
	address VARCHAR(80) NOT NULL,
	bedrooms INT NOT NULL 
		CHECK(bedrooms >= 1), 
	bathrooms INT NOT NULL 
		CHECK(bathrooms >= 0), 
	max_guests INT NOT NULL 
		CHECK(max_guests >= 1), 
	CONSTRAINT fk_lodging 
		FOREIGN KEY (host_id)
			REFERENCES dim_host(host_id),
	CONSTRAINT fk_city
		FOREIGN KEY (city_id)
			REFERENCES dim_city(city_id)
);


CREATE TABLE dim_guest(
	guest_id INT PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
	phone VARCHAR(10),
	email VARCHAR(80) NOT NULL,
	nacionality VARCHAR(20) NOT NULL
);

CREATE TABLE dim_date(
	date_id DATE PRIMARY KEY,
	day INT NOT NULL,
	weekday VARCHAR(15) NOT NULL,
	week INT NOT NULL,
	month INT NOT NULL,
	quarter VARCHAR(2) NOT NULL,
	year INT NOT NULL
);

CREATE TABLE ft_booking(
	booking_id INT PRIMARY KEY,
	lodging_id INT NOT NULL,
	guest_id INT NOT NULL,
	date_id DATE NOT NULL,
	nights INT NOT NULL
		CHECK (nights > 0),
	total_price NUMERIC NOT NULL
		CHECK (total_price > 0),
	comission NUMERIC NOT NULL
		CHECK (comission >= 0),
	review_score INT NOT NULL 
		CHECK(review_score IN (1, 2, 3, 4, 5)), 
	cleaning_fee NUMERIC NOT NULL
		CHECK(cleaning_fee >= 0),
	CONSTRAINT fk_lodging
		FOREIGN KEY (lodging_id)
			REFERENCES dim_lodging(lodging_id),
	CONSTRAINT fk_guest
		FOREIGN KEY (guest_id)
			REFERENCES dim_guest(guest_id),
	CONSTRAINT fk_date
		FOREIGN KEY (date_id)
			REFERENCES dim_date(date_id)
);
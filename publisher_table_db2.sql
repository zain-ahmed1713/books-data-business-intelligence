CREATE TABLE Publishers (
	publisher_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	publisher_name VARCHAR(60),
	publisher_revenue FLOAT
);
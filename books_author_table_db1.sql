CREATE TABLE Authors (
	author_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	author_name VARCHAR(50),
	author_rating VARCHAR(15)
);

CREATE TABLE Books (
	book_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	publishing_year INT,
	book_name VARCHAR(60),
	author_id INT,
	book_language VARCHAR(10),
	book_rating FLOAT,
	number_of_ppl_rated INT,
	book_genre VARCHAR(50),
	book_sale_price FLOAT,
	number_of_books_sold INT,
	gross_sales INT,
	FOREIGN KEY (author_id) REFERENCES Authors(author_id),
);
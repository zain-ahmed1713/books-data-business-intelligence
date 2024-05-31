CREATE TABLE Authors
(
	author_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	author_name VARCHAR(50)
);

CREATE TABLE Books
(
	book_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	book_name VARCHAR(60),
	publishing_year INT,
	author_id INT,
	publisher_id INT,
	book_language VARCHAR(10),
	book_genre VARCHAR(50),
	FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE BookRatings
(
	rating_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	book_id INT,
	book_rating DECIMAL(10, 2),
	number_of_ppl_rated INT,
	FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE BookSales
(
	sale_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	book_id INT,
	sale_price DECIMAL(10, 2),
	number_of_books_sold INT,
	gross_sales INT,
	FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE AuthorRatings
(
	author_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	author_rating VARCHAR(30),
	number_of_ppl_rated INT,
	FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE AuthorSales
(
	author_id INT IDENTITY(0, 1) NOT NULL PRIMARY KEY,
	sale_price DECIMAL(10, 2),
	number_of_books_sold INT,
	gross_sales INT,
	FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

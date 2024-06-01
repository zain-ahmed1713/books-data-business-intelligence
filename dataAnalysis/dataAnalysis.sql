-- 10 Top Rated books published in 2016
SELECT TOP 10
    book_name, publishing_year, book_rating
FROM Books
    LEFT JOIN BookRatings
    ON Books.book_id = BookRatings.book_id
WHERE Books.publishing_year = 2016
ORDER BY BookRatings.book_rating DESC;

-- Book and Genre with Highest Rating
SELECT book_name, book_genre, book_rating
FROM Books
    LEFT JOIN BookRatings
    ON Books.book_id = BookRatings.book_id
ORDER BY BookRatings.book_rating DESC;

-- Genre with Highest Rating
SELECT book_genre, SUM(book_rating) AS total_rating
FROM Books
    LEFT JOIN BookRatings
    ON Books.book_id = BookRatings.book_id
GROUP BY book_genre
ORDER BY total_rating DESC;

-- Top 10 Books whose copies were most sold
SELECT TOP 10
    Books.book_name, BookSales.number_of_books_sold
FROM 
    BookSales 
JOIN 
    Books ON BookSales.book_id = Books.book_id
ORDER BY 
    number_of_books_sold DESC;

-- Top 10 Authors with highest average book rating
SELECT TOP 10
    Authors.author_name, AVG(BookRatings.book_rating) AS avg_book_rating
FROM 
    Authors 
JOIN 
    Books ON Authors.author_id = Books.author_id
JOIN 
    BookRatings ON Books.book_id = BookRatings.book_id
GROUP BY 
    Authors.author_name
ORDER BY 
    avg_book_rating DESC;

-- Top 3 Authors who sold most books 
SELECT TOP 3
    Authors.author_name, SUM(BookSales.number_of_books_sold) AS total_books_sold
FROM 
    Authors
JOIN 
    Books ON Authors.author_id = Books.author_id
JOIN 
    BookSales ON Books.book_id = BookSales.book_id
GROUP BY 
    Authors.author_name
ORDER BY 
    total_books_sold DESC;

-- Top 3 Publishers with Highest Total Revenue
SELECT TOP 3
    Publishers.publisher_name, SUM(BookSales.gross_sales) AS total_revenue
FROM 
    ProjectDB2.dbo.Publishers 
JOIN 
    ProjectDB1.dbo.Books ON Publishers.publisher_id = Books.publisher_id
JOIN 
    ProjectDB1.dbo.BookSales ON Books.book_id = BookSales.book_id
GROUP BY 
    Publishers.publisher_name
ORDER BY 
    total_revenue DESC;

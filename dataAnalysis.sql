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

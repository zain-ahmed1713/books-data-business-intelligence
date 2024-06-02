--Update Author Ratings
USE ProjectDB1;
GO

CREATE PROCEDURE UpdateAuthorRatings
AS
BEGIN
    -- Step 1: Calculate the average book rating for each author
    DECLARE @AuthorRatings TABLE (
        author_id INT,
        average_rating DECIMAL(10, 2)
    );

    INSERT INTO @AuthorRatings (author_id, average_rating)
    SELECT 
        Books.author_id,
        AVG(BookRatings.book_rating) AS average_rating
    FROM 
        Books
    INNER JOIN 
        BookRatings ON Books.book_id = BookRatings.book_id
    GROUP BY 
        Books.author_id;

    -- Step 2: Update the AuthorRatings table with the calculated average ratings
    UPDATE AuthorRatings
    SET AuthorRatings.author_rating = CAST(AuthorRatings_temp.average_rating AS VARCHAR(30)),
        AuthorRatings.number_of_ppl_rated = (SELECT SUM(BookRatings.number_of_ppl_rated)
                                  FROM Books 
                                  INNER JOIN BookRatings ON Books.book_id = BookRatings.book_id
                                  WHERE Books.author_id = AuthorRatings.author_id)
    FROM 
        AuthorRatings
    INNER JOIN 
        @AuthorRatings AuthorRatings_temp ON AuthorRatings.author_id = AuthorRatings_temp.author_id;
-- Step 3: Select and return the updated author ratings
    SELECT 
        AuthorRatings.author_id,
        AuthorRatings.author_rating,
        AuthorRatings.number_of_ppl_rated
    FROM 
        AuthorRatings
    INNER JOIN 
        @AuthorRatings AuthorRatings_temp ON AuthorRatings.author_id = AuthorRatings.author_id;
END;
GO
EXEC UpdateAuthorRatings;

--Add BookSale
USE ProjectDB1;
GO

CREATE PROCEDURE AddBookSale
    @book_id INT,
    @sale_price DECIMAL(10, 2),
    @number_of_books_sold INT
AS
BEGIN
    -- Variable to capture the inserted row
    DECLARE @InsertedRow TABLE (
        sale_id INT,
        book_id INT,
        sale_price DECIMAL(10, 2),
        number_of_books_sold INT,
        gross_sales INT
    );

    -- Insert new sale and capture the inserted row
    INSERT INTO BookSales (book_id, sale_price, number_of_books_sold, gross_sales)
    OUTPUT inserted.sale_id, inserted.book_id, inserted.sale_price, 
           inserted.number_of_books_sold, inserted.gross_sales
    INTO @InsertedRow
    VALUES (@book_id, @sale_price, @number_of_books_sold, @sale_price * @number_of_books_sold);

    -- Select the inserted row to show the output
    SELECT * FROM @InsertedRow;
END;
GO
EXEC AddBookSale @book_id = 1, @sale_price = 19.99, @number_of_books_sold = 10;
EXEC AddBookSale @book_id = 5, @sale_price = 35, @number_of_books_sold = 5;

--Calculate Publisher Revenue
USE ProjectDB2;
GO

CREATE PROCEDURE CalculatePublisherRevenue
AS
BEGIN
    DECLARE @PublisherRevenues TABLE (
        publisher_id INT,
        total_revenue DECIMAL(10, 2)
    );

    -- Step 1: Calculate the total revenue for each publisher
    INSERT INTO @PublisherRevenues (publisher_id, total_revenue)
    SELECT 
        Books.publisher_id,
        SUM(BookSales.sale_price * BookSales.number_of_books_sold) AS total_revenue
    FROM 
        ProjectDB1.dbo.Books
    INNER JOIN 
        ProjectDB1.dbo.BookSales ON Books.book_id = BookSales.book_id
    GROUP BY 
        Books.publisher_id;

    -- Step 2: Update the Publishers table with the calculated revenues
    UPDATE Publishers
    SET Publishers.publisher_revenue = pr.total_revenue
    FROM 
        Publishers
    INNER JOIN 
        @PublisherRevenues pr ON Publishers.publisher_id = pr.publisher_id;

    -- Step 3: Select and return the updated publisher revenues
    SELECT 
        Publishers.publisher_id,
        Publishers.publisher_name,
        Publishers.publisher_revenue
    FROM 
        Publishers 
    INNER JOIN 
        @PublisherRevenues pr ON Publishers.publisher_id = pr.publisher_id;
END;
GO
EXEC CalculatePublisherRevenue;
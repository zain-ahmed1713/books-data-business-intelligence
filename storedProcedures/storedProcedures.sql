-- Add Book sale
USE ProjectDB1;
GO

CREATE PROCEDURE AddBookSale
    @book_id INT,
    @sale_price DECIMAL(10, 2),
    @number_of_books_sold INT
AS
BEGIN
    INSERT INTO BookSales
        (book_id, sale_price, number_of_books_sold, gross_sales)
    VALUES
        (@book_id, @sale_price, @number_of_books_sold, @sale_price * @number_of_books_sold);
END;
GO

EXEC AddBookSale @book_id = 1012, @sale_price = 10.99, @number_of_books_sold = 10;

--Calculate Publisher Revenue
USE ProjectDB2;
GO

CREATE PROCEDURE CalculatePublisherRevenue
AS
BEGIN
    UPDATE Publishers
    SET publisher_revenue = (
        SELECT SUM(BookSales.sale_price * BookSales.number_of_books_sold) AS total_revenue
    FROM ProjectDB1.dbo.Books
        INNER JOIN ProjectDB1.dbo.BookSales ON Books.book_id = BookSales.book_id
    WHERE Books.publisher_id = Publishers.publisher_id
    );

    SELECT publisher_id, publisher_name, publisher_revenue
    FROM Publishers;
END;
GO

EXEC CalculatePublisherRevenue;

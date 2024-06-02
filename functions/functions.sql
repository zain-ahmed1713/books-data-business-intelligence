-- Calculate average book rating by genre
USE ProjectDB1;
GO
CREATE FUNCTION GetAverageBookRatingByGenre(@genre VARCHAR(50))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @averageRating DECIMAL(10, 2);

    SELECT @averageRating = AVG(br.book_rating)
    FROM Books b
        INNER JOIN BookRatings br ON b.book_id = br.book_id
    WHERE b.book_genre = @genre;

    RETURN @averageRating;
END;
GO

SELECT ProjectDB1.dbo.GetAverageBookRatingByGenre('Fiction') AS AverageRating;

-- Calculate Author Revenue
USE ProjectDB1;
GO
CREATE FUNCTION CalculateAuthorRevenue(@author_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @totalRevenue DECIMAL(10, 2);

    SELECT @totalRevenue = SUM(bs.sale_price * bs.number_of_books_sold)
    FROM BookSales bs
        INNER JOIN Books b ON bs.book_id = b.book_id
    WHERE b.author_id = @author_id;

    RETURN @totalRevenue;
END;
GO

SELECT ProjectDB1.dbo.CalculateAuthorRevenue(1) AS TotalRevenue;

-- Calculate Pulisher Revenue Percentage
USE ProjectDB2;
GO
CREATE FUNCTION GetPublisherRevenuePercentage(@publisher_id INT)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @publisherRevenue DECIMAL(10, 2);
    DECLARE @totalRevenue DECIMAL(10, 2);
    DECLARE @percentage DECIMAL(5, 2);

    SELECT @publisherRevenue = publisher_revenue
    FROM Publishers
    WHERE publisher_id = @publisher_id;

    SELECT @totalRevenue = SUM(publisher_revenue)
    FROM Publishers;

    IF @totalRevenue = 0
        SET @percentage = 0;
    ELSE
        SET @percentage = (@publisherRevenue / @totalRevenue) * 100;

    RETURN @percentage;
END;
GO

SELECT ProjectDB2.dbo.GetPublisherRevenuePercentage(1) AS PublisherRevenuePercentage;

CREATE LOGIN zainahmed2 WITH PASSWORD = '171345';

-- Grant Permissions
USE ProjectDB1;
CREATE USER zainahmed2 FOR LOGIN zainahmed2;
GRANT SELECT, UPDATE, DELETE ON Authors TO zainahmed2;
GRANT SELECT, UPDATE, DELETE ON Books TO zainahmed2;
GRANT SELECT, UPDATE, DELETE ON BookRatings TO zainahmed2;
GRANT SELECT, UPDATE, DELETE ON BookSales TO zainahmed2;
GRANT SELECT, UPDATE, DELETE ON AuthorRatings TO zainahmed2;
GRANT SELECT, UPDATE, DELETE ON AuthorSales TO zainahmed2;
GRANT ALTER ON SCHEMA::dbo TO zainahmed2;

USE ProjectDB2;
CREATE USER zainahmed2 FOR LOGIN zainahmed2;
GRANT SELECT, UPDATE, DELETE ON Publishers TO zainahmed2;
GRANT ALTER ON SCHEMA::dbo TO zainahmed2;


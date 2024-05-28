import pandas as pd
import pyodbc

server = 'ZAIN\\ZAINSSERVER'
database = 'ProjectDB1'
username = 'zainahmed'
password = '171345'
driver = '{ODBC Driver 17 for SQL Server}'
csvPath = 'C:/Users/zaina/OneDrive/Desktop/Workspace/books-data-business-intelligence/Books_Data.csv'

conn = pyodbc.connect('DRIVER=' + driver + ';SERVER=' + server + ';DATABASE=' + database + ';UID=' + username + ';PWD=' + password)

df = pd.read_csv(csvPath)

i = 0

for publishingYear, bookName, bookLanguage, bookRating, numPeopleRated, bookGenre, bookSalePrice, numBooksSold, grossSales in zip(df['Publishing Year'], df['Book Name'], df['language_code'], df['Book_average_rating'], df['Book_ratings_count'], df['genre'], df['sale price'], df['units sold'], df['gross sales']):
    conn.execute("INSERT INTO Books (publishing_year, book_name, author_id, book_language, book_rating, number_of_ppl_rated, book_genre, book_sale_price, number_of_books_sold, gross_sales) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", int(publishingYear), bookName, i, bookLanguage, float(bookRating), numPeopleRated, bookGenre, float(bookSalePrice), numBooksSold, float(grossSales))

    i = i + 1

cursor = conn.cursor()
conn.commit()
conn.close()

print("Data insertion completed successfully.")

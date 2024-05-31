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

for bookName, publishingYear, bookLanguage, bookGenre in zip(df['Book Name'], df['Publishing Year'], df['language_code'], df['genre']):
    conn.execute("INSERT INTO Books (book_name, publishing_year, author_id, publisher_id, book_language, book_genre) VALUES (?, ?, ?, ?, ?, ?)", bookName, publishingYear, i, i, bookLanguage, bookGenre)
    i = i + 1

cursor = conn.cursor()
conn.commit()
conn.close()

print("Data insertion completed successfully.")

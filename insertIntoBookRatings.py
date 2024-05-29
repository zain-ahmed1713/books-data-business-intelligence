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

for bookRating, numberOfPeopleRated in zip(df['Book_average_rating'], df['Book_ratings_count']):
    conn.execute("INSERT INTO BookRatings (book_id, book_rating, number_of_ppl_rated) VALUES (?, ?, ?)", i, bookRating, numberOfPeopleRated)
    i = i + 1

cursor = conn.cursor()
conn.commit()
conn.close()

print("Data insertion completed successfully.")

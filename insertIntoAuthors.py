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

for authorName, authorRating in zip(df['Author'], df['Author_Rating']):
    conn.execute("INSERT INTO Authors (author_name, author_rating) VALUES (?, ?)", authorName, authorRating)

cursor = conn.cursor()
conn.commit()
conn.close()

print("Data insertion completed successfully.")

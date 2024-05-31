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

for authorName in zip(df['Author']):
    conn.execute("INSERT INTO Authors (author_name) VALUES (?)", authorName)

cursor = conn.cursor()
conn.commit()
conn.close()

print("Data insertion completed successfully.")

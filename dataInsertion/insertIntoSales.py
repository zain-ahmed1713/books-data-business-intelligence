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

for salesPrice, numberOfBooksSold, grossSales in zip(df['sale price'], df['units sold'], df['gross sales']):
    conn.execute("INSERT INTO BookSales (book_id, sale_price, number_of_books_sold, gross_sales) VALUES (?, ?, ?, ?)", i, salesPrice, numberOfBooksSold, grossSales)
    i = i + 1

cursor = conn.cursor()
conn.commit()
conn.close()

print("Data insertion completed successfully.")

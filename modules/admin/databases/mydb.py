import mysql.connector

def get_database_connection():
    # Connect to MySQL database
    mydb = mysql.connector.connect(
        host="localhost",
        user="vedam10",
        password="Welcome@123",
        database="adm"
    )
    return mydb

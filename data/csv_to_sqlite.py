import pandas as pd
import sqlite3
import os

# Path to the SQLite database
db= 'data/project.db'

# Path to the data folder
data_folder_path = 'data'

# Connect to the SQLite database
conn = sqlite3.connect(db)

# Function to create a table for each CSV file
def create_table_from_csv(csv_file):
    # Read the CSV file into a DataFrame
    df = pd.read_csv(os.path.join(data_folder_path, csv_file))
    
    # Infer the table name from the CSV file name
    table_name = os.path.splitext(csv_file)[0]
    
    # Use DataFrame to create table in the SQLite database
    df.to_sql(table_name, conn, if_exists='append', index=False)

# Process each CSV file
for csv_file in os.listdir(data_folder_path):
    if csv_file.endswith('.csv'):
        create_table_from_csv(csv_file)

# Close the connection
conn.close()
import pandas as pd
data = pd.read_csv('imdb_top_1000.csv')

print(data.head())
print(data.info())
print(data.describe())

#data['Gross'].fillna({'Gross': 0}, inplace=True);
data.dropna(subset=['Series_Title', 'Released_Year'], inplace=True)
data['Gross'] = data['Gross'].str.replace(',', '').astype(float)
#data['Movie_Age'] = 2025 - data['Released_Year']

from snowflake.sqlalchemy import URL
from sqlalchemy import create_engine


#Set up Snowflake connection
snowflake_connection = {
    'account': 'teaoucc-ZN09737',         # E.g., 'abcd1234.us-east-1'
    'user': 'sysmith27',
    'password': 'Taffy5045!',
    'database': 'MovieData',
    'schema': 'PUBLIC',
    'warehouse': 'COMPUTE_WH'
}

engine = create_engine(URL(
    account=snowflake_connection['account'],
    user=snowflake_connection['user'],
    password=snowflake_connection['password'],
    database=snowflake_connection['database'],
    schema=snowflake_connection['schema'],
    warehouse=snowflake_connection['warehouse']
))

#Load data into Snowflake
try:
    data.to_sql('movies', engine, if_exists='replace', index=False)
    print("Data loaded successfully into Snowflake!")
except Exception as e:
    print(f"Error loading data: {e}")
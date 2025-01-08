# MovieDataAnalysis
<img width="942" alt="Screenshot 2025-01-08 at 11 27 00 AM" src="https://github.com/user-attachments/assets/44e5501b-d595-48f4-83e6-7612f1c625b8" />

# IMDB Movie Data Analytics Dashboard
An interactive data analytics project designed to process, clean, and visualize IMDB movie data. This project leverages Snowflake for database management, Python for data preprocessing, and Power BI for creating actionable insights.

# Features
Data Preprocessing: Cleaned and transformed raw IMDB movie data using Python (pandas).
Database Integration: Designed and implemented a star schema in Snowflake for efficient querying.
ETL Workflow: Automated data extraction, transformation, and loading using Python.
Data Visualization: Built interactive dashboards in Power BI to analyze movie performance by genre, year, and more.
Scalable Design: The solution supports automation and scaling for larger datasets.
🛠️ Technologies Used

# Tools/Technologies
Database: Snowflake
ETL & Preprocessing: Python (pandas, SQLAlchemy)
Visualization: Power BI
Data Modeling: Star Schema

#Steps to Run the Project
1. Set Up Snowflake Database
Install the Snowflake ODBC driver and set up a connection.
Run the SQL script from scripts/snowflake_schema.sql to create the database schema.
2. Clean and Transform Data
Run the Python ETL script to clean and load the data into Snowflake
3. Build Dashboards in Power BI
Open the provided Power BI file (visuals/dashboard.pbix).
Connect it to the Snowflake database to load live data.

# Dashboard Overview
Revenue by Genre: A bar chart showing the total revenue for each genre.
Gross Revenue Over Time: 

# Future Developments
Add real-time data refresh using Snowflake tasks and Power BI Service.
Expand analytics to include actor and director performance metrics.
Integrate machine learning models for predictive analysis (e.g., predicting movie success).

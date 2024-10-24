-- Preliminaries- creation of Schema/Database
CREATE SCHEMA techtrendpro;
SHOW DATABASES;
USE techtrendpro;

-- UNDERSTANDING DATASETS
-- Load the data into the tables using the table import data wizard.
SHOW TABLES;

-- Table inspection
SELECT COUNT(*) AS Feedback_Rows FROM feedback_data;
SELECT COUNT(*) AS Product_Rows FROM product_data;
SELECT COUNT(*) AS Sales_Rows FROM sales_data;
SELECT * FROM feedback_data LIMIT 5;
SELECT * FROM product_data LIMIT 5;
SELECT * FROM sales_data LIMIT 5;

-- Understanding the structure of the datasets, show datatypes
SHOW COLUMNS FROM feedback_data;
DESCRIBE product_data;
DESC sales_data;

-- Checking for missing values
-- Feedback_table
SELECT * FROM feedback_data
WHERE Feedback_ID IS NULL 
   OR Product_ID IS NULL 
   OR Return_Date IS NULL 
   OR Return_Reason IS NULL 
   OR Customer_Feedback IS NULL;
SELECT 
  COUNT(*) AS total_rows,
  SUM(Feedback_ID IS NULL) AS null_Feedback_ID,
  SUM(Product_ID IS NULL) AS null_Product_ID,
  SUM(Return_Date IS NULL) AS null_Return_Date,
  SUM(Return_Reason IS NULL) AS null_Return_Reason,
  SUM(Customer_Feedback IS NULL) AS null_Customer_Feedback
FROM feedback_data;

-- product_data
SELECT * FROM product_data
WHERE Product_ID IS NULL 
   OR Product_Category IS NULL 
   OR Product_Attributes IS NULL;
SELECT 
  COUNT(*) AS total_rows,
  SUM(Product_ID IS NULL) AS null_Product_ID,
  SUM(Product_Category IS NULL) AS null_Product_Category,
  SUM(Product_Attributes IS NULL) AS null_Product_Attributes
FROM product_data;

-- sales_data
SELECT * FROM sales_data
WHERE Sale_ID IS NULL 
   OR Product_ID IS NULL 
   OR Sales_Date IS NULL 
   OR Sales_Volume IS NULL 
   OR Revenue_Generated IS NULL;
SELECT 
  COUNT(*) AS total_rows,
  SUM(Sale_ID IS NULL) AS null_Sale_ID,
  SUM(Product_ID IS NULL) AS null_Product_ID,
  SUM(Sales_Date IS NULL) AS null_Sales_Date,
  SUM(Sales_Volume IS NULL) AS null_Sales_Volume,
  SUM(Revenue_Generated IS NULL) AS null_Revenue_Generated
FROM sales_data;

-- DATA CLEANING AND PREPROCESSING
# 1. Convert 'Sales Date' and 'Return Date' to datetime format
-- sales_data's sales_date column
SET SQL_SAFE_UPDATES = 0; -- turning off safe updates
ALTER TABLE sales_data MODIFY COLUMN Sales_Date DATE;
-- feedback_data's Return_date column
ALTER TABLE feedback_data MODIFY COLUMN Return_Date DATE;

# 2. Check for and remove duplicates (if any)
-- Feedback
SELECT Feedback_ID, COUNT(*) AS count_duplicates
FROM feedback_data
GROUP BY Feedback_ID
HAVING COUNT(*) > 1;
-- Product
SELECT Product_ID, COUNT(*) AS count_duplicates
FROM product_data
GROUP BY Product_ID
HAVING COUNT(*) > 1;
-- Sales
SELECT Sale_ID, COUNT(*) AS count_duplicates
FROM sales_data
GROUP BY Sale_ID
HAVING COUNT(*) > 1;
# Display the first few rows of each dataset after transformation
SELECT * FROM feedback_data LIMIT 5;
SELECT * FROM product_data LIMIT 5;
SELECT * FROM sales_data LIMIT 5;


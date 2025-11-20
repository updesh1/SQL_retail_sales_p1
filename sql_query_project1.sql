-- SQL retalil Sales Analysis :


-- STEP 1  CREATE TABLE

CREATE TABLE retail_sales
          (
             transactions_id INT PRIMARY KEY, 	
			 sale_date	DATE,
			 sale_time	TIME,
			 customer_id INT,	
			 gender	VARCHAR(20),
			 age INT,
			 category VARCHAR(30),	
			 quantiy INT,	
			 price_per_unit	FLOAT,
			 cogs	FLOAT,
			 total_sale FLOAT
           ) 

-- showing import data

SELECT * FROM retail_sales
LIMIT 10

-- COUNT DATA

SELECT COUNT(*) FROM retail_sales


-- STEP 2 CLEANING DATA


-- FINDING NULL VALUES IN TABLE :-

SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
     OR sale_date IS NULL
	 OR sale_time IS NULL 
	 OR customer_id IS NULL
	 OR gender IS NULL 
	 OR age IS NULL 
	 OR category IS NULL 
	 OR quantiy IS NULL 
	 OR price_per_unit IS NULL
	 OR cogs IS NULL
	 OR total_sale IS NULL;

-- CLEAN NULL VALUES FROM TABLES :-

DELETE FROM retail_sales
WHERE 
     transactions_id IS NULL
     OR sale_date IS NULL
	 OR sale_time IS NULL 
	 OR customer_id IS NULL
	 OR gender IS NULL 
	 OR age IS NULL 
	 OR category IS NULL 
	 OR quantiy IS NULL 
	 OR price_per_unit IS NULL
	 OR cogs IS NULL
	 OR total_sale IS NULL;


-- STEP 3  DATA EXPLORATION

-- How many sales we have ?
SELECT COUNT (*) as total_sale  FROM retail_sales

-- How many customer we have ?
SELECT COUNT (DISTINCT customer_id) AS total_customer FROM retail_sales

-- How many category we have ?
SELECT DISTINCT category FROM retail_sales



-- STEP 4  Data Analysis or Business Key Problems & Answers

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT sale_date FROM retail_sales
WHERE sale_date = '2022-11-05'


-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT category,quantiy,sale_date as month FROM retail_sales
WHERE category = 'Clothing'
      AND 
	  quantiy >= 4
	  AND
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'


-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,
       SUM(total_sale) AS net_sale,
	   COUNT(*) AS total_order 
FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT total_sale FROM retail_sales
WHERE total_sale > 1000

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender,
       category,
	   COUNT(*) as total_transaction
FROM retail_sales
GROUP BY gender,category
ORDER BY 1 


-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
     EXTRACT ( YEAR FROM sale_date) as year,
	 EXTRACT ( MONTH FROM sale_date) as month,
	 AVG (total_sale) as avg_sale
FROM retail_sales
GROUP BY 1,2 
ORDER BY 1,3 DESC

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
       SUM(total_sale) as total_sales 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
       COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY 1

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sales          --CTE (Common Table Expression) it create virtual table to use in main query
AS
(
SELECT *,
     CASE
	     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		 WHEN EXTRACT(HOUR FROM sale_time) between 12 and 17 THEN 'Afternoon'
		 ELSE 'Evening'
	 END as shift
FROM retail_sales
)
SELECT                       -- Main table
      shift,
	  COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift









-- =====================================================
-- SUPERSTORE SALES DATA ANALYSIS
-- Table: sales_data
-- =====================================================
-- 1️-DATA OVERVIEW QUERIES
-- =====================================================
-- 1. Total number of records in the dataset
SELECT
COUNT(*) AS total_records
FROM 
sales_data;

-- 2. Total number of unique cities
SELECT 
COUNT(DISTINCT City) AS total_cities
FROM 
sales_data;

-- 3. Total number of unique states
SELECT 
COUNT(DISTINCT State) AS total_states
FROM 
sales_data;

-- 4. Total number of regions
SELECT 
COUNT(DISTINCT Region) AS total_regions
FROM 
sales_data;

-- 5. List of all available product categories
SELECT 
DISTINCT Category
FROM 
sales_data;

-- 6. List of all available sub-categories
SELECT 
DISTINCT Sub_category
FROM 
sales_data;

-- 7. Customer segments available in the dataset
SELECT 
DISTINCT Segment
FROM 
sales_data;

-- 8. Shipping modes used for delivery
SELECT 
DISTINCT Ship_Mode
FROM 
sales_data;

-- =====================================================
-- 2️-DATA EXPLORATION QUERIES
-- =====================================================
-- 9. Total sales generated from all orders
SELECT  
CASE 
    WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M')
    WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K')

    ELSE ROUND(SUM(Sales),2) 
END AS total_sales 
FROM sales_data;
-- Insight: 
-- The business generated approximately $2.26M in total sales from all orders. 

-- 10. Average sales per order 
SELECT  
ROUND(AVG(Sales),2) AS avg_sales 
FROM 
sales_data;
-- Insight: 
-- The average sales value per transaction is around $230. 

-- 11. Highest sales transaction 
SELECT  
CASE 
WHEN MAX(Sales) >= 1000 THEN CONCAT(ROUND(MAX(Sales)/1000,2),' K') 
ELSE MAX(Sales) 
END AS highest_sale 
FROM sales_data;
-- Insight: 
-- The highest single order generated about $22.6K in sales. 

-- 12. Lowest sales transaction 
SELECT  
ROUND(MIN(Sales),2) AS lowest_sale 
FROM 
sales_data;
-- Insight: 
-- The smallest transaction value recorded in the dataset is around $0.44. 

-- 13. Top 10 cities by sales 
SELECT  
City, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY City 
ORDER BY SUM(Sales) DESC 
LIMIT 10; 
-- Insight: 
-- New York City generates the highest revenue followed by Los Angeles and Seattle. 

-- 14. Top 10 states by sales 
SELECT  
State, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY State 
ORDER BY SUM(Sales) DESC 
LIMIT 10;
-- Insight: 
-- California is the top performing state, followed by New York and Texas. 

-- 15. Top 5 sub categories by sales 
SELECT  
Sub_Category, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY Sub_Category 
ORDER BY SUM(Sales) DESC 
LIMIT 5;
-- Insight: 
-- Phones, Chairs, and Storage are the top revenue generating sub-categories.  

-- 16. Bottom 5 sub categories 
SELECT  
Sub_Category, 
CASE 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
ELSE SUM(Sales) 
END AS total_sales 
FROM sales_data 
GROUP BY Sub_Category 
ORDER BY SUM(Sales) ASC
LIMIT 5;
-- Insight: 
-- Fasteners, Labels, and Envelopes generate the lowest sales. 

-- 17. Sales by category 
SELECT  
Category, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY Category 
ORDER BY SUM(Sales) DESC;
-- Insight: 
-- Technology is the highest revenue generating category, followed by Furniture and Office Supplies

-- 18. Sales by segment 
SELECT  
Segment, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY Segment 
ORDER BY SUM(Sales) DESC;
-- Insight:
-- The Consumer segment contributes the majority of sales, indicating strong individual customer demand. 

-- 19. Sales by region 
SELECT  
Region, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY Region 
ORDER BY SUM(Sales) DESC;
-- Insight: 
-- The West region generates the highest sales, followed by East, Central, and South.  

-- 20. Orders by shipping mode 
SELECT  
Ship_Mode, 
COUNT(*) AS total_orders 
FROM sales_data 
GROUP BY Ship_Mode 
ORDER BY total_orders DESC;
-- Insight:
-- Standard Class is the most frequently used shipping mode, accounting for the majority of orders. 

-- 21. Top 5 cities by orders 
SELECT  
City, 
COUNT(*) AS total_orders 
FROM sales_data 
GROUP BY City 
ORDER BY total_orders DESC
LIMIT 5;
-- Insight: 
-- New York City has the highest number of orders followed by Los Angeles and Philadelphia. 

-- 22. Top 5 states by orders 
SELECT  
State, 
COUNT(*) AS total_orders 
FROM sales_data 
GROUP BY State 
ORDER BY total_orders DESC 
LIMIT 5;

-- 23. Monthly sales trend 
SELECT  
YEAR( 
COALESCE( 
STR_TO_DATE(order_date,'%m/%d/%Y'), 
STR_TO_DATE(order_date,'%d/%m/%Y') 
) 
) AS year, 
MONTH( 
COALESCE( 
STR_TO_DATE(order_date,'%m/%d/%Y'), 
STR_TO_DATE(order_date,'%d/%m/%Y') 
) 
) AS month, 
ROUND(SUM(Sales),2) AS total_sales 
FROM sales_data 
GROUP BY year, month 
ORDER BY year, month; 
-- Insight: 
-- Sales fluctuate across months with visible peaks during certain periods, indicating seasonal demand. 

-- ===================================================== 
-- 3️-BUSINESS QUESTIONS 
-- ===================================================== 

-- 24.Which Region generating highest revenue?
SELECT  
Region, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY Region 
ORDER BY SUM(Sales) DESC; 
-- Insight: 
-- The West region is the top revenue generating region in the business. 

-- 25. What are the top states by revenue?
SELECT  
State, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY State 
ORDER BY SUM(Sales) DESC 
LIMIT 3; 
-- Insight: 
-- California, New York, and Texas are the three highest revenue generating states. 
-- 26. What are the top cities by revenue 
SELECT  
City, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY City 
ORDER BY SUM(Sales) DESC 
LIMIT 3;-- Insight: 
-- New York City is the top performing city in terms of sales. 

-- 27. Which Category driving most revenue?
SELECT  
Category, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales
FROM sales_data 
GROUP BY Category 
ORDER BY SUM(Sales) DESC
LIMIT 1;
-- Insight: 
-- Technology products drive the most revenue in the business. 

-- 29.Which Segment generating most revenue ?
SELECT  
Segment, 
CASE 
WHEN SUM(Sales) >= 1000000 THEN CONCAT(ROUND(SUM(Sales)/1000000,2),' M') 
WHEN SUM(Sales) >= 1000 THEN CONCAT(ROUND(SUM(Sales)/1000,2),' K') 
END AS total_sales 
FROM sales_data 
GROUP BY Segment 
ORDER BY SUM(Sales) DESC
LIMIT 1;
-- Insight: 
-- Consumer segment contributes the highest revenue among all segments. 

-- 30. What is the Most used shipping mode 
SELECT  
Ship_Mode, 
COUNT(*) AS total_orders 
FROM sales_data 
GROUP BY Ship_Mode 
ORDER BY total_orders DESC; 
-- Note: 
-- Sales values are formatted in K (thousand) and M (million) 
-- for better readability.
-- Insight: 
-- Standard Class shipping is the preferred delivery option for most customers.  

 







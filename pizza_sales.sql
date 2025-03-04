SELECT 
	order_date
FROM pizza_sales ps;

UPDATE
	pizza_sales 
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE pizza_sales 
MODIFY COLUMN order_date DATE;

SET sql_mode = '';

SELECT 
	*
FROM pizza_sales ps;

-- KPI's REQUIREMENT

-- 1. total revenue
SELECT 
	SUM(total_price) AS total_revenue
FROM pizza_sales ps;

-- 2. Average order value
SELECT 
	SUM(total_price) / COUNT(DISTINCT order_id) AS average_order_value
FROM pizza_sales ps;

-- 3. Total pizzas sold
SELECT 
	SUM(quantity)
FROM pizza_sales ps;

-- 4. Total orders
SELECT 
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales ps;

-- 5. Average Pizzas per Orders
SELECT 
	ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_orders
FROM pizza_sales ps;

-- CHARTS REQUIREMENT
-- 1. Daily Trend for Total Orders
SELECT 
	DATE_FORMAT(order_date, '%W') AS order_day,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales ps 
GROUP BY DATE_FORMAT(order_date, '%W')
ORDER BY COUNT(DISTINCT order_id) DESC; 

-- 2. Hourly Trend for Total_Orders
SELECT 
	HOUR(order_time) AS orders_hour,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales ps 
GROUP BY 1
ORDER BY 1;

-- 3. Percentage of Sales by Pizza Category
SELECT 
    pizza_category, 
    ROUND(SUM(total_price), 1) AS Total_Sales,
    CONCAT(ROUND((SUM(total_price) / 
    (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) * 100), 2), ' %') AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY PCT DESC;

-- 4. Percentage of sales by Pizza Size 
SELECT 
	pizza_size,
	ROUND(SUM(total_price), 1) AS total_sales,
	CONCAT(ROUND((SUM(total_price) / 
	(SELECT SUM(total_price) FROM pizza_sales ps) * 100), 2), '%') AS PCT
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY 1
ORDER BY 2 DESC;

-- 5. Total pizza Sold by Pizza Category
SELECT 
	pizza_category,
	SUM(quantity) AS total_pizza_sold
FROM pizza_sales ps 
GROUP BY 1
ORDER BY 2 DESC;

-- 6. Top 5 best sellers by total pizzas sold
SELECT 
	pizza_name,
	SUM(quantity) AS total_pizza_sold
FROM pizza_sales ps 
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5;

-- 7. Bottom 5 Worst Sallers by Total Pizzas sold
SELECT 
	pizza_name,
	SUM(quantity) AS total_pizza_sold
FROM pizza_sales ps 
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;
	





	
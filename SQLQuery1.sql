USE Pizza_db;
GO
SELECT * FROM pizza_sales;

-- Getting all the Kpi's:
-- Total_Revenu -- the total of price of all the orders

SELECT SUM(total_price) AS total_revenu
FROM pizza_sales

--total nb of orders --
SELECT COUNT(DISTINCT order_id) AS total_nb_orders
FROM pizza_sales

-- Average_orders_value --
SELECT SUM(total_price) / COUNT(DISTINCT order_id)  AS avg_orders_value 
FROM pizza_sales

--Total pizzas sold --
SELECT SUM(quantity) AS total_nb_pizzas
FROM pizza_sales


--AVG nb of pizzas per order -- we use casting to avoid integer division
SELECT CAST(CAST(SUM(QUANTITY) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS avg_nb_piz_per_order
FROM PIZZA_SALES


SELECT * FROM dbo.pizza_sales;

-- Charts Requirements --
-- 1- Daily trend for total orders
SELECT DATENAME(DW,order_date) AS day_week,COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY DATENAME(DW,order_date)
ORDER BY total_orders DESC;

-- 2- Monthly trend for total orders
SELECT DATENAME(MONTH,order_date) AS month,COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY DATENAME(MONTH,order_date)
ORDER BY total_orders DESC;

-- 3- Percentage of sales by pizza category (PSC)
-- the % is sum(total_price(category_x)) * 100 / sum(total_price(all categories))
SELECT pizza_category , CAST(sum(total_price) * 100 / (SELECT sum(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PSC
FROM pizza_sales 
GROUP BY pizza_category;
-- 4- Percentage of sales by pizza size (PSS)
SELECT pizza_size , CAST(sum(total_price) * 100 / (SELECT sum(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PSS
FROM pizza_sales 
GROUP BY pizza_size;

-- 6-Top 5 best sellers by revenue, total_of_orders,total_quantity
SELECT TOP 5	
		pizza_name,
		SUM(total_price) AS total_price,
		SUM(quantity) AS total_quantity,
		COUNT(DISTINCT order_id) AS total_orders 
FROM	
		pizza_sales
GROUP BY 
		pizza_name
ORDER BY 
		total_price DESC,
		total_quantity DESC,
		total_orders DESC;
			
---top 5 just by revenu
SELECT TOP 5	
		pizza_name,
		SUM(total_price) AS revenu 
FROM	
		pizza_sales
GROUP BY 
		pizza_name
ORDER BY 
		revenu DESC;
-- 6-top 5 bottom sellers by revenue
 
 SELECT TOP 5	
		pizza_name,
		SUM(total_price) AS revenu 
FROM	
		pizza_sales
GROUP BY 
		pizza_name
ORDER BY 
		revenu ASC;
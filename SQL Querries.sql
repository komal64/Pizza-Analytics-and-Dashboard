-- Total Revenue from Pizza Sales
SELECT SUM(total_price) as 'Total Revenue'
FROM [PizzaDB].[dbo].[pizza_sales];

-- Average Order Value of Pizza Sales
SELECT SUM(total_price) / COUNT(DISTINCT order_id) as 'Avg Order Value'
FROM [PizzaDB].[dbo].[pizza_sales];

-- Total Pizza Sold 
SELECT SUM(quantity) as 'Total Pizza Sold'
FROM [PizzaDB].[dbo].[pizza_sales];

-- Total Orders from Pizza Sales
SELECT COUNT(DISTINCT order_id) as 'Total Orders'
FROM [PizzaDB].[dbo].[pizza_sales];

-- Average Pizza Per Order from Pizza Sales
SELECT CAST( CAST(SUM(quantity) as DECIMAL(10,2) )
        / CAST( COUNT(DISTINCT order_id) as DECIMAL(10,2)) as DECIMAL (10,2))
        as "Average Pizza's Per Order"
FROM [PizzaDB].[dbo].[pizza_sales];

-- Charts
-- Daily Trend for Total Orders
SELECT  DATENAME(dw, order_date) as Order_Day,
        COUNT (DISTINCT order_id) as Total_Orders
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY DATENAME(dw, order_date)
ORDER BY 2 DESC;

-- Monthly trend for Total Orders
SELECT      DATENAME(MONTH, order_date) as Month_Name,
            COUNT (DISTINCT order_id) as Total_Orders
FROM        [PizzaDB].[dbo].[pizza_sales]
GROUP BY     DATENAME(MONTH, order_date)    
ORDER BY 2 DESC;

-- Percentage of Sales by Pizza Category
SELECT  pizza_category,
        CAST(
        100* sum(total_price) / (select sum(total_price)from [PizzaDB].[dbo].[pizza_sales])
       as '% of Sales' as DECIMAL (10,2))
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_category
order by 2 DESC;

-- Percentage of Sales by Pizza Size
SELECT  pizza_size,
       100* sum(total_price) / (select sum(total_price)from [PizzaDB].[dbo].[pizza_sales])
       as '% of Sales'
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_size
order by 2 DESC;

-- Percentage of Sales by Pizza Size for 1st QTR
SELECT  pizza_size,
       100* sum(total_price) / (select sum(total_price)from [PizzaDB].[dbo].[pizza_sales] WHERE   DATEPART(QUARTER, order_date) = 1)
       as '% of Sales'
FROM    [PizzaDB].[dbo].[pizza_sales]
WHERE   DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
order by 2 DESC;

-- Top and Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders
--Top 5 Revenue
SELECT  TOP 5 pizza_name,
        SUM(total_price) AS Revenue
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 DESC;

--Bottom 5 Revenue
SELECT  TOP 5 pizza_name,
        SUM(total_price) AS Revenue
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 ASC;

--Top 5 Quantity
SELECT  TOP 5 pizza_name,
        SUM(quantity) AS Total_Qty
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 DESC;

--Bottom 5 Revenue
SELECT  TOP 5 pizza_name,
        SUM(quantity) AS Total_Qty
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 ASC;

--Top 5 Orders
SELECT  TOP 5 pizza_name,
        COUNT(DISTINCT order_id) as Orders
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 DESC;

--Bottom 5 Orders
SELECT  TOP 5 pizza_name,
        COUNT(DISTINCT order_id) as Orders
FROM    [PizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY 2 ASC;

-- Table for Analyse
SELECT	order_date, DATENAME(dw, order_date) AS Weekday,
	    CASE
        WHEN Order_Time BETWEEN '09:00:00' AND '12:00:00' THEN 'Morning'
        WHEN Order_Time BETWEEN '12:01:00' AND '15:00:00' THEN 'Lunch_Time'
        WHEN Order_Time BETWEEN '15:01:00' AND '17:00:00' THEN 'Late_Afternoon'
        WHEN Order_Time BETWEEN '17:01:00' AND '21:00:00' THEN 'Rush_Hour'
        WHEN Order_Time BETWEEN '21:01:00' AND '23:59:00' THEN 'Closing_Time'
        ELSE 'Other' END AS Time_Slot, SUM(total_price) AS Revenue,
		SUM(quantity) AS 'Total Pizza Sold', 
		COUNT(DISTINCT order_id) AS 'Total Orders'
FROM	[PizzaDB].[dbo].[pizza_sales]
GROUP BY order_date, DATENAME(dw, order_date),
        CASE
        WHEN Order_Time BETWEEN '09:00:00' AND '12:00:00' THEN 'Morning'
        WHEN Order_Time BETWEEN '12:01:00' AND '15:00:00' THEN 'Lunch_Time'
        WHEN Order_Time BETWEEN '15:01:00' AND '17:00:00' THEN 'Late_Afternoon'
        WHEN Order_Time BETWEEN '17:01:00' AND '21:00:00' THEN 'Rush_Hour'
        WHEN Order_Time BETWEEN '21:01:00' AND '23:59:00' THEN 'Closing_Time'
        ELSE 'Other' END;
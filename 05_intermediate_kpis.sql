-- Best 5 Weeks by Sales
SELECT date, SUM(weekly_sales) AS total_sales
FROM sales
GROUP BY date
ORDER BY total_sales DESC
LIMIT 5;

-- Worst 5 Weeks by Sales
SELECT date, SUM(weekly_sales) AS total_sales
FROM sales
GROUP BY date
ORDER BY total_sales ASC
LIMIT 5;

-- Store Size vs Avg Sales
SELECT store_size,
       ROUND(AVG(weekly_sales),2) AS avg_sales
FROM v_sales
GROUP BY store_size
ORDER BY avg_sales DESC;

-- Top 10 Stores by Sales
SELECT store, ROUND(SUM(weekly_sales),2) AS total_sales
FROM v_sales
GROUP BY store
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Stores by Sales & Type
SELECT store, store_type, ROUND(SUM(weekly_sales),2) AS total_sales
FROM v_sales
GROUP BY store, store_type
ORDER BY total_sales DESC
LIMIT 10;

-- Top Department per Store
SELECT store, dept, SUM(weekly_sales) AS dept_sales
FROM v_sales
GROUP BY store, dept
ORDER BY store, dept_sales DESC;

-- Total Sales
SELECT SUM(weekly_sales) AS total_sales FROM sales;

-- Average Weekly Sales
SELECT ROUND(AVG(weekly_sales),2) AS avg_weekly_sales FROM sales;

-- Avg Sales: Holiday vs Non-Holiday
SELECT isHoliday, ROUND(AVG(weekly_sales),2) AS avg_sales
FROM sales
GROUP BY isHoliday;

-- Negative Sales (Returns %)
SELECT COUNT(*) AS negative_weeks,
       ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM sales),2) AS total_pct_negative
FROM sales
WHERE weekly_sales < 0;

-- Returns by Store
SELECT store, COUNT(*) AS negative_weeks,
       ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM sales),2) AS pct_negative
FROM sales
WHERE weekly_sales < 0
GROUP BY store;

-- Store Types Count
SELECT type, COUNT(*) AS num_stores FROM stores GROUP BY type;

-- Avg Economic Indicators
SELECT ROUND(AVG(fuel_price),2) AS avg_fuel,
       ROUND(AVG(CPI),2) AS avg_cpi
FROM features;

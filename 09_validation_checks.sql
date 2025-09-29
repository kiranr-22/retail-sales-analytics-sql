-- Total rows in source tables
SELECT COUNT(*) AS stores_count FROM stores;
SELECT COUNT(*) AS sales_count FROM sales;
SELECT COUNT(*) AS features_count FROM features;

-- Should sales.store and features.store all exist in stores?
SELECT COUNT(DISTINCT store) AS sales_stores FROM sales;
SELECT COUNT(DISTINCT store) AS feature_stores FROM features;
SELECT COUNT(DISTINCT store) AS master_stores FROM stores;



-- Duplicate sales rows (same store, dept, date)
SELECT store, dept, date, COUNT(*) 
FROM sales
GROUP BY store, dept, date
HAVING COUNT(*) > 1;

-- Duplicate features rows (same store, date)
SELECT store, date, COUNT(*)
FROM features
GROUP BY store, date
HAVING COUNT(*) > 1;


-- Nulls in sales
SELECT 
  SUM(CASE WHEN weekly_sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
  SUM(CASE WHEN weekly_sales < 0 THEN 1 ELSE 0 END) AS negative_sales
FROM sales;

-- Nulls in features
SELECT 
  SUM(CASE WHEN Temperature IS NULL THEN 1 ELSE 0 END) AS null_temp,
  SUM(CASE WHEN fuel_price IS NULL THEN 1 ELSE 0 END) AS null_fuel,
  SUM(CASE WHEN CPI IS NULL THEN 1 ELSE 0 END) AS null_cpi,
  SUM(CASE WHEN Unemployment IS NULL THEN 1 ELSE 0 END) AS null_unemp
FROM features;


-- Sales data range
SELECT MIN(date) AS min_sales_date, MAX(date) AS max_sales_date FROM sales;

-- Features data range
SELECT MIN(date) AS min_features_date, MAX(date) AS max_features_date FROM features;


-- Sales with stores not in Stores table
SELECT s.store
FROM sales s
LEFT JOIN stores st ON s.store = st.store
WHERE st.store IS NULL;

-- Features with stores not in Stores table
SELECT f.store
FROM features f
LEFT JOIN stores st ON f.store = st.store
WHERE st.store IS NULL;


SELECT DISTINCT isHoliday FROM sales;
SELECT DISTINCT IsHoliday FROM features;


SELECT * FROM stores WHERE size <= 0;


SELECT * FROM features WHERE fuel_price < 0;

-- Sales direct
SELECT SUM(weekly_sales) FROM sales;

-- View-based
SELECT SUM(weekly_sales) FROM v_sales;


SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM v_sales;



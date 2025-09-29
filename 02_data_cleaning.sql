DESCRIBE temp_features;
DESCRIBE sales;
DESCRIBE stores;

-- cleen sales table 
select * FROM sales WHERE weekly_sales IS NULL;
SELECT * FROM sales WHERE weekly_sales < 0;


SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN weekly_sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN weekly_sales < 0 THEN 1 ELSE 0 END) AS negative_sales
FROM sales;


SELECT DISTINCT isHoliday
FROM sales;


-- cleen features table 

SELECT DISTINCT store
FROM temp_features
ORDER BY store;

SELECT COUNT(DISTINCT date) AS unique_date_count
FROM temp_features;

-- chocking duplicate record 
SELECT store, date, COUNT(*) AS dup_count
FROM temp_features
GROUP BY store, date
HAVING COUNT(*) > 1;

SELECT * FROM temp_features 
WHERE
    temperature IS NULL OR 
    fuel_price IS NULL OR 
    MarkDown1 IS NULL OR
    MarkDown2 IS NULL OR
    MarkDown3 IS NULL OR
    MarkDown4 IS NULL OR
    MarkDown5 IS NULL OR 
    CPI IS NULL OR
    unemployment IS NULL;
    
SELECT * FROM temp_features
WHERE
	temperature = 'NA' OR
    fuel_price = 'NA';
	
SELECT * FROM temp_features
WHERE 
    MarkDown1 = 'NA' OR
    MarkDown2 = 'NA' OR
    MarkDown3 = 'NA' OR
    MarkDown4 = 'NA' OR
    MarkDown5 = 'NA' OR
    CPI = 'NA' OR
    Unemployment = 'NA';
    

SET SQL_SAFE_UPDATES = 0;

UPDATE temp_features
SET 
    MarkDown1 = CASE WHEN MarkDown1 = 'NA' THEN 0 ELSE MarkDown1 END,
    MarkDown2 = CASE WHEN MarkDown2 = 'NA' THEN 0 ELSE MarkDown2 END,
    MarkDown3 = CASE WHEN MarkDown3 = 'NA' THEN 0 ELSE MarkDown3 END,
    MarkDown4 = CASE WHEN MarkDown4 = 'NA' THEN 0 ELSE MarkDown4 END,
    MarkDown5 = CASE WHEN MarkDown5 = 'NA' THEN 0 ELSE MarkDown5 END,
    CPI       = CASE WHEN CPI = 'NA' THEN 0 ELSE CPI END,
    Unemployment = CASE WHEN Unemployment = 'NA' THEN 0 ELSE Unemployment END;
    
    
--  re-enable safe updates
SET SQL_SAFE_UPDATES = 1; 

SELECT * FROM temp_features;

UPDATE temp_features
SET
    MarkDown1    = ROUND(MarkDown1, 2),
    fuel_price   = ROUND(fuel_price, 2),
    MarkDown2    = ROUND(MarkDown2, 2),
    MarkDown3    = ROUND(MarkDown3, 2),
    MarkDown4    = ROUND(MarkDown4, 2),
    MarkDown5    = ROUND(MarkDown5, 2),
    CPI          = ROUND(CPI, 2),
    Unemployment = ROUND(Unemployment, 2);
    
 INSERT INTO features (
    store, date, Temperature, fuel_price,
    MarkDown1, MarkDown2, MarkDown3, MarkDown4, MarkDown5,
    CPI, Unemployment, IsHoliday
)
SELECT 
    store, STR_TO_DATE(date, '%d/%m/%Y') AS date, Temperature, fuel_price,
    MarkDown1, MarkDown2, MarkDown3, MarkDown4, MarkDown5,
    CPI, Unemployment, IsHoliday
FROM temp_features;

SELECT * FROM features;


DROP TABLE temp_features;



SELECT COUNT(DISTINCT store) FROM stores;
SELECT COUNT(DISTINCT store) FROM sales;
SELECT COUNT(DISTINCT store) FROM features;

SELECT MIN(date), MAX(date) FROM sales;
SELECT MIN(date), MAX(date) FROM features;

DELETE f
FROM features f
JOIN (
    SELECT store, date
    FROM features
    WHERE date > (SELECT MAX(date) FROM sales)
) x ON f.store = x.store AND f.date = x.date;

SELECT DISTINCT s.store
FROM sales s
LEFT JOIN stores st ON s.store = st.store
WHERE st.store IS NULL;

SELECT
  SUM(CASE WHEN weekly_sales = 0 THEN 1 ELSE 0 END) AS null_weekly_sales,
  SUM(CASE WHEN weekly_sales < 0 THEN 1 ELSE 0 END) AS negative_weeks
FROM sales;

























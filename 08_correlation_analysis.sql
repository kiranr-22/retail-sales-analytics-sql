-- Correlation: Sales vs Unemployment
WITH sales_agg AS (
    SELECT store, date, SUM(weekly_sales) AS total_sales
    FROM sales
    GROUP BY store, date
)
SELECT 
    (AVG(sa.total_sales * f.Unemployment) - AVG(sa.total_sales) * AVG(f.Unemployment)) /
    (STD(sa.total_sales) * STD(f.Unemployment)) AS corr_sales_unemployment
FROM sales_agg sa
JOIN features f ON sa.store = f.store AND sa.date = f.date;

-- Correlation: Sales vs CPI
WITH sales_agg AS (
    SELECT store, date, SUM(weekly_sales) AS total_sales
    FROM sales
    GROUP BY store, date
)
SELECT 
    (AVG(sa.total_sales * f.CPI) - AVG(sa.total_sales) * AVG(f.CPI)) /
    (STD(sa.total_sales) * STD(f.CPI)) AS corr_sales_cpi
FROM sales_agg sa
JOIN features f ON sa.store = f.store AND sa.date = f.date;

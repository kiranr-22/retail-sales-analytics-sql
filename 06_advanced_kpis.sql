-- Rank Stores by Contribution %
SELECT store,
       SUM(weekly_sales) AS store_sales,
       RANK() OVER (ORDER BY SUM(weekly_sales) DESC) AS sales_rank
FROM sales
GROUP BY store;

-- Top Department per Store (Row Number)
SELECT store, dept, dept_sales
FROM (
    SELECT store, dept,
           SUM(weekly_sales) AS dept_sales,
           ROW_NUMBER() OVER (PARTITION BY store ORDER BY SUM(weekly_sales) DESC) AS rn
    FROM v_sales
    GROUP BY store, dept
) t
WHERE rn = 1
ORDER BY store;

-- Holiday Impact by Department
SELECT dept, isHoliday, ROUND(AVG(weekly_sales),2) AS avg_sales
FROM v_sales
GROUP BY dept, isHoliday
ORDER BY dept;

-- Markdown Effect on Sales
WITH sales_agg AS (
    SELECT store, date, SUM(weekly_sales) AS total_sales
    FROM sales
    GROUP BY store, date
)
SELECT CASE WHEN (MarkDown1+MarkDown2+MarkDown3+MarkDown4+MarkDown5) > 0
            THEN 'With Markdown' ELSE 'No Markdown' END AS markdown_flag,
       ROUND(AVG(sa.total_sales),2) AS avg_sales
FROM sales_agg sa
JOIN features f ON sa.store=f.store AND sa.date=f.date
GROUP BY markdown_flag;

-- Fuel Price Impact
WITH sales_agg AS (
    SELECT store, date, SUM(weekly_sales) AS total_sales
    FROM sales
    GROUP BY store, date
)
SELECT f.fuel_price, ROUND(AVG(sa.total_sales),2) AS avg_sales
FROM sales_agg sa
JOIN features f ON sa.store=f.store AND sa.date=f.date
GROUP BY f.fuel_price
ORDER BY avg_sales;

-- CPI Impact
WITH sales_agg AS (
    SELECT store, date, SUM(weekly_sales) AS total_sales
    FROM sales
    GROUP BY store, date
)
SELECT ROUND(f.CPI,2) AS CPI_level, ROUND(AVG(sa.total_sales),2) AS avg_sales
FROM sales_agg sa
JOIN features f ON sa.store=f.store AND sa.date=f.date
GROUP BY CPI_level
ORDER BY CPI_level;

-- Unemployment Impact
WITH sales_agg AS (
    SELECT store, date, SUM(weekly_sales) AS total_sales
    FROM sales
    GROUP BY store, date
)
SELECT ROUND(f.Unemployment,2) AS Unemployment_rate,
       ROUND(AVG(sa.total_sales),2) AS avg_sales
FROM sales_agg sa
JOIN features f ON sa.store=f.store AND sa.date=f.date
GROUP BY Unemployment_rate
ORDER BY Unemployment_rate;

-- Store Contribution %
SELECT store,
       SUM(weekly_sales) AS store_sales,
       ROUND(100.0 * SUM(weekly_sales) / SUM(SUM(weekly_sales)) OVER (),2) AS contribution_pct
FROM sales
GROUP BY store
ORDER BY contribution_pct DESC;

-- Returns by Store & Department
SELECT store, dept,
       SUM(CASE WHEN weekly_sales < 0 THEN weekly_sales ELSE 0 END) AS total_returns,
       SUM(CASE WHEN weekly_sales >= 0 THEN weekly_sales ELSE 0 END) AS positive_sales
FROM sales
GROUP BY store, dept
ORDER BY total_returns ASC;

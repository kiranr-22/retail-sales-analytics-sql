-- Monthly Sales Trend
SELECT YEAR(`date`) AS sales_year,
       MONTH(`date`) AS sales_month,
       ROUND(SUM(weekly_sales),2) AS monthly_sales
FROM sales
GROUP BY YEAR(`date`), MONTH(`date`)
ORDER BY sales_year, sales_month;

-- Quarterly Sales Trend
SELECT YEAR(`date`) AS sales_year,
       QUARTER(`date`) AS sales_quarter,
       ROUND(SUM(weekly_sales),2) AS quarterly_sales
FROM sales
GROUP BY sales_year, sales_quarter
ORDER BY sales_year, sales_quarter;

-- Yearly Sales with YoY Growth %
WITH yearly AS (
    SELECT store, YEAR(date) AS year, SUM(weekly_sales) AS yearly_sales
    FROM sales
    GROUP BY store, YEAR(date)
)
SELECT store, year, yearly_sales,
       LAG(yearly_sales) OVER (PARTITION BY store ORDER BY year) AS prev_year_sales,
       ROUND((yearly_sales - LAG(yearly_sales) OVER (PARTITION BY store ORDER BY year)) 
              / NULLIF(LAG(yearly_sales) OVER (PARTITION BY store ORDER BY year),0)*100,2) AS yoy_growth_pct
FROM yearly
ORDER BY store, year;

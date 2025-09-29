
-- create a view that joins salse, features

CREATE VIEW v_sales AS
SELECT s.store, s.dept, s.date, s.weekly_sales, s.isHoliday,
       f.Temperature, f.fuel_price, f.MarkDown1, f.MarkDown2,
       f.MarkDown3, f.MarkDown4, f.MarkDown5, f.CPI, f.Unemployment,
       st.type AS store_type, st.size AS store_size
FROM sales s
LEFT JOIN features f ON s.store = f.store AND s.date = f.date
LEFT JOIN stores st   ON s.store = st.store;





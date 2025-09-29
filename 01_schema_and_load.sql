CREATE DATABASE	Retail_Project;
USE	Retail_Project;


CREATE TABLE stores(
store INT PRIMARY KEY,
type CHAR(1),
size INT
);


DROP TABLE IF EXISTS SALES;
CREATE TABLE sales(
store INT,
dept INT,
date DATE,
Weekly_sales DECIMAL(15,2),
isHoliday CHAR(5),
PRIMARY KEY (Store, dept, date),
FOREIGN KEY (Store) REFERENCES stores(Store)
);

DROP TABLE IF EXISTS features;
CREATE TABLE features(
store INT,
date DATE,
Temperature DECIMAL(10,2),
fuel_price DECIMAL(10,2),
MarkDown1 DECIMAL(10,2),
MarkDown2 DECIMAL(10,2),
MarkDown3 DECIMAL(10,2),
MarkDown4 DECIMAL(10,2),
MarkDown5 DECIMAL(10,2),
CPI DECIMAL(10,2),
Unemployment DECIMAL(10,2),
IsHoliday CHAR(5),
PRIMARY KEY (store,date),
FOREIGN KEY (store) REFERENCES stores(store)
);
SELECT * FROM features;

SHOW VARIABLES LIKE 'secure_file_priv';



LOAD DATA INFILE'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\stores_data.csv'
INTO TABLE stores
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(store, type, size);

SELECT COUNT(*) FROM stores;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\sales_data.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(store, dept, @date, weekly_sales, isHoliday)
SET date = STR_TO_DATE(@date, '%d/%m/%Y');


SELECT COUNT(*) FROM sales;


DROP TABLE IF EXISTS temp_features;

CREATE TABLE temp_features (
    store INT,
    date VARCHAR(20),
    Temperature VARCHAR(20),
    fuel_price VARCHAR(20),
    MarkDown1 VARCHAR(20),
    MarkDown2 VARCHAR(20),
    MarkDown3 VARCHAR(20),
    MarkDown4 VARCHAR(20),
    MarkDown5 VARCHAR(20),
    CPI VARCHAR(20),
    Unemployment VARCHAR(20),
    IsHoliday VARCHAR(10)
  );

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\features_data.csv'
INTO TABLE temp_features
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT COUNT(*) FROM temp_features;

 




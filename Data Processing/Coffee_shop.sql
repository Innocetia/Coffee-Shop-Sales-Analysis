-- Operating hours: Opening time
SELECT MIN(date_format(transaction_time, 'HH:mm:ss')) AS opening_time
FROM workspace.coffee.bright_coffee_shop_analysis;

-- Operating hours: Closing time
SELECT MAX(date_format(transaction_time, 'HH:mm:ss')) AS closing_time
FROM workspace.coffee.bright_coffee_shop_analysis;

-- Revenue, Units Sold, Sales
SELECT
    transaction_id,
    MONTHNAME(TO_DATE(transaction_date)) AS name_of_month,
    SUM(transaction_qty * unit_price) AS total_revenue,
    SUM(transaction_qty) AS number_of_units_sold,
    COUNT(transaction_id) AS number_of_sales,

-- Time bucket
    CASE
        WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '16:00:00' AND '20:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_bucket,
    DAYNAME(TO_DATE(transaction_date)) AS day_name,
    CASE
        WHEN day_name IN ('Sun', 'Sat') THEN 'Weekend'
        ELSE 'Weekday'
        END AS day_type,
    product_category,
    product_type,
    product_detail,
    store_location
FROM workspace.coffee.bright_coffee_shop_analysis
GROUP BY time_bucket,
day_name,
product_category,
product_type,
product_detail,
transaction_id,
transaction_date,
transaction_time,
unit_price,
store_location;

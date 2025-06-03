-- 📘 Sales SQL Queries:

-- 1. All sales for customer 90002002 (fiscal year adjustment)
SELECT * FROM fact_sales_monthly 
WHERE customer_code = '90002002' 
AND YEAR(DATE_ADD(date, INTERVAL 4 MONTH))
ORDER BY date DESC;

-- 2. Detailed sales with product, variant, and gross price for 2021
SELECT s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price,
       s.sold_quantity * g.gross_price AS Gross_price_total
FROM fact_sales_monthly s 
JOIN dim_product p ON s.product_code = p.product_code 
JOIN fact_gross_price g ON g.product_code = s.product_code 
    AND g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = '90002002' 
  AND YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH)) = 2021
ORDER BY s.date DESC;

-- 3. Daily revenue trend for customer 90002002
SELECT s.date, SUM(s.sold_quantity * g.gross_price) AS Gross_price_total 
FROM fact_sales_monthly s 
JOIN fact_gross_price g ON g.product_code = s.product_code 
    AND g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = 90002002 
GROUP BY s.date
ORDER BY s.date ASC;

-- 4. Revenue by fiscal year for customer 90002002
SELECT g.fiscal_year, SUM(s.sold_quantity * g.gross_price) AS Gross_price_total 
FROM fact_sales_monthly s 
JOIN fact_gross_price g ON g.product_code = s.product_code 
    AND g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = 90002002 
GROUP BY g.fiscal_year
ORDER BY g.fiscal_year ASC;

-- 5. Monthly revenue (all customers)
SELECT 
    EXTRACT(YEAR FROM s.date) AS year,
    EXTRACT(MONTH FROM s.date) AS month,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN fact_gross_price g 
    ON s.product_code = g.product_code 
    AND g.fiscal_year = YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH))
GROUP BY year, month
ORDER BY year, month;

-- 6. Monthly unique product volume (count)
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    COUNT(DISTINCT product_code) AS order_volume
FROM fact_sales_monthly
GROUP BY year, month
ORDER BY year, month;

-- 7. Top 5 products by revenue for 2021
SELECT 
    p.product,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN dim_product p ON s.product_code = p.product_code
JOIN fact_gross_price g 
    ON s.product_code = g.product_code 
    AND g.fiscal_year = YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH))
WHERE YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH)) = 2021
GROUP BY p.product
ORDER BY total_revenue DESC
LIMIT 5;

-- 8. Yearly revenue by customer
SELECT 
    c.customer,
    EXTRACT(YEAR FROM s.date) AS year,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN dim_customer c ON s.customer_code = c.customer_code
JOIN fact_gross_price g 
    ON s.product_code = g.product_code 
    AND g.fiscal_year = YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH))
GROUP BY c.customer, year
ORDER BY year, total_revenue DESC;

-- 9. Top 3 customers by revenue in 2022
SELECT 
    c.customer,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN dim_customer c ON s.customer_code = c.customer_code
JOIN fact_gross_price g 
    ON s.product_code = g.product_code 
    AND g.fiscal_year = YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH))
WHERE YEAR(DATE_ADD(s.date, INTERVAL 4 MONTH)) = 2022
GROUP BY c.customer
ORDER BY total_revenue DESC
LIMIT 3;

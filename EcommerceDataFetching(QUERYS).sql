-- Top 10 Best-Selling Products (by Rating Count)-- 
SELECT product_name, brand_name, rating, rating_count
FROM ecommercedata
ORDER BY rating_count DESC
LIMIT 10;


-- Top Rated Products-- 
SELECT product_name, brand_name, rating
FROM ecommercedata
WHERE rating IS NOT NULL
ORDER BY rating DESC
LIMIT 10;

-- Average Discount Per Brand-- 
SELECT brand_name, AVG(CAST(discount_percent AS DECIMAL(5,2))) AS avg_discount
FROM ecommercedata
WHERE discount_percent REGEXP '^[0-9.]+$'
GROUP BY brand_name
ORDER BY avg_discount DESC;


--  Count of Products per Brand-- 
SELECT brand_name, COUNT(*) AS total_products
FROM ecommercedata
GROUP BY brand_name
ORDER BY total_products DESC;

-- Most Discounted Products-- 
SELECT product_name, brand_name, discount_amount, discounted_price
FROM ecommercedata
ORDER BY discount_amount DESC
LIMIT 10;

 -- Products with No Discount-- 
SELECT product_name, marked_price, discounted_price
FROM ecommercedata
WHERE discount_amount = 0 OR discount_percent = '0';


--  Products with No Discount
SELECT product_tag, COUNT(*) AS count
FROM ecommercedata
GROUP BY product_tag
ORDER BY count DESC;


-- Product Count by Tag-- 
SELECT product_tag, COUNT(*) AS count
FROM ecommercedata
GROUP BY product_tag
ORDER BY count DESC;

-- 8. Products Grouped by Price Range-- 
SELECT 
  CASE
    WHEN discounted_price < 500 THEN 'Under ₹500'
    WHEN discounted_price BETWEEN 500 AND 999 THEN '₹500 - ₹999'
    WHEN discounted_price BETWEEN 1000 AND 1999 THEN '₹1000 - ₹1999'
    ELSE '₹2000+'
  END AS price_range,
  COUNT(*) AS product_count
FROM ecommercedata
GROUP BY price_range;

--  Data Quality Checks
-- Missing Ratings

SELECT COUNT(*) AS missing_ratings
FROM ecommercedata
WHERE rating IS NULL OR rating = 0;

SELECT COUNT(*) AS missing_discounts
FROM ecommercedata
WHERE discount_percent IS NULL OR discount_percent = '';

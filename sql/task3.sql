-- Problem 9: Retrieve the top 3 categories with the highest total sales amount
-- Write an SQL query to retrieve the top 3 categories with the highest total sales amount.
-- The result should include the category ID, category name, and the total sales amount.
-- Hint: You may need to use subqueries, joins, and aggregate functions to solve this problem.

SELECT c.category_id, c.category_name, SUM(oi.quantity * oi.unit_price) AS total_sales_amount
FROM category_data c
JOIN product_data p ON c.category_id = p.category_id
JOIN order_items_data oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_sales_amount DESC
LIMIT 3;


-- Problem 10: Retrieve the users who have placed orders for all products in the Toys & Games
-- Write an SQL query to retrieve the users who have placed orders for all products in the Toys & Games
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries, joins, and aggregate functions to solve this problem.

SELECT u.user_id, u.username
FROM user_data u
WHERE EXISTS(
    SELECT p.product_id
    FROM product_data p
    WHERE p.category_id = (
        SELECT category_id
        FROM category_data
        WHERE category_name = 'Toys & Games'
    )
    EXCEPT
    SELECT oi.product_id
    FROM order_items_data oi
    JOIN order_data o ON oi.order_id = o.order_id
    WHERE o.user_id = u.user_id
);


-- Problem 11: Retrieve the products that have the highest price within each category
-- Write an SQL query to retrieve the products that have the highest price within each category.
-- The result should include the product ID, product name, category ID, and price.
-- Hint: You may need to use subqueries, joins, and window functions to solve this problem.

WITH RankedProducts AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        p.price,
        ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.price DESC) AS rn
    FROM
        product_data p
)
SELECT
    rp.product_id,
    rp.product_name,
    rp.category_id,
    rp.price
FROM
    RankedProducts rp
WHERE
    rp.rn = 1;


-- Problem 12: Retrieve the users who have placed orders on consecutive days for at least 3 days
-- Write an SQL query to retrieve the users who have placed orders on consecutive days for at least 3 days.
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries, joins, and window functions to solve this problem.

SELECT DISTINCT u.user_id, u.username
FROM user_data u
JOIN order_data o1 ON u.user_id = o1.user_id
JOIN order_data o2 ON u.user_id = o2.user_id
             AND DATE(o2.order_date) = DATE(o1.order_date, '+1 day')
JOIN order_data o3 ON u.user_id = o3.user_id
             AND DATE(o3.order_date) = DATE(o1.order_date, '+2 days')
WHERE (o1.order_date <= o2.order_date) AND (o2.order_date <= o3.order_date);

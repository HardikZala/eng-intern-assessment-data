-- Problem 1: Retrieve all products in the Sports category
-- Write an SQL query to retrieve all products in a specific category.

SELECT product_name as 'Sports Products'
FROM product_data as p
INNER JOIN category_data as c 
ON p.category_id = c.category_id
WHERE c.category_name LIKE 'Sports%';

-- Problem 2: Retrieve the total number of orders for each user
-- Write an SQL query to retrieve the total number of orders for each user.
-- The result should include the user ID, username, and the total number of orders.

SELECT u.user_id, u.username, COUNT(u.user_id) as total_orders
FROM user_data as u
INNER JOIN order_data as o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username;
    
-- Problem 3: Retrieve the average rating for each product
-- Write an SQL query to retrieve the average rating for each product.
-- The result should include the product ID, product name, and the average rating.

SELECT r.product_id, p.product_name, AVG(r.rating) as average_rating
FROM review_data r
RIGHT JOIN product_data p ON r.product_id = p.product_id
GROUP BY p.product_name;


-- Problem 4: Retrieve the top 5 users with the highest total amount spent on orders
-- Write an SQL query to retrieve the top 5 users with the highest total amount spent on orders.
-- The result should include the user ID, username, and the total amount spent.

SELECT u.user_id, u.username, SUM(o.total_amount) AS total_amount_spent
FROM user_data u
LEFT JOIN order_data o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_amount_spent DESC
LIMIT 5;

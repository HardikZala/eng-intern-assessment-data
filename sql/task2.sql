-- Problem 5: Retrieve the products with the highest average rating
-- Write an SQL query to retrieve the products with the highest average rating.
-- The result should include the product ID, product name, and the average rating.
-- Hint: You may need to use subqueries or common table expressions (CTEs) to solve this problem.

SELECT p.product_id, p.product_name, AVG(r.rating) AS average_rating
FROM product_data p
INNER JOIN review_data r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) = (
    SELECT MAX(average_rating)
    FROM (
        SELECT p.product_id, AVG(r.rating) AS average_rating
        FROM product_data p
        INNER JOIN review_data r ON p.product_id = r.product_id
        GROUP BY p.product_id
    ) AS subquery
);


-- Problem 6: Retrieve the users who have made at least one order in each category
-- Write an SQL query to retrieve the users who have made at least one order in each category.
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries or joins to solve this problem.

SELECT p.product_id, p.product_name, AVG(r.rating) AS average_rating
FROM product_data p
INNER JOIN review_data r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) = (
    SELECT MAX(average_rating)
    FROM (
        SELECT p.product_id, AVG(r.rating) AS average_rating
        FROM product_data p
        INNER JOIN review_data r ON p.product_id = r.product_id
        GROUP BY p.product_id
    ) AS subquery
);

-- Write an SQL query to retrieve the products that have not received any reviews.
-- The result should include the product ID and product name.
-- Hint: You may need to use subqueries or left joins to solve this problem.

SELECT p.product_id, p.product_name
FROM product_data p
LEFT JOIN review_data r ON p.product_id = r.product_id
WHERE r.review_id IS NULL;


-- Problem 8: Retrieve the users who have made consecutive orders on consecutive days
-- Write an SQL query to retrieve the users who have made consecutive orders on consecutive days.
-- The result should include the user ID and username.
-- Hint: You may need to use subqueries or window functions to solve this problem.

SELECT DISTINCT u.user_id, u.username
FROM user_data u
WHERE (
    SELECT 1
    FROM order_data o1
    WHERE o1.user_id = u.user_id
    AND (
        SELECT 1
        FROM order_data o2
        WHERE o2.user_id = u.user_id
        AND o2.order_date = DATE(o1.order_date, '+1 day')));



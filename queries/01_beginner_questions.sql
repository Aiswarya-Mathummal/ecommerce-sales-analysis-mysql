-- ------------------------------------------------------------------------------------------------------------------
-- Beginner — SELECT, WHERE, ORDER BY, LIMIT 
-- ------------------------------------------------------------------------------------------------------------------

-- 1. List all customers from a specific country. 
select * from customers where country = "india";

-- ------------------------------------------------------------------------------------------------------------------

-- 2. Show all orders placed in the last 30 days. 
select * from orders order by order_date desc limit 30;

-- ------------------------------------------------------------------------------------------------------------------

-- 3. Find the 10 most expensive products. 
select distinct product,unit_price from orders order by unit_price desc limit 10;

-- ------------------------------------------------------------------------------------------------------------------

-- 4. List all orders with status = 'delivered'. 
select * from orders where order_status = "delivered";

-- ------------------------------------------------------------------------------------------------------------------

-- 5. Find customers who signed up in 2025. 
select * from customers where year(signup_date) = 2025 ;

-- ------------------------------------------------------------------------------------------------------------------

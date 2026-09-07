-- ------------------------------------------------------------------------------------------------------------------
-- Beginner — SELECT, WHERE, ORDER BY, LIMIT 
-- ------------------------------------------------------------------------------------------------------------------

-- 1. Find all customers whose first name starts with 'A'.
select * from customers where first_name like "a%";

-- ------------------------------------------------------------------------------------------------------------------
-- 2. Which customers are from either Mumbai, Delhi, or Bengaluru?
select * from customers where city in ("Mumbai","Delhi","Bengaluru");

-- ------------------------------------------------------------------------------------------------------------------

-- 3. Find all orders placed between January 1, 2025 and June 30, 2025.
select order_id,customer_id,order_date,order_status from orders
where order_date between '2025-01-01' and '2025-06-30';

-- ------------------------------------------------------------------------------------------------------------------

-- 4. Which products have a unit price below ₹2,000?

select product_id,category,product_name,unit_price from products where unit_price < 2000;

--  ------------------------------------------------------------------------------------------------------------------

-- 5. Find all orders that were cancelled.

select order_id,customer_id,product_id,total_amount,order_date,order_status from orders
where order_status = "cancelled";

-- ------------------------------------------------------------------------------------------------------------------

-- 6. Which customers signed up before January 1, 2024?

select * from customers where signup_date > "2024-01-01";

-- ------------------------------------------------------------------------------------------------------------------

-- 7. Display the 5 cheapest products.
select product_id,category,product_name,unit_price from products 
order by unit_price asc limit 5;

-- ------------------------------------------------------------------------------------------------------------------

-- 8. Find all sellers whose city is Chennai.
select * from sellers where city = "chennai";

-- ------------------------------------------------------------------------------------------------------------------

-- 9. Which orders were paid using either Cash or paypal?
select order_id,customer_id,product_id,total_amount,order_date,order_status,payment_method from orders
where payment_method in ("Cash on delivery","paypal");

-- ------------------------------------------------------------------------------------------------------------------

-- 10. Find the 15 orders with the highest total amount.
select order_id,customer_id,product_id,total_amount from orders
order by total_amount desc limit 15;

-- -- ------------------------------------------------------------------------------------------------------------------

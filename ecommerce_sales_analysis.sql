-- ------------------------------------------------------------------------------------------------------------------
create database ecommerce_db;
use ecommerce_db;

-- ------------------------------------------------------------------------------------------------------------------

describe customers;

update customers set signup_date = str_to_date(signup_date,"%d-%m-%Y");
alter table customers modify signup_date date;

ALTER TABLE customers MODIFY customer_id VARCHAR(20) NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------

describe orders;

update orders set order_date = str_to_date(order_date,"%d-%m-%Y");
alter table orders modify order_date date;

ALTER TABLE orders MODIFY customer_id VARCHAR(20),MODIFY order_id VARCHAR(20) NOT NULL;

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
-- Intermediate — JOINs, GROUP BY, HAVING, Aggregates 
-- ------------------------------------------------------------------------------------------------------------------

-- 1. What is the total revenue generated so far? 
select sum(total_amount) as total_revenue from orders;

-- ------------------------------------------------------------------------------------------------------------------

-- 2. Which product category has sold the most units? 
select category,sum(quantity) as total_count from orders 
group by category order by total_count desc limit 1;

-- ------------------------------------------------------------------------------------------------------------------

-- 3. List the top 5 customers by total amount spent. 
select o.customer_id, c.first_name,c.last_name,c.country,sum(o.total_amount) as total_spend 
from customers c join orders o on c.customer_id = o.customer_id 
group by o.customer_id 
order by total_spend desc 
limit 5;

-- ------------------------------------------------------------------------------------------------------------------

-- 4. Which sellers have generated more than a set revenue threshold? (HAVING) 
select seller_id,sum(total_amount) as total_revenue from orders 
group by seller_id 
having total_revenue > 25000 
order by total_revenue desc  ;

-- ------------------------------------------------------------------------------------------------------------------

-- 5. What is the average order value per country? 
select country,avg(total_amount) as avg_amount from orders group by country order by country;

-- ------------------------------------------------------------------------------------------------------------------

-- 6. How many orders did each payment type handle, and what's the average payment value per type? 
select payment_method,count(*) as total_count,avg(total_amount) as avg_amount from orders 
group by payment_method
order by total_count desc;

-- ------------------------------------------------------------------------------------------------------------------
-- Advanced — Subqueries, CTEs, Window Functions, Views 
-- ------------------------------------------------------------------------------------------------------------------

-- 1. Rank products by total revenue within each category using RANK() or DENSE_RANK(). 
with product_rank_cte as (select category,product,sum(total_amount) as total_revenue 
from orders group by category,product)
select  category,product,total_revenue,
dense_rank() over (partition by category order by total_revenue desc) as product_rank 
from product_rank_cte ;

-- ------------------------------------------------------------------------------------------------------------------

-- 2. Find customers who spent more than the average customer spend (subquery). 
select c.customer_id,c.first_name,c.last_name,sum(o.total_amount) as total_spend 
from customers c join orders o on c.customer_id = o.customer_id 
group by c.customer_id  
having total_spend > (select avg(total_amount) as average_spend from orders);

-- ------------------------------------------------------------------------------------------------------------------

-- 3. Identify repeat customers (customers with more than 20 order) using GROUP BY + HAVING. 
select customer_id,count(*) as order_count from orders 
group by customer_id having  order_count>20 order by order_count desc;

-- ------------------------------------------------------------------------------------------------------------------

-- 4. Create a view called monthly_sales_summary that a dashboard tool could read directly. 
create view monthly_sales_summary as 
(select year(order_date) as year, month(order_date) as month,sum(total_amount) AS total_sales
from orders
group by year(order_date), month(order_date)
order by year desc, month desc);

-- ------------------------------------------------------------------------------------------------------------------

-- 5. Write a stored procedure get_customer_history(customer_id) that returns a customer's full order history.
delimiter //
create procedure get_customer_history(IN cust_id varchar(20))
begin
    select customer_id,product,quantity,unit_price,total_amount,order_date,order_status
    from orders
    where customer_id = cust_id;
end//
delimiter ;

call get_customer_history("CUST5711");
-- ------------------------------------------------------------------------------------------------------------------
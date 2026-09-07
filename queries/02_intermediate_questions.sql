-- ------------------------------------------------------------------------------------------------------------------
-- Intermediate — JOINs, GROUP BY, HAVING, Aggregates 
-- ------------------------------------------------------------------------------------------------------------------


-- 1. How many customers are there in each city?
select city,count(*) as customer_count from customers
group by city order by customer_count desc;

-- ------------------------------------------------------------------------------------------------------------------
-- 2. What is the total revenue for each city?
select city,sum(total_amount) as total_revenue from orders
group by city order by total_revenue desc;

-- ------------------------------------------------------------------------------------------------------------------

-- 3. Which product category generated the highest revenue?
select p.category,sum(o.total_amount) as highest_revenue 
from orders o join products p on o.product_id = p. product_id
group by p.category order by highest_revenue desc limit 1;

-- ------------------------------------------------------------------------------------------------------------------

-- 4. What is the average unit price for each product category?
select category,avg(unit_price) as avg_price from products
group by category order by avg_price desc;

--  ------------------------------------------------------------------------------------------------------------------

-- 5. Which customers have spent more than ₹50,000 in total?
select c.customer_id,c.first_name,c.last_name,sum(o.total_amount) as total_spend 
from customers c join orders o on c.customer_id = o.customer_id
group by  customer_id having total_spend > 50000 
order by total_spend desc;

-- ------------------------------------------------------------------------------------------------------------------

-- 6. How many units of each product have been sold?
select p.category,p.product_name,sum(o.quantity) as total_units_sold
from orders o join products p on o.product_id = p.product_id
group by p.category,p.product_name order by total_units_sold desc;

-- ------------------------------------------------------------------------------------------------------------------

-- 7. Which sellers have sold more than 100 units in total?
select p.seller_id,s.seller_name,sum(o.quantity) as total_units_sold 
from sellers s 
join products p on p.seller_id = s.seller_id
join orders o on p.product_id = o.product_id  
group by p.seller_id,s.seller_name
having total_units_sold > 100
order by total_units_sold desc;

-- ------------------------------------------------------------------------------------------------------------------

-- 8. What is the minimum, maximum, and average order value for each payment method?
select payment_method,min(total_amount) as minimum_order_value,
max(total_amount) as maximum_order_value,avg(total_amount)as average_order_value
from orders group by payment_method order by payment_method;

-- ------------------------------------------------------------------------------------------------------------------

-- 9. Which product has generated the highest revenue?
select p.product_name,sum(o.total_amount) as highest_revenue
from products p join orders o on p.product_id = o.product_id
group by p.product_name order by highest_revenue desc limit 1;

-- ------------------------------------------------------------------------------------------------------------------

-- 10. Which cities have placed more than 500 orders?
select city,count(*) as total_orders from orders
group by city having total_orders > 500 order by total_orders desc ;

-- ------------------------------------------------------------------------------------------------------------------

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

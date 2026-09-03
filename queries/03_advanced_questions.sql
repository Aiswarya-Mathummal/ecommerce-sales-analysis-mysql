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

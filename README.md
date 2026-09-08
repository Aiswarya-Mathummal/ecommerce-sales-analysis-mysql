## E-commerce Sales Analysis using MySQL

E-commerce sales analysis project using MySQL to explore customer, order, product, and seller data.

## Project Overview

This project analyzes e-commerce sales data using MySQL. The dataset was obtained from Kaggle and structured into four relational tables — customers, orders, products, and sellers — before performing SQL analysis.

The project includes beginner, intermediate, and advanced SQL queries to answer business-related questions about customers, orders, products, and sellers.

## Dataset

Source: Kaggle
Orders: 10,000
Unique Customers: 4,327
Tables: 4

The dataset was cleaned and prepared before importing it into MySQL.

## Database Schema

The project contains four relational tables:

customers – customer details and signup information
orders – order and transaction details
products – product details, categories, prices, and sellers
sellers – seller details

## EER Diagram

(screenshots/EER.jpg)

## What I Did

* Prepared and cleaned the dataset before importing it into MySQL.
* Structured the data into four relational tables.
* Removed duplicate customer records during data preparation.
* Defined appropriate data types and primary/foreign key constraints.
* Converted date columns into the appropriate `date` data type.
* Wrote SQL queries to answer business-related questions.
* Used aggregations, JOINs, subqueries, CTEs, window functions, views, and stored procedures.
* Ranked customers and sellers using the `dense_rank()` window function.

## Key Business Questions

### 1. Which product category generated the highest revenue?
select p.category,
       sum(o.total_amount) as highest_revenue
from orders o
join products p
on o.product_id = p.product_id
group by p.category
order by highest_revenue desc
limit 1;

## 2. Which customers have spent more than ₹50,000 in total?

select c.customer_id,
       c.first_name,
       c.last_name,
       sum(o.total_amount) as total_spend
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name
having total_spend > 50000
order by total_spend desc;

## 3. Who are the top 3 customers based on total spending?

select customer_id,
       total_spending
from (
    select customer_id,
           sum(total_amount) as total_spending,
           dense_rank() over(
               order by sum(total_amount) desc
           ) as rnk
    from orders
    group by customer_id
) as t
where rnk <= 3;

## 4. What is the ranking of sellers based on total orders received?

select seller_id,
       seller_name,
       total_orders,
       dense_rank() over(
           order by total_orders desc
       ) as seller_rank
from (
    select s.seller_id,
           s.seller_name,
           count(o.order_id) as total_orders
    from sellers s
    join products p
    on s.seller_id = p.seller_id
    join orders o
    on p.product_id = o.product_id
    group by s.seller_id, s.seller_name
) as t;

### 5. Which products generated more revenue than the average product revenue?

with product_revenue as (
    select p.product_id,
           p.product_name,
           sum(o.total_amount) as total_revenue
    from products p
    join orders o
    on p.product_id = o.product_id
    group by p.product_id, p.product_name
)
select *
from product_revenue
where total_revenue > (
    select avg(total_revenue)
    from product_revenue
);

## SQL Concepts Practiced

### Beginner

* SELECT
* WHERE
* LIKE
* IN
* BETWEEN
* ORDER BY
* LIMIT

### Intermediate

* JOINs
* GROUP BY
* HAVING
* Aggregate functions
* SUM()
* AVG()
* COUNT()
* MIN()
* MAX()

### Advanced

* Subqueries
* CTEs
* Window functions
* DENSE_RANK()
* Views
* Stored procedures

## What I Learned

This project helped me strengthen my SQL skills by solving business-related questions using e-commerce data. I practiced working with relational tables and using JOINs to combine customer, order, product, and seller information.

I also gained practical experience with subqueries, CTEs, window functions, views, and stored procedures for more advanced data analysis.

## Project Structure

ecommerce-sales-analysis-mysql/
│
├── README.md
│
├── schema/
│   └── create_tables.sql
│
├── data/
│   └── dataset_source.txt
│
├── queries/
│   └── 01_beginner_questions.sql
|   └── 02_intermediate_questions.sql
|   └── 03_advanced_questions.sql
│
└── screenshots/
    ├── db_cst.jpg
    ├── ord_prd_slr.jpg
    ├── eer.jpg
    ├── beg1.jpg
    ├── int1.jpg
    └── adv1.jpg 
    └── . 
    └── . 
    └── . 

## Tools Used

* MySQL
* MySQL Workbench
* SQL

## Project Status

Completed as part of my SQL and Data Analytics learning journey.



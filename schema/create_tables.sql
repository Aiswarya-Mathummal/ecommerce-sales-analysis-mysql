-- ------------------------------------------------------------------------------------------------------------------
create database sales_db;
use sales_db;

-- ------------------------------------------------------------------------------------------------------------------
CREATE TABLE `customers` (
   `customer_id` varchar(20) NOT NULL,
   `first_name` varchar(30) DEFAULT NULL,
   `last_name` varchar(30) DEFAULT NULL,
   `signup_date` date DEFAULT NULL,
   `city` varchar(20) DEFAULT NULL,
   PRIMARY KEY (`customer_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- ------------------------------------------------------------------------------------------------------------------

update customers set signup_date = str_to_date(signup_date,"%d-%m-%Y");
alter table customers modify signup_date date;

ALTER TABLE customers MODIFY customer_id VARCHAR(20) NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------

CREATE TABLE `orders` (
   `order_id` varchar(20) NOT NULL,
   `customer_id` varchar(20) NOT NULL,
   `order_date` date DEFAULT NULL,
   `city` varchar(30) DEFAULT NULL,
   `product_id` varchar(20) NOT NULL,
   `quantity` int DEFAULT NULL,
   `unit_price` int DEFAULT NULL,
   `total_amount` int DEFAULT NULL,
   `order_status` text,
   `payment_method` text,
   PRIMARY KEY (`order_id`),
   KEY `customer_id_idx` (`customer_id`),
   KEY `product_id_idx` (`product_id`),
   CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
   CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
-- ------------------------------------------------------------------------------------------------------------------

update orders set order_date = str_to_date(order_date,"%d-%m-%Y");
alter table orders modify order_date date;

ALTER TABLE orders MODIFY customer_id VARCHAR(20),MODIFY order_id VARCHAR(20) NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------
CREATE TABLE `products` (
   `product_id` varchar(20) NOT NULL,
   `category` text,
   `product_name` text,
   `unit_price` int DEFAULT NULL,
   `seller_id` varchar(20) NOT NULL,
   PRIMARY KEY (`product_id`),
   KEY `seller_id_idx` (`seller_id`),
   CONSTRAINT `seller_id` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`seller_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- ------------------------------------------------------------------------------------------------------------------
    
 ALTER TABLE products MODIFY product_id VARCHAR(20) NOT NULL,MODIFY seller_id VARCHAR(20) NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------

CREATE TABLE `sellers` (
   `seller_id` varchar(20) NOT NULL,
   `seller_name` text,
   `city` text,
   PRIMARY KEY (`seller_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    
-- ------------------------------------------------------------------------------------------------------------------
    
ALTER TABLE sellers MODIFY seller_id VARCHAR(20) NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------


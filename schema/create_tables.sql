-- ------------------------------------------------------------------------------------------------------------------
create database ecommerce_db;
use ecommerce_db;

-- ------------------------------------------------------------------------------------------------------------------

CREATE TABLE `customers` (
    `customer_id` VARCHAR(20) NOT NULL,
    `first_name` TEXT,
    `last_name` TEXT,
    `gender` TEXT,
    `age_group` TEXT,
    `signup_date` DATE DEFAULT NULL,
    `country` TEXT,
    PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ------------------------------------------------------------------------------------------------------------------

update customers set signup_date = str_to_date(signup_date,"%d-%m-%Y");
alter table customers modify signup_date date;

ALTER TABLE customers MODIFY customer_id VARCHAR(20) NOT NULL;

-- ------------------------------------------------------------------------------------------------------------------

CREATE TABLE `orders` (
    `order_id` VARCHAR(20) NOT NULL,
    `customer_id` VARCHAR(20) DEFAULT NULL,
    `order_date` DATE DEFAULT NULL,
    `country` TEXT,
    `category` TEXT,
    `product` TEXT,
    `quantity` INT DEFAULT NULL,
    `unit_price` INT DEFAULT NULL,
    `total_amount` INT DEFAULT NULL,
    `order_status` TEXT,
    `payment_method` TEXT,
    `seller_id` VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (`order_id`),
    KEY `customer_id_idx` (`customer_id`),
    CONSTRAINT `customer_id`
        FOREIGN KEY (`customer_id`)
        REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ------------------------------------------------------------------------------------------------------------------

update orders set order_date = str_to_date(order_date,"%d-%m-%Y");
alter table orders modify order_date date;

ALTER TABLE orders MODIFY customer_id VARCHAR(20),MODIFY order_id VARCHAR(20) NOT NULL;




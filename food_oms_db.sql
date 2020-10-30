SHOW DATABASES;
CREATE DATABASE food_oms_db;
USE food_oms_db;
SHOW TABLES;

CREATE TABLE customer (customer_id int NOT NULL AUTO_INCREMENT,
name varchar(60) DEFAULT NULL,
phone varchar(60) DEFAULT NULL, 
UNIQUE (phone),
PRIMARY KEY (customer_id));


CREATE TABLE orders (order_id int NOT NULL AUTO_INCREMENT,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
total int DEFAULT 0,
customer_id int NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
PRIMARY KEY (order_id));


CREATE TABLE order_details (order_id int NOT NULL,
item_id int NOT NULL,
total_item int DEFAULT 0,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (item_id) REFERENCES item(item_id));


CREATE TABLE item (item_id int NOT NULL AUTO_INCREMENT,
name varchar(60) DEFAULT NULL,
price int DEFAULT 0,
PRIMARY KEY (item_id));

CREATE TABLE categories (category_id int NOT NULL AUTO_INCREMENT,
name varchar(60) DEFAULT NULL,
PRIMARY KEY(category_id));

CREATE TABLE item_category (category_id int NOT NULL,
item_id int NOT NULL,
FOREIGN KEY (category_id) REFERENCES categories(category_id),
FOREIGN KEY (item_id) REFERENCES item(item_id));

INSERT INTO customer(customer_id,name,phone) VALUES
(1,'Budiawan', '+6212345678'),
(2,'Mary Jones', '+6287654321'),
(3,'Budiawan','+6289753124'),
(4,'Cania','+6215346782'),
(5,'Handy', '+6213657891');



INSERT INTO item(item_id,name,price) VALUES
(1, 'Nasi Goreng Gila', 25000),
(2,'Spaghetti', 35000),
(3,'Green Tea Latte',30000),
(4,'Orange Juice',15000),
(5,'Red Velvet Tart', 40000);


INSERT INTO categories(category_id, name) VALUES
(1, 'Main Dish'),
(2, 'Beverage'),
(3, 'Dessert');


INSERT INTO item_category (category_id, item_id) VALUES
(1,1),
(1,2),
(2,3),
(2,4),
(3,5);

INSERT INTO orders (order_id, customer_id) VALUES (1, (SELECT customer_id FROM customer where customer_id = 1)),
(2, (SELECT customer_id FROM customer where customer_id = 2)),
(3, (SELECT customer_id FROM customer where customer_id = 3)),
(4, (SELECT customer_id FROM customer where customer_id = 4)),
(5, (SELECT customer_id FROM customer where customer_id = 5));


INSERT INTO order_details(order_id, item_id, total_item) values
((SELECT order_id FROM orders where order_id = 1), (SELECT item_id FROM item where item_id = 1), 1),
((SELECT order_id FROM orders where order_id = 1), (SELECT item_id FROM item where item_id = 3), 2),
((SELECT order_id FROM orders where order_id = 2), (SELECT item_id FROM item where item_id = 2), 3),
((SELECT order_id FROM orders where order_id = 2), (SELECT item_id FROM item where item_id = 4), 4),
((SELECT order_id FROM orders where order_id = 3), (SELECT item_id FROM item where item_id = 3), 5),
((SELECT order_id FROM orders where order_id = 4), (SELECT item_id FROM item where item_id = 1), 2),
((SELECT order_id FROM orders where order_id = 4), (SELECT item_id FROM item where item_id = 2), 3),
((SELECT order_id FROM orders where order_id = 5), (SELECT item_id FROM item where item_id = 3), 1),
((SELECT order_id FROM orders where order_id = 5), (SELECT item_id FROM item where item_id = 5), 1);

SELECT o.order_id, o.order_date, c.name AS customer_name, c.phone AS customer_phone, SUM(i.price * od.total_item) AS total, GROUP_CONCAT(i.name) AS item_bought 
FROM orders o 
JOIN customer c on o.customer_id = c.customer_id
JOIN order_details od on od.order_id = o.order_id
JOIN item i on od.item_id = i.item_id
GROUP BY o.order_id;

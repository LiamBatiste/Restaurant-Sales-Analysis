CREATE DATABASE fast_food_sales;

USE fast_food_sales;

CREATE TABLE IF NOT EXISTS `ingredients` (
  `id` INT UNIQUE PRIMARY KEY,
  `ingredient_name` VARCHAR(255) UNIQUE,
  `ingredient_short_desc` VARCHAR(255) UNIQUE,
  `portion_uom_type_id` INT
);

CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` INT UNIQUE PRIMARY KEY,
  `menu_item_desc` VARCHAR(255),
  `PLU` VARCHAR(12),
  `recipe_id` INT
);

CREATE TABLE IF NOT EXISTS `purchased_items` (
  `md5key_purchased_item` VARCHAR(255) UNIQUE PRIMARY KEY,
  `md5key_order_sale` VARCHAR(255) UNIQUE,
  `category_desc` VARCHAR(255),
  `department_desc` VARCHAR(255),
  `description` VARCHAR(255),
  `store_id` INT,
  `tax_inclusive_amount` DECIMAL(4,1),
  `tax_amount` DECIMAL(5,4),
  `adjusted_price` DECIMAL(4,2),
  `discount_amount` DECIMAL(4,2),
  `price` DECIMAL(4,2),
  `quantity` INT,
  `PLU` VARCHAR(12),
  `menu_item_id` INT,
  `date` DATE
);

CREATE TABLE IF NOT EXISTS `portions_uom_types` (
  `id` INT UNIQUE PRIMARY KEY,
  `description` VARCHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS `pos_order_sale` (
  `md5key_order_sale` VARCHAR(32) UNIQUE PRIMARY KEY,
  `change_recieved` DECIMAL(5,2),
  `order_number` INT,
  `tax_inclusive_amount` DECIMAL(4,1),
  `tax_amount` DECIMAL(5,4),
  `meal_location` TINYINT(1),
  `transaction_id` INT,
  `store_id` INT,
  `date` DATE
);

CREATE TABLE IF NOT EXISTS `recipe_ingredient_assignment` (
  `recipe_id` INT,
  `ingredient_id` INT,
  `quantity` INT
);

CREATE TABLE IF NOT EXISTS `recipe_sub_recipe_assignment` (
  `recipe_id` INT,
  `sub_recipe_id` INT,
  `factor` INT
);

CREATE TABLE IF NOT EXISTS `recipes` (
  `id` INT UNIQUE PRIMARY KEY,
  `description` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `store_restaurant` (
  `id` INT UNIQUE PRIMARY KEY,
  `address` VARCHAR(255),
  `region` VARCHAR(255),
  `state` VARCHAR(255),
  `city` VARCHAR(255),
  `zip_code` INT,
  `type` VARCHAR(255),
  `loyalty_programme` CHAR(1)
);

CREATE TABLE IF NOT EXISTS `sub_recipe_ingr_assignments` (
  `sub_recipe_id` INT,
  `ingredient_id` INT,
  `quantity` INT
);

CREATE TABLE IF NOT EXISTS `sub_recipes` (
  `id` INT UNIQUE PRIMARY KEY,
  `sub_recipe_name` VARCHAR(255) UNIQUE,
  `description` VARCHAR(255) UNIQUE
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ingredients.csv'
INTO TABLE ingredients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ingredient_name, ingredient_short_desc, id, portion_uom_type_id);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/menu_items.csv'
INTO TABLE menu_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(menu_item_desc, PLU, id, recipe_id);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pos_ordersale.csv'
INTO TABLE pos_order_sale
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(md5key_order_sale, 
change_recieved, 
order_number, 
tax_inclusive_amount, 
tax_amount, 
meal_location, 
transaction_id, 
store_id,
date);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/menuitem.csv'
INTO TABLE purchased_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(md5key_purchased_item, 
md5key_order_sale, 
category_desc, 
department_desc, 
description, 
store_id, 
tax_inclusive_amount, 
tax_amount, 
adjusted_price, 
discount_amount,
price, 
quantity,
PLU, 
menu_item_id, 
date);

-- ALTER TABLE `ingredients` ADD FOREIGN KEY (`portion_uom_type_id`) REFERENCES `portions_uom_types` (`id`);

-- ALTER TABLE `menu_items` ADD FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`);

-- ALTER TABLE `purchased_items` ADD FOREIGN KEY (`md5key_order_sale`) REFERENCES `pos_order_sale` (`md5key_order_sale`);

-- ALTER TABLE `purchased_items` ADD FOREIGN KEY (`store_id`) REFERENCES `store_restaurant` (`id`);

-- ALTER TABLE `purchased_items` ADD FOREIGN KEY (`PLU`) REFERENCES `menu_items` (`PLU`);

-- ALTER TABLE `purchased_items` ADD FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`);

-- ALTER TABLE `pos_order_sale` ADD FOREIGN KEY (`store_id`) REFERENCES `store_restaurant` (`id`);

-- ALTER TABLE `recipe_ingredient_assignment` ADD FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`);

-- ALTER TABLE `recipe_ingredient_assignment` ADD FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`);

-- ALTER TABLE `recipe_sub_recipe_assignment` ADD FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`);

-- ALTER TABLE `recipe_sub_recipe_assignment` ADD FOREIGN KEY (`sub_recipe_id`) REFERENCES `sub_recipes` (`id`);

-- ALTER TABLE `sub_recipe_ingr_assignments` ADD FOREIGN KEY (`sub_recipe_id`) REFERENCES `sub_recipes` (`id`);

-- ALTER TABLE `sub_recipe_ingr_assignments` ADD FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`);
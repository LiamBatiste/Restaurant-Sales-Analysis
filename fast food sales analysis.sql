-- created view for wide usage on problems related to the restaurant sales and for later Power BI dashboard for benchmarking
CREATE VIEW restaurant_sales AS
SELECT
	pos_order_sale.md5key_order_sale AS MD5_order_id,
    pos_order_sale.change_recieved,
    pos_order_sale.tax_amount AS pos_tax_amount,
    pos_order_sale.meal_location,
    pos_order_sale.date,
    purchased_items.description,
    purchased_items.category_desc,
    purchased_items.tax_amount AS purchased_tax_amount,
    purchased_items.adjusted_price,
    purchased_items.discount_amount,
    purchased_items.price,
    purchased_items.quantity,
    store_restaurant.id AS store_id,
    store_restaurant.state,
    store_restaurant.city,
    store_restaurant.type,
    store_restaurant.loyalty_programme,
    menu_items.id AS menu_item_id
FROM pos_order_sale
JOIN purchased_items ON purchased_items.md5key_order_sale = pos_order_sale.md5key_order_sale
JOIN store_restaurant ON store_restaurant.id = pos_order_sale.store_id
JOIN menu_items ON menu_items.id = purchased_items.menu_item_id;

SELECT * FROM restaurant_sales
ORDER BY date DESC;

-- Problem Statement 1: Analyzing Sales Performance
-- Objective: Determine which items perform best across all/each store 
-- Task: Write a query to determine the top 5 menu items based on total sales (in terms of quantity sold and revenue generated) across all stores.
-- Task: Write a query to determine the top 5 menu items based on total sales (in terms of quantity sold and revenue generated) across each store.

WITH rest_quant_rev AS (
	SELECT 
		store_id,
		menu_item_id,
		description,
		SUM(adjusted_price) AS total_revenue
	FROM
		restaurant_sales
	GROUP BY store_id, menu_item_id, description
	ORDER BY total_revenue DESC
)

SELECT * FROM rest_quant_rev 
LIMIT 5;
-- top 5 items sold across all stores by total_revenue (Turkey FtLong, Chicken Teriyaki FtLong, Tuna FtLong, 21oz Fountain Drink, Rst Chicken FtLong)
-- also appears as though store_id 4904 and 12631 are generating the highest revenue (will confirm later)


WITH rest_quant_rev AS (
	SELECT 
		store_id,
		menu_item_id,
		description,
		SUM(quantity) AS total_quantity_sold,
		SUM(adjusted_price) AS total_revenue
	FROM
		restaurant_sales
	GROUP BY store_id, menu_item_id, description, quantity
	ORDER BY total_revenue DESC
)

SELECT * FROM rest_quant_rev
ORDER BY total_quantity_sold DESC
LIMIT 5;
-- top 5 items sold across all stores by total_revenue (chips across 3 different stores, 21oz Fountain Drink across 2 different stores)
-- chips and fountain water may perform well across different store due to price?

WITH rest_quant_rank AS (
	SELECT 
		store_id,
		menu_item_id,
		description AS item,
        price,
		SUM(quantity) AS total_quantity_sold,
        ROW_NUMBER() OVER (PARTITION BY description ORDER BY SUM(quantity) DESC) AS ranks
	FROM
		restaurant_sales
	GROUP BY store_id, menu_item_id, description, quantity, price
)

SELECT * FROM rest_quant_rank
WHERE ranks = 1
ORDER BY total_quantity_sold DESC
LIMIT 5; 
-- 5 highest distinct items sold across all stores (Chips, 21oz Fountain Drink, Cookie, Bottled Carbonated Drink, Turkey 6 inch)     
-- chips and 21oz fountain drink far outsell other items but are in the top 2/3 position for price which may partly explain this outcome

WITH rest_quant_rev AS (
	SELECT 		
		store_id,
		menu_item_id,
		description AS item,
		SUM(quantity) AS total_quantity_sold,
		SUM(adjusted_price) AS total_revenue,
		ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY SUM(quantity) DESC) AS quant_rank,
        ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY SUM(adjusted_price) DESC) AS revenue_rank
	FROM 
		restaurant_sales
    GROUP BY store_id, menu_item_id, description
) 

SELECT 
	store_id,
    menu_item_id,
    item, 
    total_quantity_sold, 
    total_revenue,
    IF(quant_rank = 1, quant_rank, '') AS quantity_rank,
	IF(revenue_rank = 1, revenue_rank, '') AS revenue_rank
FROM rest_quant_rev
WHERE quant_rank = 1 or revenue_rank = 1
ORDER BY revenue_rank, store_id;
-- highest quantity sold for each store (chips for all stores)
-- highest revenue for each store (Turkey FtLong across 2 stores, Chicken Teriyaki FtLong, 21oz Fountain Drink)     

-- Problem Statement 2: Ingredient Usage Analysis
-- Objective: Determine which ingredients are most commonly used across all recipes.
-- Task: Write a query to find out which ingredients are used the most (by quantity) across all recipes.

SELECT 
    ingredients.id, 
    ingredients.ingredient_name, 
    portion_uom_types.description AS unit_of_measure,
    SUM(COALESCE(recipe_ingredient_assignment.quantity, sub_recipe_ingr_assignments.quantity)) AS total_quantity_used
FROM 
    recipes
JOIN 
    menu_items ON recipes.id = menu_items.recipe_id
LEFT JOIN 
    recipe_ingredient_assignment ON recipe_ingredient_assignment.recipe_id = recipes.id
LEFT JOIN 
    recipe_sub_recipe_assignment ON recipe_sub_recipe_assignment.recipe_id = recipes.id
LEFT JOIN 
    sub_recipes ON sub_recipes.id = recipe_sub_recipe_assignment.sub_recipe_id
LEFT JOIN 
    sub_recipe_ingr_assignments ON sub_recipe_ingr_assignments.sub_recipe_id = sub_recipes.id
LEFT JOIN 
    ingredients ON ingredients.id = COALESCE(recipe_ingredient_assignment.ingredient_id, sub_recipe_ingr_assignments.ingredient_id)
LEFT JOIN 
    portion_uom_types ON portion_uom_types.id = ingredients.portion_uom_type_id
GROUP BY 
    ingredients.id, 
    ingredients.ingredient_name, 
    portion_uom_types.description
ORDER BY 
    total_quantity_used DESC
LIMIT 5;
-- ingredient total quantity required based on sales across all menu items and stores is as follows:
-- Chicken Strips - (441218 Grams), Turkey - (350805 Grams), Ham - (266280 Grams), Marinara - (176476 Grams), Roast Beef - (165790 Grams)  
-- it is important for the restaurants to ensure they have enough stock of these ingredients and also to try and get the best deal on these items from wholesalers     
-- potentially through a procurement contract as the restaurant knows that a certain item or ingredient is in high demand, 
-- they may enter into a bulk purchasing agreement or volume contract with a wholesaler or supplier.    

-- Problem Statement 3: Sales Trends Over Time
-- Objective: Analyze sales trends to identify seasonal patterns or specific days of the week where sales peak.
-- Task: Write a query to calculate the total revenue generated and the total quantity of items sold per day for the past year.

SELECT * FROM store_restaurant;

SELECT 
    SUM(adjusted_price) AS total_revenue,
    YEAR(date) AS year
FROM
    restaurant_sales
WHERE YEAR(date) BETWEEN '2000' AND '2024'
GROUP BY year
ORDER BY total_revenue DESC;
-- I cannot gather the day of week as it appears all item sales are collated on the 15th of each month and only 3 months of the year (March, April and May)
-- instead I will look at sales revenue and quantity by year (mid 2010s appear the most successful years)

SELECT 
    SUM(quantity) AS total_quantity,
    YEAR(date) AS year
FROM
    restaurant_sales
WHERE YEAR(date) BETWEEN '2000' AND '2024'
GROUP BY year
ORDER BY total_quantity DESC;
-- as expected quantity inline with revenue for itmes sold by year

-- Problem Statement 3: Store Performance Comparison
-- Objective: Compare the performance of stores based on average order value.
-- Task: Write a query to calculate the average order value (total revenue divided by the number of transactions) for each store. 
-- Identify the top 3 stores with the highest average order value and the bottom 3 stores with the lowest average order value.
 
WITH total_store_rev AS (SELECT 
	SUM(adjusted_price) AS total_revenue,
    COUNT(*) AS total_sales,
    store_id,
    city
FROM restaurant_sales
GROUP BY store_id)

SELECT 
store_id, 
city,
CONCAT('£', ROUND((total_revenue/total_sales), 2)) AS avg_order_value
FROM total_store_rev
ORDER BY avg_order_value DESC;
-- order of average_order_value by store id is as follows (high to low):
-- 20974: £3.66, 4904: £3.52, 46673: £3.39, 12631: £3.32

-- Problem Statement 4: Customer Purchase Behavior
-- Objective: Understand customer purchasing patterns.
-- Task: Write a query to determine the most common combination of menu items purchased together in a single transaction. 
-- Identify the top 3 combinations across all stores.

WITH item_combos AS (
	SELECT 
		GROUP_CONCAT(description) AS item_combo
	FROM restaurant_sales
	GROUP BY md5_order_id
),
combo_counts AS (
    SELECT 
        item_combo,
        COUNT(*) AS combo_count
    FROM item_combos
    GROUP BY item_combo
),
ranked_combos AS (
    SELECT 
        item_combo,
        combo_count,
        RANK() OVER (ORDER BY combo_count DESC) AS combo_rank
    FROM combo_counts
)
SELECT 
	combo_rank,
    item_combo,
    combo_count
FROM ranked_combos
WHERE item_combo LIKE '%,%'
LIMIT 15;
-- because the items could be the same but just arranged in a different order I limited 15 to filter through and find the 3 most purchased unqiue combination of items
-- I am aware there are 10 different combinations of the same 3 items, but to save time I am giving a rough estimate of the top 3 combinations across stores
-- likely most common combinations are:
-- 1st - turkey 6 inch, chips and 21oz fountain drink
-- 2nd - tuna 6 inch, chips and 21oz fountain drink
-- 3rd - chicken teriyaki 6 inch, chips and 21oz fountain drink


-- Problem Statement 5: Discount across items
-- Objective: Analyse the items which have the most discount applied to them over the last year
-- Task: Determine the top 5 items that accumulated the most dicsount over the past year as a total

SELECT * FROM restaurant_sales;

SELECT 
    menu_item_id,
    description,
    SUM(discount_amount) AS total_discount,
    COUNT(*) AS total_sales
FROM
    restaurant_sales
WHERE
    date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY menu_item_id , description
ORDER BY total_discount DESC , total_sales DESC
LIMIT 5;
-- highest total discount for year 2024 is as follows:
-- 1st: Turkey 6 inch, Tuna 6 inch, 21oz Fountain Drink, Steak & Chse FtLong, Turkey FtLong   
-- it may also be useful to compare average discount for menu_item_id by both sale count and total_quantity of the item

WITH item_disc_sales AS (SELECT 
    menu_item_id,
    description,
    price,
    SUM(discount_amount) AS total_discount,
    COUNT(*) AS total_sales,
    SUM(quantity) AS total_quantity
FROM
    restaurant_sales
WHERE
    date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY menu_item_id , description, price
)

SELECT 
	menu_item_id,
    description,
    price,
	CASE WHEN total_sales > 0 THEN total_discount / total_sales ELSE 0 END AS avg_disc_sale,
    CASE WHEN total_quantity > 0 THEN total_discount / total_quantity ELSE 0 END AS avg_disc_quant
FROM item_disc_sales
WHERE price != total_discount / total_sales AND total_sales > 10
ORDER BY avg_disc_sale DESC
LIMIT 5;
-- (note I have added the criteria of ensuring items were not completely free and total_sales > 5):
-- this is to ensure that the avgerages are not misleading say a only 2 sales of the item have been recorded at 50% discount
-- instead I want to look at discount of items that are purchased fairly frequently this year, to provide more value
-- lastly I will use this same query but also look at discount compared to the price of the product as a percentage

WITH item_disc_sales AS (SELECT 
    menu_item_id,
    description,
    price,
    SUM(discount_amount) AS total_discount,
    COUNT(*) AS total_sales,
    SUM(quantity) AS total_quantity
FROM
    restaurant_sales
WHERE
    date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY menu_item_id , description, price
),
average_sale_quant AS (SELECT 
	menu_item_id,
    description,
    price,
	CASE WHEN total_sales > 0 THEN total_discount / total_sales ELSE 0 END AS avg_disc_sale,
    CASE WHEN total_quantity > 0 THEN total_discount / total_quantity ELSE 0 END AS avg_disc_quant
FROM item_disc_sales
WHERE price != total_discount / total_sales AND total_sales > 10
ORDER BY avg_disc_sale DESC
)

SELECT 
	menu_item_id,
    description,
    price,
    avg_disc_sale,
    avg_disc_quant,
    (avg_disc_sale/price) * 100 AS avg_disc_sale_price,
    (avg_disc_quant/price) * 100 AS avg_disc_quant_price
FROM average_sale_quant
ORDER BY avg_disc_sale_price DESC;
-- top 5 items by average discount (percentage) based off sales volume against item price this year are as follows:
-- Turkey 6 inch (~ 26%), Milk (~ 22%), Cookie (~ 22%), Steak & Chse FtLong (~ 22%), Turkey 6 inch (~ 16%)
-- it is important to consider that I have used (average disc by sales)/price 
-- this is more appropriate to analyze customer behavior in terms of how often they are availing of discounts on a specific item   
-- whereas I could have also looked at (average disc by quantity)/price 
-- this would be to assess the impact of discounts on the volume of products sold


-- Problem Statement 6: Identifying Low-Performing Menu Items
-- Objective: Identify menu items that might need to be discontinued or re-evaluated.
-- Task: Write a query to identify the bottom 5 menu items based on total revenue and quantity sold across all stores over the last 10 years

with rev_bot5_by_store AS (SELECT 
	store_id,
	menu_item_id, 
	description, 
    SUM(adjusted_price) AS total_revenue,
    COUNT(*) AS sales,
    ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY SUM(adjusted_price) ASC) AS total_rev_rank
FROM restaurant_sales
WHERE date BETWEEN '2014-08-14' AND '2024-08-14'
GROUP BY menu_item_id, store_id, description)

SELECT 
	store_id,
	menu_item_id, 
	description, 
    total_revenue,
    sales,
    total_rev_rank
FROM rev_bot5_by_store
WHERE total_rev_rank <=5
ORDER BY store_id, total_rev_rank;
-- low performing items with respect to revenue:
-- across stores the reoccuring item across stores was the steak and cheese flatbread. 
-- there does also appear to be a range of different meat portions (ham, turkey, salami, pepperoni)

with quant_bot5_by_store AS (SELECT 
	store_id,
	menu_item_id, 
	description, 
    price,
    SUM(quantity) AS total_quantity,
    COUNT(*) AS sales,
    ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY SUM(quantity) ASC, price ASC) AS total_quant_rank
FROM restaurant_sales
GROUP BY menu_item_id, store_id, description, price)

SELECT 
	store_id,
	menu_item_id, 
	description, 
    price,
    total_quantity,
    sales,
    total_quant_rank
FROM quant_bot5_by_store
WHERE total_quantity = 1
ORDER BY store_id, price ASC;
-- given there are so many items that in the last 10 years have a total_quantity sold of 1 it seems of greater value to expand the search to all transations 
-- (from all years) and order by lowest price as you would expect there to be less items that would have a lower price and also have a low sales quantity.
-- for store id 4904, there is a high number of Extra 6 inch and extra foot long items with low sales quantity and price.
-- for store id 12631, there is pizzas and wraps might be an area of interest to implement a sale or dicount
-- for store id 20974, extra foot longs appear frequently at low price and a only 1 sale
-- for store id 46673, extra 6 inch is realtively cheap with many filler combinations so might be useful to either discountinue or bundle into furture deals


-- Problem Statement 7: Eat-in/takeaway schemes
-- Objective: Identifying the top performing restaurants where customers eat in at the restaurant/take away
-- Task: Write a query to identify the order of restaurants ranking them by percentage of oders where the customer eats in/takes away

WITH meal_loc_by_store AS (SELECT 
    store_id, 
    COUNT(*) AS total_sales_location,
    SUM(COUNT(*)) OVER(PARTITION BY store_id) AS total_store_sales,
    meal_location
FROM
    restaurant_sales
GROUP BY store_id, meal_location
)

SELECT 
	store_id, 
    total_sales_location,
    total_store_sales,
    (total_sales_location/total_store_sales) * 100 AS percent_overall_sales,
    meal_location
FROM 
	meal_loc_by_store;
-- store_id of 4904 has a 65/35 split for eat-in/take-away sales 
-- store id of 12631 has an almost unanimously eat-in sales
-- store id of 20974 has an almost unanimously eat-in sales 
-- store id of 46673 has a 73/27 split for eat-in/take-away sales
-- potential to try and increase sales and profit by targetting the majority splits through deals on foods associated more so with customer eat-in/take-aways
-- can also adapt items e.g. convenient containers for restaurants 12631 and 20974 to make take-away more convenient which could translate to more repeat customers
-- why do restaurants 12631 and 20974 have such low take-away sales?

WITH RankedSales AS (
    SELECT 
        store_id,
        description, 
        meal_location,
        SUM(quantity) AS total_quantity,
        ROW_NUMBER() OVER(PARTITION BY store_id, meal_location ORDER BY SUM(quantity) DESC) AS ranks
    FROM restaurant_sales
    GROUP BY store_id, description, meal_location
)
SELECT 
    store_id,
    description,
    meal_location,
    total_quantity
FROM RankedSales
WHERE ranks <= 5
ORDER BY store_id, description;
-- summary: store 4904 and 46673 has a more distributed split of takeaway/eat-in amongst convenience/'on-the-go' products such as bottled water, chips and cookies
-- stores 12631 and 20974 show on a tiny majority of even the most popular food choices are eaten as takeaway/to-go
-- could deals be used to incentivise eating food on the go (discounnts/promotions, bundle deals or more accesible ordering associated with online
-- e.g. curbside pickup or the ability to order ahead of time using a molbile order app or even gamification for to-go orders
-- fruther both better performing stores for eat-in/to-go split are in california which could indicate cultural customer behaviour or restaurant designs/operating logistics

# Restaurant-Sales-Analysis
![image]([path/to/your/image.png](https://github.com/user-attachments/assets/9a0aa1c4-2a55-41da-9937-9702f9ed0ae3))

### Introduction
Welcome to my Restaurant Sales Analysis repository! This project was developed to address critical challenges in the fast food industry. The primary goal is to internally benchmark key metrics that can help the business improve overall efficiency and maximise profits.

### **Problem Statement:**
To enhance the internal competitive positioning and operational efficiency of the restaurant chain, it is crucial to identify key performance drivers and areas for improvement across the menu offerings, store locations, and customer behaviours. Through analysis of sales trends, ingredient usage, customer purchase patterns, and store-specific performance, I aim to establish benchmarks that will inform strategic decisions, optimise resource allocation, and improve profitability. By comparing these internal metrics, I seek to uncover actionable insights that will lead to more effective pricing strategies, better inventory management, and enhanced customer satisfaction across all locations 

### Dataset
The dataset used for this analysis was taken from [Kaggle - Fast-Food Restaurant Chain](https://www.kaggle.com/datasets/rishitsaraf/fast-food-restaurant-chain/data?select=recipe_sub_recipe_assignments.csv). The dataset was provided by one of the largest fast-food restaurant chains in the US. It includes (1) transaction information such as menu items that were purchased and quantities of each item; (2) ingredient lists for individual menu items; (3) metadata on restaurants, including location, and store type. The data observation window is from early March, 2015 to 06/15/2015 and includes transactional data from 2 stores in Berkeley, CA and 2 stores in New York, NY.


# Python Data Cleaning and Peparation

To ensure accurate and meaningful analysis, the first step was to prepare the dataset using Python library Pandas and Numpy. This involved several key processes:

### Data Cleaning:

- Handling Missing Values: Removed or imputed missing data to ensure consistency, such as record with '#NAME?' values being dropped.

- Data Type Conversion: Converted data types such as date types to the correct format so they compatible with SQL DATE data type as part of a later schema. 

- Removing Duplicates: Identified and removed any duplicate records to maintain data integrity, such as columns that were similar in nature like the item description and name.

With respect to data normalisation, given that the data was taken from Kaggle, the data was already in a state which allowed for comparison across all metrics. 

### Database Intergation: 
A database schema was first developed using **https://dbdiagram.io/home** 
![image](https://github.com/user-attachments/assets/680b962c-eafe-4249-be95-488c46d3658a)
[Database Schema PDF](https://github.com/LiamBatiste/Restaurant-Sales-Analysis/blob/main/Fast%20Food%20Sales%20Schema.pdf)

This was important firstly as it would allow me to visualise the database when writing SQL queries that involved joins and naming conventions. Additionally, the cleaned and transformed data could then be loaded directly into the SQL database from the now cleaned CSV files to facilitate querying and further analysis.

The data was brought into SQL using the now cleaned and prepared CSV files (Seee Example code snippet).
![image](https://github.com/user-attachments/assets/8c85ab77-5936-4d22-a244-150df923ef44)


# SQL Querying - Restaurant Sales Internal Benchmarking:

### Insights through mySQL:

Once the data was populated into the mySQL schema and I had created the relevant Views within SQL to speed up my workflow by collating and connecting the relevant fields I would frequently be querying, I could begin to conduct my analysis. The key areas of interest and insights gained were as follows:

- [Overall Restaurant Sales Analysis](#overall-restaurant-sales-analysis)
- [Menu Item Analysis](#menu-item-analysis)
- [Discount Analysis](#discount-analysis)
- [Customer Behaviour Analysis](#customer-behaviour-analysis)

## Overall Restaurant Sales Analysis

**Average Sale Value by Restaurant**

![image](https://github.com/user-attachments/assets/c9ba6319-a1a4-4d2e-afa6-9e5aca7f46a1)

The order of average order value by store id is as follows; **(high to low) Store 20974: £3.66, Store 4904: £3.52, Store 46673: £3.39, Store 12631: £3.32**

The disparity in average sales value could be due to a number of could be due to a number of factors such as the selling price of items across stores or the affluenc where the restaurant is based. The implications of this finding can be used a internal benchmark to monitor the performance of restaurants against one another, which can be particularly useful for restaurants in a similar area as they highly comparable (due to similar target market) such as store id of 4904 and 46673 as they are both based in Berkley. 
<br></br>

**Store Total Sale Revenue Over Each Month**

![image](https://github.com/user-attachments/assets/2e855694-8846-42ae-bb16-6d9d2b406ef2)

General Observations show that the average sales are **highest during April and Lowest during June and store 12631 doing well across the months whereas store 46673 is not doing well across the different months**

This information can therefore be used to identify monthly or seasonal patterns where the earlier mention meal-deal promotions could be best suited to drive an increase in sales during months when revenue is generally lower and even more specifically at the store level. 
<br></br>

## Menu Item Analysis

**Sales performance by top 5 menu items for total sales revenue across all stores**
  
![image](https://github.com/user-attachments/assets/a0af1c85-038c-4a72-a0bc-f247c28d2387)

As shown above, the top 5 items sold across all stores by total revenue was;
**1st - Turkey Foot Long, 2nd - Chicken Teriyaki Foot Long, 3rd - Tuna Foot Long, 4th - 21oz Fountain Drink, 5th - Roast Chicken Foot Long**. 

This insight could potentially be leveraged by the company during promotions as they appeal to the largest sector with respect to sales and potentially drive more overall sales. Further, the best performing items are generally 'main meal' items, so could be used as part of a meal-deal promotion to incentives repeat customers. 
<br></br>

**Sales performance by top 5 menu items for total sales quantity across all stores**

![image](https://github.com/user-attachments/assets/b8d3680c-81ab-4f33-bcbb-ae7586ce2892)

The top 5 items sold across all stores by total quantity was; 
**chips across 3 different stores, 21oz Fountain Drink across 2 different stores**. 

This could well be due to these items being 'budget-friendly' items (as when compared the price of these items were well below the average of ~ $3.4 across stores), which may explain the high sales volume across stores. This finding could be coupled with the aforementioned insight through chips and water being part of a bundle deal to drive more sales and upsell the more expensive 'main meal' items through a snack, side and drink.
<br></br>

**Sales performance by top 5 menu items for total sales quantity and revenue across all stores**

![image](https://github.com/user-attachments/assets/91ea4952-889a-4d5b-80f9-24c589273107)

Results for quantity sold were as follows; 
**Chips were unanimously the top performer with respect to total sales quantity**

Results for sales revenue were as follows; 
**Turkey Foot Long across 2 stores, Chicken Teriyaki Foot Long and 21oz Fountain Drink**

Clearly chips are in high demand across all stores and so including this item as part of a bundle has the potential to maximise sales as part of a meal-deal promotion. 
<br></br>

**Bottom 5 Performing Menu Items Based on revenue by Restaurant**

![image](https://github.com/user-attachments/assets/9af07515-c20e-4efb-8dd0-083cd07083b9)

Through observartion **the Cheese Portion (menu item id: 914) appears in store 4904 with a total revenue of $0.30 and in store 46673 with a total revenue of $0.15.**

This might indicate that the item should be discontinued from said store or company-wide or apply a promotion and then monitor item performance. An exclusive loyalty card offer on select products which underperforming might be useful to boost sales of said items. 

Additonally,**the store id 20974 is selling a higher number of the same item at no charge.** 

It might be useful to check in with this store and query why these volume of free items is so much higher, or even ensure that staff a trained/retrained on discount and sales processes. 
<br></br>

**Top 5 ingredients used within purchased items recipes/sub-recipes across all stores**

![image](https://github.com/user-attachments/assets/40a987ee-0217-4170-a838-b60e3868c80a)

The top 5 ingredients were; **Chicken Strips - (441218 Grams), Turkey - (350805 Grams), Ham - (266280 Grams), Marinara - (176476 Grams), Roast Beef - (165790 Grams)**

This Insight can be leveraged through an estimation of the required stock for different time periods. In this case it has been processed using the whole data set (March to June), however a similar style of query could also be used seasonally or monthly to ensure that items that use certain ingredients that are in high demand are not out of stock, resulting in higher customer satisfaction. 
<br></br>

## Discount Analysis

**Top 5 Items with Highest Average Sales Discount**

![image](https://github.com/user-attachments/assets/a936673f-1fba-4f1e-b56d-3f87838a22f9)

It can be seen that the order of average discount for items was (high to low); **Steak & Cheese Flat Bread, Veggie Patty Flat Bread, Roast Chicken Flat Bread, Chicken Parmesan, 6 inch Buffalo Chicken Foot Long**

This may be due to deals that are associated with these specific items that could be as part of events, seasons or cross-branding. This data can be utilised to ensure that restaurants are not applying to much discount to items but also can give target items for monitoring, for example to trial if discounts increase overall sales quantity/revenue by a certain threshold, possibly through hypothesis testing. 
<br></br>

**Top 5 Items with Highest Average Percentage of Sales Discount Against Total Item Price**

![image](https://github.com/user-attachments/assets/b64b6972-3d03-4406-befb-c40700bab798)

The top 5 items by average discount (percentage) based off sales volume against item price this year are as follows; **Turkey 6 inch (~ 26%), Milk (~ 22%), Cookie (~ 22%), Steak & Cheese Foot Long (~ 22%), Turkey 6 inch (~ 16%)**

It is important to consider that I have used _(average discount for sales)/price_ this is more appropriate to analyse customer behaviour in terms of how often they are availing of discounts on a specific item. Whereas I could have also looked at (average disc by quantity)/price this would be used to assess the impact of discounts on the volume of products sold.
<br></br>

## Customer Behaviour Analysis

**Most Popular Item Combo Choices by Customers**

![image](https://github.com/user-attachments/assets/40b1ae0e-19e1-484c-b247-e7471585889b)

Because the item combination could be the same but just arranged in a different order I limited 15 to filter through and find the likely 3 most purchased combination of items. I am aware there are 10 different possible combinations of the same 3 items, but to save time I am giving a rough estimate of the top 3 combinations across stores, which may be so;
**1st - turkey 6 inch, chips and 21oz fountain drink
2nd - tuna 6 inch, chips and 21oz fountain drink
3rd - chicken teriyaki 6 inch, chips and 21oz fountain drink**

This could ultimately give further direction as to what meal-deal choices should/shouldn't be included to maximise revenue, as well as recommendations for first time customers to maximise the chances of repeat customers (as it is likely these items will give a good impression to the customers based of general demand). 
<br></br>

**Eat-in/Take-away Percentage Split for Each Restaurant**

![image](https://github.com/user-attachments/assets/84d1b95b-96a1-49e1-af9e-4af894f76c13)

**The store_id of 4904 has a ~ 65/35 split for eat-in/take-away sales. Both store idd 12631 and 20974 has an almost unanimously eat-in sales. Whereas, store id of 46673 has a 73/27 split for eat-in/take-away sales**

Therefore there is potential to try and increase sales and profit by targetting the majority splits through deals on foods associated more so with customer eat-in/take-aways. Further, there is also opportunity to adapt items, e.g. convenient containers for restaurants 12631 and 20974 to make take-away more convenient which could translate to more repeat customers that prefer take-away. Lastly, it also begs the question 'why do restaurants 12631 and 20974 have such low take-away sales'?
<br></br>

**Top 5 Menu Items for Eat-in/Take-away for Each Restaurant**

![image](https://github.com/user-attachments/assets/3507273c-0a8c-4b81-957d-10b25524304b)

Overall summary: **store 4904 and 46673 has a more distributed split of takeaway/eat-in amongst convenience/'on-the-go' products such as bottled water, chips and cookies. Conversely, stores 12631 and 20974 show only a tiny majority of even the most popular food choices are eaten as takeaway/to-go.**

Thus, could deals be used to incentivise eating food on the go (discounts/promotions, bundle deals or more accessible ordering associated with online e.g. curbside pickup or the ability to order ahead of time using a mobile order app or even gamification for to-go orders. Further, both better performing stores for eat-in/to-go split are in California which could indicate cultural customer behaviour or restaurant designs/operating logistics.
<br></br>

The next step of this internal benchmarking was to create a dashboard that would allow KPIs and the most important high level insights to tell a story at a glance. 
# Power BI Dashboard:

The Power BI dashboard was designed to visually represent the insights derived from the SQL analysis. The goal was to create a user-friendly, interactive tool that allows stakeholders to easily explore key metrics and trends across the restaurant chain, these include: 
- Overall Sales Performance and Trends
- Menu Item Analysis
- Discount and Pricing Insights
- Customer Loyalty Engagement

https://github.com/user-attachments/assets/fabffaf0-dd14-4817-85e1-e082cb5f8739

### Key Metrics

The dashboard can provide value through key metrics such as the **three KPIs provided (total sales, average order value and average adjusted price loss)**, which allows ley stakeholders such as restaurant managers, area managers, financial teams, marketing teams or even investors or stakeholders to monitor revenue, the impact of sales, promotions or seasonal/limited items. 

### Slicing and Filtering 

The ability to **slice specific time periods** means that performance can be measured at different levels by drilling down into the time series slicer. The ability to **filter by different levels for fast food restaurants** is also useful for comparing by State, City or individual restaurant, allowing restaurants to be further investigated if performance is exceptional so that it can be replicated across other stores. For example, if a specific restaurant trials a meal-deal promotion specific to loyalty members and it showed success, the promotion could be rolled out state wide. 

### Deep Dive Analysis
There is also possibility for a **deep dive analysis of restaurant by sales quantity**. In effect this means stakeholder can identify which items are top sellers and what this might imply about customer preferences. Secondly, the stacked bar chart (bottom middle visual) displays the **top 5 item by total adjusted price loss by restaurants**, this can provide value through identifying the items that have the highest adjusted price loss, explaining how this could indicate potential issues with pricing strategies or discounts (that may even be restaurant specific). The dashboard can be used to gain insight centered around **discount distribution by loyalty program participation** which will give an indication of loyalty programme success through conversion rate. 

### Scheduled Refresh
The dashboard was published to the web to enable the option for scheduled refresh, which is useful for automatically pulling in fresh data from source systems and updating the visuals accordingly. However, for this particular project, there isn't a need to enable scheduled refresh since the data does not require periodic updates. The dashboard is not pulling fresh data from external source systems (data ingestion), making scheduled refresh redundant in this scenario.

If the project were to involve real-time data updates, such as pulling data from a REST API, enabling scheduled refresh would be necessary. In that case, the feature would allow the dashboard to automatically ingest new data as it becomes available and update the visuals to reflect the latest information.

# Technical Challenges
The first technical challenged faced was the high volume of redundant data, in an ideal world it would best practice to remove all data that will not be used within the analysis for both computing and storage purposes. This would be especially important if big data was being ingested in real time to save money and resources to minimise the need to upwards and outwards. With this particular analysis the removal of descriptions and names of items would be a use case as the majority of item descritions were simply a plural of the given item and so removal of one of the two rows would be required. 

Although the data set is from Kaggle, it is still important to check the dataset is clean. This was done using the Python Pandas library and involved checking for; null values, duplicated records and formatting consistency across data types within the CSV file. I did make one oversight for which I had to later go back and amend. This involved converting the date data types to the required format to be compatible with mySQL. I notice this oversight once I had created my dashboard that my slicer a range of over 20 years. This was because I had formatted my date fields as 'dd/mm/yyyy', but instead it should have been 'yyyy/mm/dd'. This required mew to correct the date at source (.csv files) and then repopulating the SQL database tables for querying and visualisation in Power BI. in order to delete and re-populate the schema I also have to drop foreign key constraints to and then re-apply these rules once the data with correct date format was added. 

Understanding the recipe/sub-recipe relationships for each menu item to calculate ingredients was troublesome because I could not wrap my head around the way to calculate ingredients for sale based off what was ordered. This is why: 

![image](https://github.com/user-attachments/assets/28c2e3a7-cda4-495a-98ae-6e66068a6595)

With menu items there are 3 possible ways that the item is made up:
- The menu item contains only sub-recipes
- The menu item contains only recipes
- Or a combination of both.

Therefore to calculate the total quantity of ingredients used based on number of sales that includes a menu item (an ultimately it's sub-parts), a left join, along with coalesce function default null values to 0. This allowed for the total quantity to be accurately calculated. 

Lastly, the MySQL required a Connector/ODBC driver to bring data in from the MySQL server to Power BI. This way useful as it allowed views I had used within mySQL to also be used within Power BI for sales insights, along with a the correct schema. 

# Appendix
### Python snippets
**Python data cleaning example - removal of excel name error records:**

![image](https://github.com/user-attachments/assets/2321fded-926b-4e77-bd48-bd022fe2f190)

**Python data cleaning example - check duplicates, null values and data types:**

![image](https://github.com/user-attachments/assets/239c460d-f976-4547-b711-553541f0abfe)

### dbdiagram.io code
**Database Schema code snippet:**

![image](https://github.com/user-attachments/assets/42756683-8038-454b-83a2-5eea42270a36)

### SQL schema snippets
**SQL schema excample - ingredients table:**

![image](https://github.com/user-attachments/assets/f9eaca07-3330-408b-9ccb-ffda4de4038e)

**SQL schema example - relationships:**

![image](https://github.com/user-attachments/assets/db695144-c5cb-46c2-be41-6141ad8d6e78)

### sql query snippets
**SQL query example - Restaurant Sales View:**

![image](https://github.com/user-attachments/assets/70b80ffd-4581-4fc3-945f-ba15a0f0161e)

**SQL query example - top 5 ingredients total quantities:**

![image](https://github.com/user-attachments/assets/a3ef10b5-cf80-4327-af7b-680e2c2af223)

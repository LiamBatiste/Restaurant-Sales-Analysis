# Restaurant-Sales-Analysis

### Introduction
Welcome to my Restaurant Sales Analysis repository! This project was developed to address critical challenges in the fast food industry. The primary goal is to internally benchmark key metrics that can help the business improve overall efficiency and maximise profits.

### **Problem Statement:**
To enhance the internal competitive positioning and operational efficiency of the restaurant chain, it is crucial to identify key performance drivers and areas for improvement across the menu offerings, store locations, and customer behaviors. Through comprehensive analysis of sales trends, ingredient usage, customer purchase patterns, and store-specific performance, I aim to establish benchmarks that will inform strategic decisions, optimise resource allocation, and improve profitability. By comparing these internal metrics, I seek to uncover actionable insights that will lead to more effective pricing strategies, better inventory management, and enhanced customer satisfaction across all locations 

### Dataset
The dataset used for this analysis was taken from [Kaggle - Fast-Food Restaurant Chain](https://www.kaggle.com/datasets/rishitsaraf/fast-food-restaurant-chain/data?select=recipe_sub_recipe_assignments.csv). The dataset was provided by one of the largest fast-food restaurant chains in the US. It includes (1) transaction information such as menu items that were purchased and quantities of each item; (2) ingredient lists for individual menu items; (3) metadata on restaurants, including location and store type from 2 stores in Berkeley, CA and 2 stores in New York, NY.

# Python Data Cleaning and Peparation

To ensure accurate and meaningful analysis, the first step was to prepare the dataset using Python library Pandas and Numpy. This involved several key processes:

### Data Cleaning:

- Handling Missing Values: Removed or imputed missing data to ensure consistency, such as record with '#NAME?' values being dropped.

- Data Type Conversion: Converted data types such as date types to the correct format so they compatible with SQL DATE datatype as part of a later schema. 

- Removing Duplicates: Identified and removed any duplicate records to maintain data integrity such as columns that were similar in nature like the item description and name.

With respect to data normalisation, given that the data was taken from Kaggle, the data was already in a state which allowed for comparison across all metrics. 


### Database Intergation: 
A database schema was first developed using **https://dbdiagram.io/home** 
![image](https://github.com/user-attachments/assets/680b962c-eafe-4249-be95-488c46d3658a)
[Database Schema PDF](https://github.com/LiamBatiste/Restaurant-Sales-Analysis/blob/main/Fast%20Food%20Sales%20Schema.pdf)


This was important firstly as it would allow me to visualise the database when writing SQL queries that involved joins and naming conventions. Additionally, the cleaned and transformed data could then be loaded directly into the SQL database from the now cleaned CSV files to facilitate querying and further analysis.

# SQL Querying - Restaurant Sales Internal Benchmarking:

### Insights through mySQL:

Once the data was populated into the mySQL schema I could begin to conduct my analysis. The key areas of interest and insights gained were as follows:

**Sales performance by top 5 menu items for total sales revenue across all stores**
  
![image](https://github.com/user-attachments/assets/a0af1c85-038c-4a72-a0bc-f247c28d2387)

As shown above, the top 5 items sold across all stores by total revenue was;
**1st - Turkey Foot Long, 2nd - Chicken Teriyaki Foot Long, 3rd - Tuna Foot Long, 4th - 21oz Fountain Drink, 5th - Roast Chicken Foot Long**. 
This insight could potentially be leveraged by the company during promotions as they appeal to the largest sector with respect to sales and potentially drive more overall sales. Further, the best performing items are generally 'main meal' items so could be used as part of a meal-deal promotion to incentives repeat customers. 

**Sales performance by top 5 menu items for total sales quantity across all stores**

![image](https://github.com/user-attachments/assets/b8d3680c-81ab-4f33-bcbb-ae7586ce2892)

The top 5 items sold across all stores by total quantity was; 
**chips across 3 different stores, 21oz Fountain Drink across 2 different stores**. 
This could well be due to these items being 'budget-friendly' items (as when compared the price of these items were well below the average of ~ $3.4 across stores, which may explain the high sales volume across stores. This finding could be coupled with the aforementioned insight through chips and water being part of a bundle deal to drive more sales and upsell the more expensive 'main meal' items through a snack, side and drink.


# Power BI Dashboard:
[Quick Dashboard Showcase](https://github.com/user-attachments/assets/5b70fe68-312c-4d00-931c-00188178e7c6)


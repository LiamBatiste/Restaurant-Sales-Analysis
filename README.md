# Restaurant-Sales-Analysis

### Introduction
Welcome to my Restaurant Sales Analysis repository! This project was developed to address critical challenges in the fast food industry. The primary goal is to internally benchmark key metrics that can help the business improve overall efficiency and maximise profits.

### **Problem Statement:**
To enhance the internal competitive positioning and operational efficiency of the restaurant chain, it is crucial to identify key performance drivers and areas for improvement across the menu offerings, store locations, and customer behaviors. Through comprehensive analysis of sales trends, ingredient usage, customer purchase patterns, and store-specific performance, I aim to establish benchmarks that will inform strategic decisions, optimise resource allocation, and improve profitability. By comparing these internal metrics against industry standards and best practices, I seek to uncover actionable insights that will lead to more effective pricing strategies, better inventory management, and enhanced customer satisfaction across all locations.

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

**Sales performance by top 5 menu items for total sales revenue**
  
![image](https://github.com/user-attachments/assets/a0af1c85-038c-4a72-a0bc-f247c28d2387)

As shown above, the top 5 items sold across all stores by total revenue was; **1st - Turkey Foot Long, 2nd - Chicken Teriyaki FtLong, 3rd - Tuna FtLong, 4th - 21oz Fountain Drink, 5th - Rst Chicken FtLong**. 
This insight could potentially used by the company during promotions as they appeal to the largest sector with respect to sales. 

Given the 


# Power BI Dashboard:
[Quick Dashboard Showcase](https://github.com/user-attachments/assets/5b70fe68-312c-4d00-931c-00188178e7c6)


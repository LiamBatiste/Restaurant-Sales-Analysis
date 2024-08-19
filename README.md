# Restaurant-Sales-Analysis

### Introduction
Welcome to my Restaurant Sales Analysis repository! This project was developed to address critical challenges in the fast food industry. The primary goal is to internally benchmark key metrics that can help the business improve overall efficiency and maximise profits.

### **Problem Statement:**
To enhance the internal competitive positioning and operational efficiency of the restaurant chain, it is crucial to identify key performance drivers and areas for improvement across the menu offerings, store locations, and customer behaviors. Through comprehensive analysis of sales trends, ingredient usage, customer purchase patterns, and store-specific performance, I aim to establish benchmarks that will inform strategic decisions, optimise resource allocation, and improve profitability. By comparing these internal metrics against industry standards and best practices, I seek to uncover actionable insights that will lead to more effective pricing strategies, better inventory management, and enhanced customer satisfaction across all locations.

# Python Data Cleaning and Peparation

To ensure accurate and meaningful analysis, the first step was to prepare the dataset. This involved several key processes:

### Data Cleaning:

- Handling Missing Values: Removed or imputed missing data to ensure consistency, such as record with '#NAME?' values being dropped.

- Data Type Conversion: Converted data types such as date types to the correct format so they compatible with SQL DATE datatype as part of a later schema. 

- Removing Duplicates: Identified and removed any duplicate records to maintain data integrity such as columns that were similar in nature like the item description and name.

With respect to data normalisation, given that the data was taken from Kaggle, the data was already in a state which allowed for comparison across all metrics. 

### Database Intergation: 
A database schema was first developed using **https://dbdiagram.io/home**
[Database Schema](https://github.com/LiamBatiste/Restaurant-Sales-Analysis/blob/main/Fast%20Food%20Sales%20Schema.pdf)
![image](https://github.com/user-attachments/assets/680b962c-eafe-4249-be95-488c46d3658a)

This was important firstly as it would allow me to visualise the database when writing SQL queries with both the aspects of joins and also with naming conventions. 

#SQL Querying - Restaurant Sales Benchmarking:


#Power BI Dashboard:
[Quick Dashboard Showcase](https://github.com/user-attachments/assets/5b70fe68-312c-4d00-931c-00188178e7c6)


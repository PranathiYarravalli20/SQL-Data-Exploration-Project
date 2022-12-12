## SQL-Data-Exploration-Project

### Hypothetical Paper Company's Sales Data - Cleaning &amp; Exploration

Sales data is used to explore different functional aspects of SQL from basic to advanced and project.
Project description,functions,queries written,environment used is mentioned in the [readme file](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/README.md).

### Setting up the environment & Database used:

A hypothetical paper company's sales data of different types of paper (gloss, standard). The database consists of different [tables](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/tree/main/data) linked with a database schema.

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### Questions:
[click here to view code](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/Queries.sql)
1. Do any sales reps worked on more than one account?
2. Does any sales reps have more than 3 accounts that they manage?
3. Accounts have more than 5 orders?
4. Account has the most orders?
5. Accounts spent more than 30,000 USD total across all orders?
6. Accounts used facebook as a channel to contact customers more than 6 times?
7. Channel was most frequently used by most accounts?
5. Accounts spent more than 30,000 USD total across all orders?
6. Accounts used facebook as a channel to contact customers more than 6 times?
7. Channel was most frequently used by most accounts?
8. Ranking Total Paper Ordered by each Account
9. Sales Representatives working in Midwest region
10. Total Sales by each account
11. Checking if each account has more than one primary_poc
12. Sales across years

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### JOINS
[click here to view code](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/JOINS.sql)

Queries answered using joins:
1. Table for all web_events associated with account name of Walmart.
2. Table that provides the region for each sales_rep along with their associated accounts.
3. Account name and the unit price paid (total_amt_usd/total) for the order.

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### AGGREGATION Functions
[click here to view code](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/AGGREGATIONS.sql)

Queries answered using aggregations:
1. Unique Accounts
2. To test if there are any accounts associated with more than one region
3. Total Sales made by each account

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### Logical & Comparison Operators
[click here to view code](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/Logical%20&%20Comparison%20Operators.sql)

Queries answered using Operators:
1. Companies whose names start with 'C'
2. Sales Rep working in Midwest region and name starts with K (using logical operator AND)
3. Sales Rep that purchased standard qty >100 and poster qty > 50 ( using comparison operator)
4. Orders occured BETWEEN dates '2015-1-1' AND '2016-1-1'

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### String Functions
[click here to view code](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/String%20Functions.sql)

Queries answered using String functions:
1. String functions to clean data - To replace NULL values by 0.
2. Generate email id to sales_reps

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### Sub queries & CTE
[click here to view code](https://github.com/PranathiYarravalli20/SQL-Data-Exploration-Project/blob/main/Sub%20Queries%20&%20CTE.sql)

Queries answered using sub queries & CTE:
1. Total sales made by each sales_reps and rank category assigned
2. No of orders in the region with Highest sales.
3. Sales Rep in each region who made maximum total sales

-------------------------------------------------------------------------------------------------------------------------------------------------------------
### SQL SERVER:
MY SQL Workbench version 8.0 is used for this project and SQL quering.

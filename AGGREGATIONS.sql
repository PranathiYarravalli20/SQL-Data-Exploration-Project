-- 1. Unique Accounts

SELECT 
    COUNT(DISTINCT (a.name)) AS Account_name_count
FROM
    papersales.accounts a;

----------------------------------------------------------------------------------------------

/* 2. To test if there are any accounts associated with more than one region */

SELECT DISTINCT
    a.name, r.name AS region_name
FROM
    papersales.accounts a
        JOIN
    papersales.sales_reps s ON a.sales_rep_id = s.id
        JOIN
    papersales.region r ON r.id = s.region_id
GROUP BY a.name;



SELECT 
    COUNT(*)
FROM
    accounts a
        JOIN
    sales_reps s ON s.id = a.sales_rep_id
        JOIN
    region r ON r.id = s.region_id;

-- No accounts associated with more than one region

----------------------------------------------------------------------------------------------

/* 3. Total Sales made by each account */

SELECT DISTINCT
    (a.name),
    SUM(o.total_amt_usd) AS Total_sales,
    COUNT(o.total_amt_usd) AS orders_count,
    AVG(o.total_amt_usd) AS avg_amt
FROM
    papersales.orders o
        JOIN
    papersales.accounts a ON a.id = o.account_id
GROUP BY a.name
ORDER BY 2 DESC;


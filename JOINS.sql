SELECT 
    *
FROM
    papersales.web_events;

----------------------------------------------------------------------------------------------
/* Queries
1. Table for all web_events associated with account name of Walmart. */

SELECT 
    a.primary_poc, w.channel, w.occurred_at, a.name
FROM
    papersales.accounts a
        JOIN
    papersales.web_events w ON a.id = w.account_id
WHERE
    a.name = 'Walmart';

----------------------------------------------------------------------------------------------
/* 2. Table that provides the region for each sales_rep along with their associated accounts. */

SELECT 
    r.name as region, s.name as sales_rep_name , a.name AS account_name
FROM
    papersales.accounts a
        JOIN
    papersales.sales_reps s ON a.sales_rep_id = s.id
        JOIN
    papersales.region r ON r.id = s.region_id;
    
----------------------------------------------------------------------------------------------
/* 3. Account name and the unit price paid (total_amt_usd/total) for the order. */

SELECT 
    a.name AS account_name,
    r.name AS region,
    CASE
        WHEN o.total = 0 THEN (o.total_amt_usd / (o.total + 0.01))
        ELSE (o.total_amt_usd / o.total)
    END AS unit_price
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
        JOIN
    papersales.sales_reps s ON a.sales_rep_id = s.id
        JOIN
    papersales.region r ON r.id = s.region_id;
    
    

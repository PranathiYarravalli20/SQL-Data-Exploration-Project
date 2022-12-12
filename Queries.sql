/* 1. Sales reps worked on more than one account? */

select s.name as salrep_name,count(*) as acc
from papersales.accounts a 
join papersales.sales_reps s
on a.sales_rep_id = s.id
group by s.name 
order by 2 desc;

-- Sale Rep's work on more than one account
------------------------------------------------------------------------------------------------------------------

/* 2. Sales reps have more than 3 accounts that they manage? */

SELECT 
    s.name AS salrep_name, COUNT(*) AS acc
FROM
    papersales.accounts a
        JOIN
    papersales.sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING acc > 3
ORDER BY 2;

--------------------------------------------------------------------------------------------------------------------

/* 3. Accounts have more than 5 orders? */

SELECT 
    a.id, a.name, COUNT(*) AS no_of_orders
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name
HAVING no_of_orders > 5
ORDER BY 3;

------------------------------------------------------------------------------------------------------------------

/* 4. Account has the most orders? */

SELECT 
    a.name, COUNT(*) AS no_of_orders
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY 2 DESC
LIMIT 1;

------------------------------------------------------------------------------------------------------------------

/* 5. Accounts spent more than 30,000 USD total across all orders? */

SELECT 
    a.id, a.name, tb.total
FROM
    (SELECT 
        o.account_id, SUM(o.total_amt_usd) AS total
    FROM
        papersales.orders AS o
    GROUP BY o.account_id
    HAVING total > 30000) AS tb
        JOIN
    papersales.accounts a ON a.id = tb.account_id
ORDER BY tb.total DESC;

------------------------------------------------------------------------------------------------------------------

/* 6. Accounts used facebook as a channel to contact customers more than 6 times? */

SELECT 
    a.name AS acc_name, COUNT(*) AS fb_usage
FROM
    papersales.accounts a
        JOIN
    papersales.web_events w ON a.id = w.account_id
WHERE
    w.channel = 'facebook'
GROUP BY a.name
HAVING fb_usage > 2;

------------------------------------------------------------------------------------------------------------------

/* 7. Channel was most frequently used by most accounts? */

SELECT 
    w.channel, COUNT(DISTINCT a.name) AS count
FROM
    papersales.accounts a
        JOIN
    papersales.web_events w ON a.id = w.account_id
GROUP BY w.channel
ORDER BY count DESC;

------------------------------------------------------------------------------------------------------------------

/* 8. Ranking Total Paper Ordered by each Account */

select id,account_id,total,rank() over(partition by account_id order by total desc) total_rank
from papersales.orders;

------------------------------------------------------------------------------------------------------------------

/* 9. Sales Representatives working in Midwest region */

SELECT 
    s.name rep_name, a.name acc_name, r.name region
FROM
    papersales.sales_reps s
        JOIN
    papersales.accounts a ON s.id = a.sales_rep_id
        JOIN
    papersales.region r ON s.region_id = r.id
WHERE
    r.name = 'Midwest'
GROUP BY rep_name , acc_name
ORDER BY a.name;

------------------------------------------------------------------------------------------------------------------

/* 10. Total Sales by each account */

SELECT 
    a.name, SUM(o.total_amt_usd) AS Total_Sales
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name;

------------------------------------------------------------------------------------------------------------------

/* 11. Checking if each account has more than one primary_poc */

select count(*) as poc from (SELECT 
    a.name, a.primary_poc, COUNT(*) as count
FROM
    papersales.accounts a
GROUP BY a.name , a.primary_poc
having count > 1
ORDER BY count DESC) as POC;

-- No primary_poc is managing more than one account name

------------------------------------------------------------------------------------------------------------------

/* 12. Sales across years */

SELECT 
    DATE_PART(year, o.occurred_at) AS sales_year,
    SUM(o.total_amt_usd) sales_in_that_year
FROM
    papersales.orders o
GROUP BY 1
ORDER BY 2 DESC;


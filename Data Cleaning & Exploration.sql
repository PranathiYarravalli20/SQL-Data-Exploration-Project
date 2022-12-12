SELECT 
    *
FROM
    papersales.web_events;

----------------------------------------------------------------------------------------------
/* Queries
1. Provide a table for all web_events associated with account name of Walmart. */

SELECT 
    a.primary_poc, w.channel, w.occurred_at, a.name
FROM
    papersales.accounts a
        JOIN
    papersales.web_events w ON a.id = w.account_id
WHERE
    a.name = 'Walmart';

----------------------------------------------------------------------------------------------
/* 2. Provide a table that provides the region for each sales_rep along with their associated accounts. */

SELECT 
    r.name as region, s.name as sales_rep_name , a.name AS account_name
FROM
    papersales.accounts a
        JOIN
    papersales.sales_reps s ON a.sales_rep_id = s.id
        JOIN
    papersales.region r ON r.id = s.region_id;
    
----------------------------------------------------------------------------------------------

/* 3. Provide the name for each region for every order, as well as the account name and the unit price 
they paid (total_amt_usd/total) for the order. */

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
    
----------------------------------------------------------------------------------------------

-- Aggregations

SELECT 
    COUNT(DISTINCT (a.name)) AS Account_name_count
FROM
    papersales.accounts a;

/* to test if there are any accounts associated with more than one region */

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

/* any sales reps worked on more than one account? */

select s.name as salrep_name,count(*) as acc
from papersales.accounts a 
join papersales.sales_reps s
on a.sales_rep_id = s.id
group by s.name 
order by 2 desc;

-- Sale Rep's work on more than one account

/* sales reps have more than 3 accounts that they manage? */

SELECT 
    s.name AS salrep_name, COUNT(*) AS acc
FROM
    papersales.accounts a
        JOIN
    papersales.sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING acc > 3
ORDER BY 2;

/* accounts have more than 5 orders*/

SELECT 
    a.id, a.name, COUNT(*) AS no_of_orders
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name
HAVING no_of_orders > 20
ORDER BY 3;

/* account has the most orders? */

SELECT 
    a.name, COUNT(*) AS no_of_orders
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY 2 DESC
LIMIT 1;

----------------------------------------------------------------------------------------------

/* accounts spent more than 30,000 USD total across all orders? */

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

----------------------------------------------------------------------------------------------

/*  accounts used facebook as a channel to contact customers more than 6 times? */

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

/* Which channel was most frequently used by most accounts? */

SELECT 
    w.channel, COUNT(DISTINCT a.name) AS count
FROM
    papersales.accounts a
        JOIN
    papersales.web_events w ON a.id = w.account_id
GROUP BY w.channel
ORDER BY count DESC;

SELECT 
    SUM(o.total_amt_usd) AS sum_amt,
    COUNT(o.total_amt_usd) AS count,
    AVG(o.total_amt_usd) AS avg_amt
FROM
    papersales.orders o;

---------------------------------------------------------------------------------------------

/* Companies whose names start with 'C' */

select a.name
from papersales.accounts a
where a.name like 'M%';

---------------------------------------------------------------------------------------------

/* Ranking Total Paper Ordered by each Account */

select id,account_id,total,rank() over(partition by account_id order by total desc) total_rank
from papersales.orders;

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
ORDER BY a.name;

SELECT 
    s.name rep_name, a.name acc_name, r.name region
FROM
    papersales.sales_reps s
        JOIN
    papersales.accounts a ON s.id = a.sales_rep_id
        JOIN
    papersales.region r ON s.region_id = r.id
WHERE
    s.name LIKE 'K%' AND r.name = 'Midwest'
ORDER BY a.name;

SELECT 
    Case 
    when o.total_amt_usd <> 0 then o.total_amt_usd
    when o.total_amt_usd = 0 then (o.total_amt_usd / (o.total + 0.01))
    end as 'unit_price',
    a.name acc_name,
    r.name region
FROM
    papersales.orders o
        JOIN
    papersales.accounts a ON a.id = o.account_id
        JOIN
    papersales.sales_reps s ON s.id = a.sales_rep_id
        JOIN
    papersales.region r ON s.region_id = r.id
WHERE
    o.standard_qty > 100
        AND o.poster_qty > 50
ORDER BY unit_price;

SELECT 
    o.occurred_at, a.name, o.total, o.total_amt_usd
FROM
    papersales.orders o
        JOIN
    papersales.accounts a ON o.account_id = a.id
WHERE
    o.occurred_at BETWEEN '2015-1-1' AND '2016-1-1'
ORDER BY o.occurred_at;

SELECT 
    a.name, SUM(o.total_amt_usd) AS Total_Sales
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name;

SELECT 
    a.name, a.primary_poc, COUNT(*)
FROM
    papersales.accounts a
GROUP BY a.name , a.primary_poc
ORDER BY COUNT(*) DESC;

SELECT 
    a.name,
    AVG(o.standard_qty) Avg_standard,
    AVG(o.gloss_qty) Avg_gloss,
    AVG(o.poster_qty) Avg_poster
FROM
    papersales.accounts a
        JOIN
    papersales.orders o ON a.id = o.account_id
GROUP BY a.name;

/* Sales rose from 2013-16 and there was a sudden dip in 2017 */

SELECT 
    DATE_PART(year, o.occurred_at) AS sales_year,
    SUM(o.total_amt_usd) sales_in_that_year
FROM
    papersales.orders o
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    rep_name,
    no_of_sales_by_rep,
    total_sales,
    CASE
        WHEN
            no_of_sales_by_rep > 200
                OR total_sales > 750000
        THEN
            'top'
        WHEN
            (no_of_sales_by_rep > 150
                AND no_of_sales_by_rep <= 200)
                OR (total_sales > 500000
                AND total_sales <= 750000)
        THEN
            'middle'
        ELSE 'low'
    END AS tmn
FROM
    (SELECT 
        s.name AS rep_name,
            COUNT(*) AS no_of_sales_by_rep,
            SUM(total_amt_usd) AS total_sales
    FROM
        papersales.orders o
    JOIN papersales.accounts a ON a.id = o.account_id
    JOIN papersales.sales_reps s ON a.sales_rep_id = s.id
    GROUP BY s.name) AS Topnot
ORDER BY total_sales DESC;

SELECT 
    *, COALESCE(o.account_id, a.id) AS modif_o_acc_id
FROM
    papersales.accounts a
        LEFT JOIN
    papersales.orders o ON a.id = o.account_id
WHERE
    o.total IS NULL;
    
    SELECT 
    *,
    COALESCE(a.id, a.id) modified_id,
    COALESCE(o.account_id, a.id) modified_acc,
    COALESCE(o.standard_qty, 0) modified_st_qty,
    COALESCE(o.poster_qty, 0) modified_pos_qty,
    COALESCE(o.gloss_qty, 0) modified_gloss_qty,
    COALESCE(o.standard_amt_usd, 0) modified_std_amt,
    COALESCE(o.gloss_amt_usd, 0) modified_glo_amt,
    COALESCE(o.poster_amt_usd, 0) modified_pos_amt
FROM
    papersales.accounts a
        LEFT JOIN
    papersales.orders o ON a.id = o.account_id
where o.standard_qty is NULL;

SELECT
lower(CONCAT(
  LEFT(primary_poc, STRPOS(primary_poc,' ')-1),
  '.',
  RIGHT(primary_poc, Length(primary_poc) - STRPOS(primary_poc,' ')),
  '@',
  replace(name,' ',''),
  '.com')) AS email 
FROM papersales.accounts a;

SELECT 
    name,
    primary_poc,
    CONCAT(REPLACE(LOWER(primary_poc), ' ', '.'),
            '@',
            REPLACE(LOWER(name), ' ', ''),
            '.com') AS Email
FROM
    papersales.accounts a;


   SELECT 
    r.name, COUNT(*) as count
FROM
    papersales.orders o
        JOIN
    papersales.accounts a ON a.id = o.account_id
        JOIN
    papersales.sales_reps s ON s.id = a.sales_rep_id
        JOIN
    papersales.region r ON r.id = s.region_id
WHERE
    r.name = (SELECT 
            r.name regname
        FROM
            papersales.orders o
                JOIN
            papersales.accounts a ON a.id = o.account_id
                JOIN
            papersales.sales_reps s ON s.id = a.sales_rep_id
                JOIN
            papersales.region r ON r.id = s.region_id
        GROUP BY r.name
        ORDER BY SUM(total_amt_usd) DESC
        LIMIT 1);
        
	with t1 AS (SELECT r.name region_name,s.name rep_name,  SUM(o.total_amt_usd) Sales_made
				  FROM papersales.orders o 
				  JOIN papersales.accounts a
	              ON a.id = o.account_id
	              JOIN papersales.sales_reps s
	              ON s.id = a.sales_rep_id
	              JOIN papersales.region r
				  ON r.id = s.region_id
				  GROUP BY r.name,s.name),
	 
	 t2 AS (SELECT t1.region_name, Max(t1.Sales_made) Max_sales
	  		FROM  t1
			GROUP BY t1.region_name)

SELECT t1.region_name, t1.rep_name
FROM t1
JOIN t2
ON t1.Sales_made = t2.Max_sales;

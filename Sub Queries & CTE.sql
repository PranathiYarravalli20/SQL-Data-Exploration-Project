/* 1. Total sales made by each sales_reps and rank category assigned */

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
    END AS rank_assigned
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

------------------------------------------------------------------------------------------------------------------

/* 2. No of orders in the region with Highest sales. */

 SELECT 
    r.name, COUNT(*) as orders_count
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

------------------------------------------------------------------------------------------------------------------

/* 3. Sales Rep in each region who made maximum total sales */
        
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

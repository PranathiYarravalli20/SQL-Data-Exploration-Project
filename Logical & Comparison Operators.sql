/* 1. Companies whose names start with 'C' */

select a.name
from papersales.accounts a
where a.name like 'M%';

------------------------------------------------------------------------------------------------------------------

/* 2. Sales Rep working in Midwest region and name starts with K (using logical operator AND) */

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

------------------------------------------------------------------------------------------------------------------

/* 3. Sales Rep that purchased standard qty >100 and poster qty > 50 ( using comparison operator) */

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

------------------------------------------------------------------------------------------------------------------

/* 4. Orders occured BETWEEN dates '2015-1-1' AND '2016-1-1' */

SELECT 
    o.occurred_at, a.name, o.total, o.total_amt_usd
FROM
    papersales.orders o
        JOIN
    papersales.accounts a ON o.account_id = a.id
WHERE
    o.occurred_at BETWEEN '2015-1-1' AND '2016-1-1'
ORDER BY o.occurred_at;


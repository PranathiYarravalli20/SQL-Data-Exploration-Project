/* 1. String functions to clean data - To replace NULL values by 0. */

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
    papersales.orders o ON a.id = o.account_id;

------------------------------------------------------------------------------------------------------------------

/* 2. Generate email id to sales_reps */

SELECT 
    name,
    primary_poc,
    CONCAT(REPLACE(LOWER(primary_poc), ' ', '.'),
            '@',
            REPLACE(LOWER(name), ' ', ''),
            '.com') AS Email
FROM
    papersales.accounts a;
    

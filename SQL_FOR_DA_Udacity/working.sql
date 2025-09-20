/**
 * A commented-out query to select all columns from the orders table.
 */
---SELECT *
---FROM orders
---;

/**
 * Selects all columns from the 'orders' table where the
 * 'gloss_amt_usd' is greater than or equal to 1000.
 */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
;

/**
 * Selects all columns from the first 10 rows in the 'orders' table
 * where the 'total_amt_usd' is less than 500.
 */
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10
;

/**
 * Selects the name, website, and primary point of contact from the
 * 'accounts' table for the company 'Exxon Mobil'.
 */
SELECT name,  website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

/**
 * Calculates the unit price for standard paper ('u_mom') by dividing
 * 'standard_amt_usd' by 'standard_qty' for the first 10 orders.
 * It includes all original columns from the 'orders' table.
 * NULLIF is used to prevent division by zero.
 */
SELECT * ,standard_amt_usd / NULLIF(standard_qty, 0) as u_mom
FROM orders
LIMIT 10
;

/**
 * Calculates the total amount from standard, gloss, and poster paper
 * for the first 10 orders and aliases it as 'u_mom'.
 * It includes all original columns from the 'orders' table.
 */
SELECT * ,standard_amt_usd + gloss_amt_usd + poster_amt_usd  as u_mom
FROM orders
LIMIT 10
;

/**
 * LIKE QUIZ 1: Selects the first 10 accounts where the name starts with 'C'.
 */
SELECT *
FROM accounts
WHERE name LIKE 'C%'
LIMIT 10
;

/**
 * LIKE QUIZ 2: Selects the first 10 accounts where the name contains 'one'.
 */
SELECT *
FROM accounts
WHERE name LIKE '%one%'
LIMIT 10
;

/**
 * LIKE QUIZ 3: Selects the first 10 accounts where the name ends with 's'.
 */
SELECT *
FROM accounts
WHERE name LIKE '%s'
LIMIT 10
;

/**
 * IN QUIZ 1: Selects name, primary_poc, and sales_rep_id for specific
 * accounts: 'Walmart', 'Target', and 'Nordstrom'.
 */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')
;

/**
 * IN QUIZ 2: Selects all web events that occurred through the
 * 'organic' or 'adwords' channels.
 */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')
;


\echo  'QUIZ  NOT';

\echo  'NUM: 1';
/**
 * NOT IN QUIZ 1: Selects accounts that are NOT 'Walmart', 'Target', or 'Nordstrom'.
 */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom')
;

\echo  'NUM: 2';
/**
 * NOT IN QUIZ 2: Selects web events that are NOT from the 'organic' or 'adwords' channels.
 */
SELECT *
FROM web_events
WHERE channel NOT  IN ('organic', 'adwords')
;

\echo  'NUM: 3';
/**
 * NOT LIKE QUIZ 3: Selects the first 10 accounts where the name does NOT start with 'C'.
 */
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%'
LIMIT 10
;

\echo  'NUM: 4';
/**
 * NOT LIKE QUIZ 4: Selects the first 10 accounts where the name does NOT contain 'one'.
 */
SELECT *
FROM accounts
WHERE name NOT LIKE '%one%'
LIMIT 10
;

\echo  'NUM: 5';
/**
 * NOT LIKE QUIZ 5: Selects the first 10 accounts where the name does NOT end with 's'.
 */
SELECT *
FROM accounts
WHERE name NOT LIKE '%s'
LIMIT 10
;


\echo  'QUIZ : AND BETWEAN'
\echo  '1 -> : ';
/**
 * Selects orders with a 'standard_qty' less than 1000, and
 * where both 'poster_qty' and 'gloss_qty' are zero.
 */
SELECT *
FROM orders
WHERE standard_qty < 1000 AND poster_qty = 0 AND gloss_qty = 0
;

/**
 * JOIN QUIZ 1: Retrieves the primary point of contact, event time, and channel
 * for all web events associated with the 'Walmart' account.
 */
SELECT  
    accounts.name AS account_name,  -- Optional for verification
    accounts.primary_poc, 
    web_events.occurred_at AS event_time, 
    web_events.channel
FROM web_events
JOIN accounts 
    ON web_events.account_id = accounts.id
WHERE accounts.name = 'Walmart';

/**
 * JOIN QUIZ 2: Joins region, sales_reps, and accounts tables to list
 * the region name, sales rep name, and account name for each account,
 * ordered by the account name.
 */
SELECT  
region.name as region_name,
sales_reps.name AS sales_name,
accounts.name AS account_name
FROM sales_reps
JOIN accounts
    ON sales_reps.id = accounts.sales_rep_id
JOIN region
    ON sales_reps.region_id = region.id
ORDER BY account_name;

/**
 * JOIN QUIZ 3: Calculates the unit price for the first 10 orders by joining
 * accounts, orders, sales_reps, and region tables. Displays region name,
 * account name, and the calculated unit price.
 */
SELECT
region.name AS region_name,
accounts.name AS account_name,
orders.total_amt_usd / NULLIF(orders.total, 0)  AS unit_price 
FROM accounts
JOIN orders
    ON orders.account_id = accounts.id
JOIN sales_reps
    ON sales_reps.id = accounts.sales_rep_id
JOIN region
    ON sales_reps.region_id = region.id
LIMIT 10;


/**
 * LAST CHECK 1: (Commented out)
 * Selects region, sales rep, and account names for accounts in the
 * 'Midwest' region, ordered by account name.
 */
-- -- Quiz Quiz: Last Check
-- SELECT region.name AS RegionName,sales_reps.name AS SalesRepName ,accounts.name AS AccountsName
-- FROM accounts
-- JOIN sales_reps
-- ON accounts.sales_rep_id = sales_reps.id  
-- JOIN region
-- ON region.id = sales_reps.region_id
-- WHERE region.name LIKE '%Midwest%'
-- ORDER BY accounts.name
-- ;

/**
 * LAST CHECK 2: (Commented out)
 * Selects region, sales rep, and account names for accounts in the
 * 'Midwest' region where the sales rep's name starts with 'S'.
 */
--
-- -- Quiz Quiz: Last Check
-- SELECT region.name AS RegionName,sales_reps.name AS SalesRepName ,accounts.name AS AccountsName
-- FROM accounts
-- JOIN sales_reps
-- ON accounts.sales_rep_id = sales_reps.id
-- JOIN region
-- ON region.id = sales_reps.region_id
-- WHERE region.name LIKE '%Midwest%'AND sales_reps.name LIKE 'S%'
-- ORDER BY accounts.name
-- ;

/**
 * LAST CHECK 3: (Commented out)
 * Selects region, sales rep, and account names for accounts in the
 * 'Midwest' region where the sales rep's name starts with 'S'.
 * (Uses double quotes for aliases).
 */
--
-- -- Quiz Quiz: Last Check
-- SELECT region.name AS "RegionName",sales_reps.name AS "SalesRepName" ,accounts.name AS "AccountsName"
-- FROM accounts
-- JOIN sales_reps
-- ON accounts.sales_rep_id = sales_reps.id
-- JOIN region
-- ON region.id = sales_reps.region_id
-- WHERE region.name LIKE '%Midwest%'AND sales_reps.name LIKE 'S%'
-- ORDER BY accounts.name
-- ;

/**
 * LAST CHECK 4: (Commented out)
 * Selects region, sales rep, and account names for accounts in the
 * 'Midwest' region where the sales rep's name starts with 'K'.
 */
-- -- Quiz Quiz: Last Check
-- SELECT region.name AS "RegionName",sales_reps.name AS "SalesRepName" ,accounts.name AS "AccountsName"
-- FROM accounts
-- JOIN sales_reps
-- ON accounts.sales_rep_id = sales_reps.id
-- JOIN region
-- ON region.id = sales_reps.region_id
-- WHERE region.name LIKE '%Midwest%'AND sales_reps.name LIKE 'K%'
-- ORDER BY accounts.name
-- ;

/**
 * LAST CHECK 5: (Commented out)
 * Calculates unit price for orders with standard_qty > 100.
 */
-- -- Quiz Quiz: Last Check 4
-- SELECT region.name AS "RegionName", accounts.name AS "AccountsName",total_amt_usd  / NULLIF(total, 0) AS "unit price"
-- FROM accounts
-- JOIN sales_reps
-- ON accounts.sales_rep_id = sales_reps.id
-- JOIN region
-- ON region.id = sales_reps.region_id
-- JOIN orders
-- ON accounts.id = orders.account_id
-- WHERE standard_qty > 100
-- ;

/**
 * LAST CHECK 6: (Commented out)
 * Calculates unit price for orders with standard_qty > 100 and poster_qty > 50.
 */
-- -- Quiz Quiz: Last Check 5
-- SELECT region.name AS "RegionName", accounts.name AS "AccountsName",total_amt_usd  / NULLIF(total, 0) AS "unit price"
-- FROM accounts
-- JOIN sales_reps
-- ON accounts.sales_rep_id = sales_reps.id
-- JOIN region
-- ON region.id = sales_reps.region_id
-- JOIN orders
-- ON accounts.id = orders.account_id
-- WHERE standard_qty > 100 AND poster_qty > 50
-- ;

/**
 * LAST CHECK 7: Calculates the unit price for orders with more than 100
 * standard quantity and more than 50 poster quantity. It joins across
 * accounts, sales_reps, region, and orders tables. Results are ordered
 * by unit price in descending order.
 */
SELECT region.name AS "RegionName", accounts.name AS "AccountsName",total_amt_usd  / NULLIF(total, 0) AS "unit price"
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON region.id = sales_reps.region_id
JOIN orders
ON accounts.id = orders.account_id
WHERE standard_qty > 100 AND poster_qty > 50
ORDER BY "unit price" DESC
;


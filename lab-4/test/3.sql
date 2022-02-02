/*How many orders are posted by customers in every 
country in AMERICA?*/
SELECT n_name, COUNT(*)
FROM orders
INNER JOIN customer, region, nation
ON ((o_custkey = c_custkey) AND (c_nationkey = n_nationkey) AND 
(n_regionkey = r_regionkey) AND (r_name = 'AMERICA'))
GROUP BY n_name
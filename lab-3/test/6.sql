/*What are the nations of customers who made orders between
September 10-12, 1996? Print every nation only once and sort 
them in alphabetical order.*/
SELECT DISTINCT n_name
FROM nation
INNER JOIN customer
ON (n_nationkey = c_nationkey)
INNER JOIN orders
ON (c_custkey = o_custkey AND ('1996-09-10' <= o_orderdate
 AND o_orderdate <= '1996-09-12'))
ORDER BY n_name
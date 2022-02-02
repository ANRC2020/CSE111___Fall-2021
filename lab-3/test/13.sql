/*Find the total account balance of all the customers from 
EUROPE in the MACHINERY market segment.*/
SELECT SUM(c_acctbal)
FROM customer
INNER JOIN nation
ON (c_mktsegment = 'MACHINERY' AND c_nationkey = n_nationkey AND n_regionkey = '3')
/*Find the number of customers that received a discount 
of at least 10% for one of the line items on their orders.
Count every customer exactly once even if they have
multiple discounted line items.*/

SELECT count(DISTINCT c_custkey)
FROM customer
INNER JOIN orders
ON o_custkey = c_custkey
INNER JOIN lineitem
ON l_orderkey = o_orderkey AND l_discount >= 0.1
-- GROUP BY c_custkey

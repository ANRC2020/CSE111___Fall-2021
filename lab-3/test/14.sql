/*Find how many 1-URGENT priority orders have been posted by 
customers from BRAZIL between 1994 and 1997, combined.*/

SELECT count(DISTINCT o_orderkey)
FROM orders
INNER JOIN customer, lineitem, nation
WHERE (o_orderpriority = '1-URGENT') AND (o_custkey = c_custkey) AND 
(c_nationkey = n_nationkey AND n_name = 'BRAZIL') AND 
(l_orderkey = o_orderkey) AND 
(o_orderdate > '1993-12-31' AND o_orderdate < '1998-01-01')
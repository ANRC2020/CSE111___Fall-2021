/*Find the number of distinct orders completed in 1995 by 
the suppliers in every nation. An order status of F stands 
for complete. Print only those nations for which the number 
of orders is larger than 50.*/

SELECT n_name, count(DISTINCT o_orderkey)
FROM orders, supplier, nation, lineitem
WHERE ((o_orderkey = l_orderkey) AND (l_suppkey = s_suppkey) 
    AND (SUBSTR(orders.o_orderdate,1,4) = '1995') AND (o_orderstatus = 'F')
    AND (s_nationkey = n_nationkey))
GROUP BY n_name
HAVING COUNT(DISTINCT o_orderkey) > 50
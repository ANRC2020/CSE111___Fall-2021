/*Count the number of orders made in the fourth quarter of
1997 in which at least one line item was received by a 
customer earlier than its commit date. List the count of 
such orders for every orderpriority.*/

SELECT o_orderpriority, COUNT(DISTINCT o_orderkey)
FROM orders, lineitem
WHERE ((SUBSTR(o_orderdate,1,7) >= '1997-10') 
    AND (SUBSTR(o_orderdate,1,7) < '1998-01')
    AND (o_orderkey = l_orderkey)
    AND (l_receiptdate < l_commitdate))
GROUP BY o_orderpriority

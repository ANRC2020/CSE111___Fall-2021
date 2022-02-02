/* Find the total number of line items on orders with priority
3-MEDIUM supplied by suppliers from CANADA. Groups these line 
items based on the year of the order fromoorderdate.  Print the year 
and the count. Check the substrfunction inSQLite.*/
SELECT SUBSTR(o_orderdate, 1, 4) AS Year, COUNT(*)
FROM orders, lineitem
INNER JOIN supplier, nation
ON ((o_orderpriority = '3-MEDIUM') AND 
(o_orderkey = l_orderkey AND l_suppkey = s_suppkey AND s_nationkey = n_nationkey AND n_name = 'CANADA'))
GROUP BY SUBSTR(o_orderdate, 1, 4)
/*Find the number of orders posted by every customer 
from GERMANY in 1993.*/
SELECT c_name, count(*)
FROM orders
INNER JOIN customer, nation
ON ((o_custkey = c_custkey) AND (c_nationkey = n_nationkey) 
AND (n_name = 'GERMANY') AND (SUBSTR(o_orderdate,1,4) = '1993'))
GROUP BY c_name
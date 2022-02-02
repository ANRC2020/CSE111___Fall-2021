/*How many parts with size below 20 does every supplier 
from CANADA offer? Print the name of the supplier and 
the number of parts.*/
SELECT s_name, count(p_partkey) 
FROM part
INNER JOIN supplier, nation, partsupp
ON ((s_nationkey = n_nationkey) AND (n_name = 'CANADA')
AND (p_partkey = ps_partkey) AND (ps_suppkey = s_suppkey)
AND (p_size < 20))
GROUP BY s_name
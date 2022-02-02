/*Based on the available quantity of items, who is the 
manufacturer p_mfgr of the most popular item (the more popular 
an item is, the less available it is in ps_availqty) 
from Supplier#000000010?*/

SELECT p_mfgr
FROM part, partsupp, supplier
WHERE ((p_partkey = ps_partkey) AND (ps_suppkey = s_suppkey)
    AND (s_name = 'Supplier#000000010'))
GROUP BY p_mfgr
HAVING MIN(ps_availqty)
ORDER BY MIN(ps_availqty)
LIMIT 1

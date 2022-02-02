/*Find the distinct parts (p_name) ordered by 
customers from AMERICA that are supplied by 
exactly 3 suppliers from ASIA.*/

SELECT DISTINCT p_name
FROM customer, nation, region, orders, lineitem, part
WHERE ((c_nationkey = n_nationkey)
    AND (n_regionkey = r_regionkey)
    AND (r_name = 'AMERICA')
    AND (c_custkey = o_custkey)
    AND (o_orderkey = l_orderkey)
    AND (l_partkey = p_partkey))
GROUP BY p_name
INTERSECT
SELECT p_name
FROM supplier, lineitem, part, nation, region
WHERE ((s_nationkey = n_nationkey)
    AND (n_regionkey = r_regionkey)
    AND (r_name = 'ASIA')
    AND (s_suppkey = l_suppkey)
    AND (l_partkey = p_partkey))
GROUP BY p_partkey
HAVING COUNT(s_name) = 3
ORDER BY p_name

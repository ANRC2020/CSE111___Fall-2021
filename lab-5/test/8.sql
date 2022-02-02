/*Count the number of distinct suppliers that supply parts 
whose type contains POLISHED and have size equal to any of 3, 
23, 36, and 49.*/

SELECT COUNT(DISTINCT s_name)
FROM part, partsupp, supplier
WHERE ((p_type like '%POLISHED%') 
    AND (p_partkey = ps_partkey)
    AND (s_suppkey = ps_suppkey)
    AND (p_size = 3 OR p_size = 23 OR p_size = 36 OR p_size = 49))
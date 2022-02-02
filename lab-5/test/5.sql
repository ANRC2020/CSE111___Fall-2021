/* For parts whose type contains STEEL, return the name of 
the supplier from ASIA that can supply them at minimum cost 
(pssupplycost), for every part size. Print the supplier name 
together with the partsize and the minimum cost.*/

SELECT s_name, p_size, MIN(ps_supplycost)
FROM part, partsupp, supplier, nation, region
WHERE ((p_type like '%STEEL%') AND (p_partkey = ps_partkey) 
    AND (ps_suppkey = s_suppkey) AND (s_nationkey = n_nationkey)
    AND (n_regionkey = r_regionkey) AND (r_name = 'ASIA'))
GROUP BY p_size
Order BY s_name

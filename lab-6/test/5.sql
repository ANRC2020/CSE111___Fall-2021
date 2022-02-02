/*Find how many suppliers supply the most 
expensive part (pretailprice).*/

SELECT COUNT(s_name)
FROM (SELECT MAX(p_retailprice) as prt, p_partkey as ptk
    FROM part) as t1, partsupp, supplier
WHERE ((t1.ptk = ps_partkey)
    AND (ps_suppkey = s_suppkey))

/*Find how many suppliers from UNITED STATES 
supply more than 40 different parts.*/

SELECT COUNT(t1.sn)
FROM (SELECT s_name as sn, COUNT(p_partkey)
    FROM supplier, partsupp, part, nation
    WHERE ((s_suppkey = ps_suppkey)
        AND (ps_partkey = p_partkey)
        AND (s_nationkey = n_nationkey)
        AND (n_name = 'UNITED STATES'))
    GROUP BY s_name) as t1


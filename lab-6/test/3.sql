/*Find how many parts are supplied by exactly 
two suppliers from UNITED STATES.*/

SELECT COUNT(t1.pn)
FROM (SELECT p_name as pn
    FROM part, partsupp, supplier, nation
    WHERE ((p_partkey = ps_partkey)
        AND (ps_suppkey = s_suppkey)
        AND (s_nationkey = n_nationkey)
        AND (n_name = 'UNITED STATES'))
    GROUP BY p_name
    HAVING COUNT(s_name) = 2) as t1

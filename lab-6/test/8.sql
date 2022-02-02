/*Find how many distinct customers have at least 
one order supplied exclusively by suppliers from
AMERICA.*/

SELECT COUNT(t3.cck)
FROM (SELECT c_custkey as cck
    FROM (SELECT t1.lok as lok, t1.rn as rn
        FROM (SELECT DISTINCT r_name as rn, l_orderkey as lok
            FROM lineitem, supplier, nation, region
            WHERE ((l_suppkey = s_suppkey)
                AND (s_nationkey = n_nationkey)
                AND (n_regionkey = r_regionkey))
            ORDER BY l_orderkey) as t1
        GROUP BY t1.lok 
        HAVING COUNT(t1.lok) = 1) as t2, orders, customer
    WHERE ((t2.rn = 'AMERICA')
        AND (t2.lok = o_orderkey)
        AND (o_custkey = c_custkey))
    GROUP BY c_custkey) as t3

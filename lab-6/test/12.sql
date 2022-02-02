/*Find the nation(s) having customers that 
spend the smallest amount of money (o_totalprice).*/

SELECT t3.nn
FROM (SELECT MIN(t1.tp) as mintp
    FROM (SELECT n_name, SUM(o_totalprice) as tp
        FROM nation, customer, orders
        WHERE ((n_nationkey = c_nationkey)
            AND (c_custkey = o_custkey))
        GROUP BY n_name
        ORDER BY SUM(o_totalprice)) as t1) as t2,
    (SELECT n_name as nn, SUM(o_totalprice) as tp
    FROM nation, customer, orders
    WHERE ((n_nationkey = c_nationkey)
        AND (c_custkey = o_custkey))
    GROUP BY n_name
    ORDER BY SUM(o_totalprice)) as t3
WHERE (t3.tp = t2.mintp)

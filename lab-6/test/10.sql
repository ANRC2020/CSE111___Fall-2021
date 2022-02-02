/*Find the region where customers spend the 
smallest amount of money (l_extendedprice) 
buying items from suppliers in the same region.*/

SELECT r_name
FROM (SELECT t2.rrk as rk, SUM(l_extendedprice) as pr
    FROM (SELECT s_suppkey as ssk, r_regionkey as rrk
        FROM supplier, nation, region
        WHERE ((s_nationkey = n_nationkey)
            AND (n_regionkey = r_regionkey))) as t1,
        (SELECT c_custkey as cck, r_regionkey as rrk
        FROM customer, nation, region
        WHERE ((c_nationkey = n_nationkey)
            AND (n_regionkey = r_regionkey))) as t2, 
        lineitem, orders
    WHERE ((t1.rrk = t2.rrk)
        AND (l_suppkey = t1.ssk)
        AND (l_orderkey = o_orderkey)
        AND (o_custkey = t2.cck))
    GROUP BY t2.rrk) as t3, region
WHERE ((t3.rk = r_regionkey))
ORDER BY (t3.pr)
LIMIT 1
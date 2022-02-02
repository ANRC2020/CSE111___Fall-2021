/*Find how many suppliers have less than
50 distinct orders from customers in GERMANY 
and FRANCE together.*/

SELECT COUNT(t1.sn)
FROM (SELECT s_name as sn, COUNT(DISTINCT o_orderkey)
    FROM supplier, lineitem, orders, customer, nation
    WHERE ((s_suppkey = l_suppkey)
        AND (l_orderkey = o_orderkey)
        AND (o_custkey = c_custkey)
        AND (c_nationkey = n_nationkey)
        AND (n_name = 'GERMANY' OR n_name = 'FRANCE'))
    GROUP BY s_name
    HAVING COUNT(DISTINCT o_orderkey) < 50) as t1

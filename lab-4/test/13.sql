/*How many line items are supplied by suppliers in AFRICA for 
orders made by customers in UNITEDSTATES?*/

SELECT count(l_partkey)
FROM (SELECT DISTINCT s_suppkey
    FROM supplier, nation, region
    WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)
        AND (r_name = 'AFRICA'))) as t1,
    (SELECT DISTINCT c_custkey
    FROM customer, nation, region
    WHERE ((c_nationkey = n_nationkey) AND (n_name = 'UNITED STATES'))) as t2, 
    lineitem, orders
WHERE ((l_orderkey = o_orderkey) 
    AND (l_suppkey = t1.s_suppkey AND o_custkey = t2.c_custkey))

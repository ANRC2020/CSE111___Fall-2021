/*List the maximum total price of an order between any two 
regions, i.e., the suppliers are from one region and the 
customers are from the other region.*/

-- SELECT t2.r_name as supplier_region, t1.r_name as customer_region
SELECT t1.r_name, t2.r_name, MAX(o_totalprice)
FROM (SELECT r_name, s_name, s_suppkey
    FROM supplier, nation, region
    WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
    ORDER BY r_name) as t1, 
    (SELECT r_name, c_name, c_custkey
    FROM customer, nation, region
    WHERE ((c_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
    ORDER BY r_name) as t2, lineitem, orders
WHERE ((l_orderkey = o_orderkey) AND (l_suppkey = t1.s_suppkey)
    AND (o_custkey = t2.c_custkey))
GROUP BY t1.r_name, t2.r_name

-- CODE FOR T1
-- SELECT r_name, c_name, c_custkey
-- FROM customer, nation, region
-- WHERE ((c_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
-- ORDER BY r_name
-- -- CODE FOR T2
-- SELECT r_name, s_name, s_suppkey
-- FROM supplier, nation, region 
-- WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
-- ORDER BY r_name
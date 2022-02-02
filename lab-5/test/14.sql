/*For any two regions, find the gross discounted revenue 
(lextendedprice*(1-ldiscount)) derived from line items in  
which parts are shipped from a supplier in the first region
to a customer in the second region in 1996 and 1997. List 
the supplier region, the customer region, the year 
(lshipdate), and the revenue from shipments that took place 
in that year.*/

SELECT t2.rn, t1.rn, SUBSTR(l_shipdate,1,4), SUM((l_extendedprice * (1 - l_discount)))
FROM (SELECT DISTINCT c_custkey as ck, r_name as rn
    FROM customer, nation, region
    WHERE ((c_nationkey = n_nationkey)
        AND (n_regionkey = r_regionkey))) as t1,
    (SELECT DISTINCT s_suppkey as sk, r_name as rn
    FROM supplier, nation, region
    WHERE ((s_nationkey = n_nationkey)
        AND (n_regionkey = r_regionkey))) as t2,
    (SELECT *
    FROM lineitem
    WHERE ((SUBSTR(l_shipdate,1,4) = '1996' 
        OR SUBSTR(l_shipdate,1,4) = '1997'))) as t3, orders
WHERE ((t3.l_suppkey = t2.sk) 
    AND (t3.l_orderkey = o_orderkey)
    AND (o_custkey = t1.ck))
GROUP BY t2.rn, t1.rn, SUBSTR(l_shipdate,1,4)

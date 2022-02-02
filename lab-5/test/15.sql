/*The market share for a given nation within a given region 
is defined as the fraction of the revenue from the line 
items ordered by customers in the given region that are 
supplied by suppliers from the given nation. The revenue 
of a lineitem is defined as l_extendedprice*(1-l_discount). 
Determine the market share of UNITED STATES in ASIA in 
1997 (l_shipdate).*/

-- Market Share = revenue(ordered by: ASIA, supplied by: United States)
-- Revenue = l_extendedprice*(1-l_discount)

-- Find the total revenue between ASIA and all nations
-- SELECT SUM(l_extendedprice * (1 - l_discount))
-- FROM (SELECT c_custkey as ck, r_regionkey as rk, r_name as rn
--     FROM customer, nation, region
--     WHERE ((c_nationkey = n_nationkey)
--         AND (n_regionkey = r_regionkey)
--         AND (r_name = 'ASIA'))) as t1,
--     (SELECT s_suppkey as sk, n_nationkey as nk, n_name as nn
--     FROM supplier, nation
--     WHERE ((s_nationkey = n_nationkey))) as t2,
--     lineitem, orders
-- WHERE ((l_orderkey = o_orderkey)
--     AND (o_custkey = t1.ck)
--     AND (l_suppkey = t2.sk))

-- Find the total revenue between ASIA and UNITED STATES
-- SELECT SUM(l_extendedprice * (1 - l_discount))
-- FROM (SELECT c_custkey as ck, r_regionkey as rk, r_name as rn
--     FROM customer, nation, region
--     WHERE ((c_nationkey = n_nationkey)
--         AND (n_regionkey = r_regionkey)
--         AND (r_name = 'ASIA'))) as t1,
--     (SELECT s_suppkey as sk, n_nationkey as nk, n_name as nn
--     FROM supplier, nation
--     WHERE ((s_nationkey = n_nationkey))) as t2,
--     lineitem, orders
-- WHERE ((l_orderkey = o_orderkey)
--     AND (o_custkey = t1.ck)
--     AND (l_suppkey = t2.sk)
--     AND (t2.nn = 'UNITED STATES'))

-- COMBINE
SELECT (t4.UStotalrev/t3.totalrev)
FROM (SELECT SUM(l_extendedprice * (1 - l_discount)) as totalrev
    FROM (SELECT c_custkey as ck, r_regionkey as rk, r_name as rn
        FROM customer, nation, region
        WHERE ((c_nationkey = n_nationkey)
            AND (n_regionkey = r_regionkey)
            AND (r_name = 'ASIA'))) as t1,
        (SELECT s_suppkey as sk, n_nationkey as nk, n_name as nn
        FROM supplier, nation
        WHERE ((s_nationkey = n_nationkey))) as t2,
        lineitem, orders
    WHERE ((l_orderkey = o_orderkey)
        AND (o_custkey = t1.ck)
        AND (l_suppkey = t2.sk)
        AND (SUBSTR(l_shipdate,1,4) = '1997'))) as t3,
    (SELECT SUM(l_extendedprice * (1 - l_discount)) as UStotalrev
    FROM (SELECT c_custkey as ck, r_regionkey as rk, r_name as rn
        FROM customer, nation, region
        WHERE ((c_nationkey = n_nationkey)
            AND (n_regionkey = r_regionkey)
            AND (r_name = 'ASIA'))) as t1,
        (SELECT s_suppkey as sk, n_nationkey as nk, n_name as nn
        FROM supplier, nation
        WHERE ((s_nationkey = n_nationkey))) as t2,
        lineitem, orders
    WHERE ((l_orderkey = o_orderkey)
        AND (o_custkey = t1.ck)
        AND (l_suppkey = t2.sk)
        AND (t2.nn = 'UNITED STATES')
        AND (SUBSTR(l_shipdate,1,4) = '1997'))) as t4

-- SELECT c_custkey, n_nationkey
-- FROM customer, nation, region
-- WHERE ((c_nationkey = n_nationkey)
--     AND (n_regionkey = r_regionkey)
--     AND (r_name = 'ASIA'))

-- SELECT s_suppkey, n_nationkey
-- FROM supplier, nation
-- WHERE ((s_nationkey = n_nationkey))

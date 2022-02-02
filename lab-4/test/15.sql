/*How many distinct orders are between customers with positive 
account balance and suppliers with negative account balance?*/

SELECT count(DISTINCT o_orderkey)
FROM (SELECT s_name, s_suppkey
    FROM supplier
    WHERE (s_acctbal < 0)) as t1, 
    (SELECT c_name, c_custkey
    FROM customer
    WHERE (c_acctbal > 0)) as t2, orders, lineitem
WHERE ((o_orderkey = l_orderkey) AND (o_custkey = t2.c_custkey)
    AND (l_suppkey = t1.s_suppkey))

-- -- suppliers with neg. account balances
-- SELECT s_name
-- FROM supplier
-- WHERE (s_acctbal < 0)
-- -- customers with pos. account balances
-- SELECT c_name
-- FROM customer
-- WHERE (c_acctbal > 0)

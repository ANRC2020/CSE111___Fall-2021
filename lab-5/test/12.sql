/* What is the total supply cost (ps_supplycost) for parts 
less expensive than $1000 (p_retailprice) shipped in 1997
(l_shipdate) by suppliers who did not supply any line item 
with an extended price less than 2000 in 1996?*/

SELECT SUM(ps_supplycost)
-- SELECT t1.spk, l_shipdate, p_retailprice, l_shipdate
FROM partsupp, lineitem, part, supplier,
    (SELECT DISTINCT s_suppkey as spk
    FROM supplier, lineitem
    WHERE ((s_suppkey = l_suppkey)
        AND (SUBSTR(l_shipdate,1,4) = '1996')
        AND (s_suppkey NOT IN (
            SELECT s_suppkey
            FROM supplier, lineitem
            WHERE ((s_suppkey = l_suppkey)
            AND (l_extendedprice < 2000)
            AND (SUBSTR(l_shipdate,1,4) = '1996')))))) as t1
WHERE ((t1.spk = s_suppkey)
    AND (s_suppkey = ps_suppkey)
    AND (ps_partkey = p_partkey)
    AND (SUBSTR(l_shipdate,1,4) = '1997')
    AND (l_partkey = ps_partkey)
    AND (p_retailprice < 1000))

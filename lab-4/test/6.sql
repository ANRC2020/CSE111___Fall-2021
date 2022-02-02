/*How many unique parts produced by every supplier in CANADA 
are ordered at every priority? Print the supplier name, the 
order priority, and the number of parts.*/

SELECT s_name, o_orderpriority, count(DISTINCT l_partkey)
FROM supplier, nation, lineitem, orders
WHERE (s_nationkey = n_nationkey) AND (n_name = 'CANADA') AND
    (s_suppkey = l_suppkey) AND (l_orderkey = o_orderkey)
GROUP BY s_name, o_orderpriority;
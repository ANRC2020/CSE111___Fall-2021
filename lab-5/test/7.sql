/*For every order priority, count the number of parts ordered 
in 1997 and received later (lreceiptdate) than the commit date
(lcommitdate).*/

SELECT o_orderpriority, COUNT(o_orderkey)
FROM orders, lineitem
WHERE ((SUBSTR(o_orderdate,1,4) = '1997') 
    AND (o_orderkey = l_orderkey)
    AND (l_receiptdate > l_commitdate))
GROUP BY o_orderpriority
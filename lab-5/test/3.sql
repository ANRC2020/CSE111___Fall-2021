/*For the line items ordered in October 1996 (o_orderdate), 
find the smallest discount that is larger than the average 
discount among all the orders.*/

SELECT l_discount
FROM (SELECT AVG(l_discount) as avgdis
    FROM lineitem, orders
    WHERE ((SUBSTR(o_orderdate, 1, 7) = '1996-10') 
        AND (o_orderkey = l_orderkey))) as t1, lineitem, orders
WHERE ((SUBSTR(o_orderdate, 1, 7) = '1996-10') 
    AND (o_orderkey = l_orderkey) AND (l_discount > t1.avgdis))
ORDER BY l_discount
LIMIT 1;

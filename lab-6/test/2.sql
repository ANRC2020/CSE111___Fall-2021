/*Find the number of customers who had at 
least three orders in November 1995 (o_orderdate).*/

SELECT COUNT(t1.cus)
FROM (SELECT c_name as cus, COUNT(o_orderkey)
    FROM customer, orders
    WHERE ((c_custkey = o_custkey)
        AND (SUBSTR(o_orderdate,1,7) = '1995-11'))
    GROUP BY c_name
    HAVING COUNT(o_orderkey) >= 3) as t1
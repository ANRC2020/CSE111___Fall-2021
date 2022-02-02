/*Compute, for every country, the value of economic 
exchange, i.e., the difference between the number 
of items from suppliers in that country sold to 
customers in other countries and the number of 
items bought by local customers from foreign suppliers 
in 1994 (lshipdate).*/

SELECT t1.nn, (t1.sold - t2.bought)
FROM (SELECT n_name as nn, COUNT(l_quantity) as sold
    FROM supplier, nation, lineitem
    WHERE ((s_nationkey = n_nationkey)
        AND (s_suppkey = l_suppkey)
        AND (SUBSTR(l_shipdate,1,4) = '1994'))
    GROUP BY n_name) as t1,
    (SELECT n_name as nn, COUNT(l_quantity) as bought
    FROM customer, nation, orders, lineitem
    WHERE ((c_nationkey = n_nationkey)
        AND (c_custkey = o_custkey)
        AND (o_orderkey = l_orderkey)
        AND (SUBSTR(l_shipdate,1,4) = '1994'))
    GROUP BY n_name) as t2
WHERE (t1.nn = t2.nn)
GROUP BY t1.nn
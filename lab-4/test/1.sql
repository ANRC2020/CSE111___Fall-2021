/* Find the total price paid on orders by every customer from
FRANCE in 1995. Print the customer name and the total price.*/
SELECT DISTINCT c_name, SUM(o_totalprice)
FROM customer
INNER JOIN orders
ON ((SUBSTR(o_orderdate,1,4) = '1995') AND (o_custkey = c_custkey)) 
INNER JOIN nation
WHERE ((c_nationkey = n_nationkey) AND (n_name = 'FRANCE'))
GROUP BY c_name
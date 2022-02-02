/*Find the number of orders having status F. Group these orders based 
on the region of the customer who posted the order.  Print the region 
name and the number of status F orders.*/
SELECT r_name, count(c_custkey)
FROM customer
INNER JOIN region
ON (n_regionkey = r_regionkey)
INNER JOIN nation
ON (c_nationkey = n_nationkey)
INNER JOIN orders
ON (o_orderstatus = 'F' AND o_custkey = c_custkey)
GROUP BY r_name
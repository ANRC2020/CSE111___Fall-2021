/*How many orders do customers in every nation in AMERICA 
have in every status? Print the nationname, the order status, 
and the count.*/

SELECT n_name, o_orderstatus, COUNT(o_custkey)
FROM customer, nation, region, orders
WHERE ((c_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)
    AND (r_name = 'AMERICA') AND (c_custkey = o_custkey))
GROUP BY n_name, o_orderstatus

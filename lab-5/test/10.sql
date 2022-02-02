/* How many customers from every region 
have never placed an order and have less 
than the average account balance?*/

SELECT r_name, COUNT(DISTINCT c_custkey)
FROM customer, nation, region, orders, 
    (SELECT AVG(c_acctbal) as avgbal
    FROM customer) as t1
WHERE ((c_nationkey = n_nationkey)
    AND (n_regionkey = r_regionkey)
    AND (c_custkey NOT IN 
        (SELECT c_custkey
        FROM customer, orders
        WHERE (c_custkey = o_custkey)       
        ))
    AND (c_acctbal < t1.avgbal))
GROUP BY r_name

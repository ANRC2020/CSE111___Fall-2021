/* Find the total price o_totalprice of orders made 
by customers from AMERICA in 1996.*/
SELECT sum(o_totalprice)
FROM orders, customer, nation
WHERE ((o_orderdate >= '1996-01-01' AND 
o_orderdate < '1997-01-01') AND ((o_custkey = c_custkey) AND 
(c_nationkey = n_nationkey)) AND (n_name = 'UNITED STATES' OR n_name = 'PERU' OR n_name = 'CANADA' OR n_name = 'BRAZIL' OR n_name = 'ARGENTINA'))

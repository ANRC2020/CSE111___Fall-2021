/*Find the supplier-customer pair(s) with the 
least expensive (o_totalprice) order(s) completed 
(F in o_orderstatus). Print the supplier name, the 
customer name, and the total price.*/

SELECT s_name, c_name, MIN(o_totalprice)
FROM customer, supplier, orders, lineitem
WHERE ((c_custkey = o_custkey)
    AND (o_orderkey = l_orderkey)
    AND (l_suppkey = s_suppkey)
    AND (o_orderstatus = 'F'))

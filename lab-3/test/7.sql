/*How many line items with lreceiptdate in 1993 did 
Customer#000000010 order? Print the number of 
ordered line items corresponding to every month.*/
SELECT SUBSTR(l_receiptdate, 1,7) AS Month, count(*)
-- SELECT *
FROM customer
INNER JOIN orders
ON ('10' = c_custkey AND c_custkey = o_custkey)
INNER JOIN lineitem
ON (l_orderkey = o_orderkey AND ('1993-01-01' <= l_receiptdate 
AND l_receiptdate < '1994-01-01'))
GROUP BY SUBSTR(l_receiptdate, 6,2)
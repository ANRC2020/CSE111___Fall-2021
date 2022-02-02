/* Find the total quantity (lquantity) of line items 
shipped per month (lshipdate) in 1995. Hint: check function
strftime to extract the month/year from a date.*/

SELECT strftime('%m', l_shipdate), SUM(l_quantity)
FROM lineitem
WHERE (SUBSTR(l_shipdate, 1, 4) = '1995')
GROUP BY strftime('%m', l_shipdate)

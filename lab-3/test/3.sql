/*Find all the line items with the return flag set 
to R on the receipt date of August 22, 1993. Print l_receiptdate, 
l_returnflag, l_extendedprice, and l_tax for every line item.*/
SELECT l_receiptdate, l_returnflag, l_extendedprice, l_tax
FROM lineitem
WHERE (l_receiptdate = '1993-08-22' AND l_returnflag = 'R')
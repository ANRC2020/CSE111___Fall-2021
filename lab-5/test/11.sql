/*Find the lowest value line item(s) 
(lextendedprice*(1-ldiscount)) shipped after October 2,1996.
Print the name of the part corresponding to these line item(s).*/

SELECT t1.p_name
FROM (SELECT p_name, MIN(l_extendedprice * (1 - l_discount))
    FROM lineitem, part 
    WHERE ((l_partkey = p_partkey)
        AND (l_shipdate > '1996-10-02'))) as t1

/*Find the minimum and maximum discount for every part having 
ECONOMY and COPPER in its type.*/

SELECT DISTINCT p_type, MIN(l_discount), MAX(l_discount)
FROM part, lineitem
WHERE ((p_type LIKE '%COPPER%' AND p_type LIKE '%ECONOMY%') 
    AND (p_partkey = l_partkey))
GROUP BY p_type
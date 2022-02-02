/*Find the maximum account balance of the suppliers 
from nations with more than 5 suppliers. Print the 
nation name, the number of suppliers from that nation, 
and the maximum account balance.*/

SELECT n_name, count(*), max(s_acctbal)
FROM supplier, nation
WHERE n_nationkey = s_nationkey
GROUP BY s_nationkey
HAVING count(*) > 5

/*
    - First Identify the nations with 5+ suppliers
    - Then find the suppliers to those nations with the highest account balances 
*/
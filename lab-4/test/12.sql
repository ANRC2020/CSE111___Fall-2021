/*What is the maximum account balance for the suppliers in 
every nation? Print only those nations forwhich the maximum 
balance is larger than 9000.*/

SELECT n_name, MAX(s_acctbal)
FROM supplier, nation
WHERE ((s_nationkey = n_nationkey))
GROUP BY n_name
HAVING MAX(s_acctbal) > 9000
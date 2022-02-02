/*Find the supplier with the largest account balance in every 
region. Print the region name, the suppliername, and the 
account balance.*/

SELECT r_name, s_name, MAX(s_acctbal)
FROM supplier, nation, region
WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
GROUP BY r_name
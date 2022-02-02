/*How many suppliers in every region have less balance in 
their account than the average account balance of their own 
region?*/

SELECT r_name, COUNT(s_name)
FROM (SELECT r_name as r1, AVG(s_acctbal) as avgacct
    FROM supplier, nation, region
    WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
    GROUP BY r_name) as t1, supplier, nation, region
WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)
    AND (r_name = t1.r1) AND (s_acctbal < t1.avgacct))
GROUP BY r_name;
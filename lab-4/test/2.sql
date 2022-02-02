/*Find the number of suppliers from every region.*/
SELECT DISTINCT r_name, count(s_name)
FROM supplier
INNER JOIN nation, region
ON ((s_nationkey = n_nationkey) AND 
(n_regionkey = r_regionkey))
GROUP BY r_name
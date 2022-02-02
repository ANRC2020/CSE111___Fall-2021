/*Find the name of the suppliers from AMERICA who have more than
$5000 on account balance. Print the supplier name and their 
account balance.*/
SELECT s_name, s_acctbal
FROM supplier
INNER JOIN nation
ON ((s_acctbal > 5000) AND (s_nationkey = n_nationkey) AND 
(n_name = 'UNITED STATES' OR n_name = 'PERU' OR n_name = 'CANADA' OR n_name = 'BRAZIL' OR n_name = 'ARGENTINA'))
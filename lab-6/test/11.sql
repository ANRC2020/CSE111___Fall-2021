/*Find the nation(s) with the smallest number of 
customers.*/

SELECT t3.nn3
FROM (SELECT MIN(t1.ct) as min
    FROM (SELECT n_name as nn, COUNT(c_name) as ct
        FROM nation, customer
        WHERE (n_nationkey = c_nationkey)
        GROUP BY n_name
        ORDER BY COUNT(c_name)) as t1) as t2,
    (SELECT t1.nn as nn3, t1.ct as ct3
    FROM (SELECT n_name as nn, COUNT(c_name) as ct
        FROM nation, customer
        WHERE (n_nationkey = c_nationkey)
        GROUP BY n_name
        ORDER BY COUNT(c_name)) as t1) as t3
WHERE (t3.ct3 = t2.min)

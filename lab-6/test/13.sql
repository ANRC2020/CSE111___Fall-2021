/*Find the nation(s) with the most developed 
industry, i.e., selling items totaling the 
largest amount of money (lextendedprice) in
1994 (lshipdate).*/

SELECT t3.nn
FROM (SELECT MAX(t1.etp) as maxsales
    FROM (SELECT n_name as nn, SUM(l_extendedprice) as etp
        FROM supplier, nation, lineitem
        WHERE ((s_nationkey = n_nationkey)
            AND (s_suppkey = l_suppkey)
            AND (SUBSTR(l_shipdate,1,4) = '1994'))
        GROUP BY n_name
        ORDER BY SUM(l_extendedprice) DESC) as t1) as t2,
    (SELECT n_name as nn, SUM(l_extendedprice) as etp
    FROM supplier, nation, lineitem
    WHERE ((s_nationkey = n_nationkey)
        AND (s_suppkey = l_suppkey)
        AND (SUBSTR(l_shipdate,1,4) = '1994'))
    GROUP BY n_name
    ORDER BY SUM(l_extendedprice) DESC) as t3
WHERE (t3.etp = t2.maxsales)

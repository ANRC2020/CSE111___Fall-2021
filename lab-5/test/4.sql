/*How many customers and suppliers are in every country from
AFRICA?*/

SELECT t3.n_name, t1.num_cust, t2.num_supp
FROM (SELECT n_name, COUNT(c_name) as num_cust
    FROM customer, nation, region
    WHERE ((c_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)
        AND (r_name = 'AFRICA'))
    GROUP BY n_name) as t1,
    (SELECT n_name, COUNT(s_name) as num_supp
    FROM supplier, nation, region
    WHERE ((s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)
        AND (r_name = 'AFRICA'))
    GROUP BY n_name) as t2,
    (SELECT n_name
    FROM nation, region
    WHERE ((n_regionkey = r_regionkey) AND (r_name = 'AFRICA'))
    GROUP BY n_name) as t3
WHERE ((t3.n_name = t2.n_name AND t3.n_name = t1.n_name))
GROUP BY t3.n_name

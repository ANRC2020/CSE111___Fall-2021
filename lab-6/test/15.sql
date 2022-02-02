/*Compute the change in the economic exchange for every 
country between 1994 and 1996. There should be two columns 
in the output for every country: 1995 and 1996. Hint: use
CASE to select the values in the result.*/

-- SELECT DISTINCT t3.nn
-- FROM (SELECT t1.nn as nn, (t1.sold - t2.bought) as ec, t1.lsd as date
--     FROM (SELECT n_name as nn, COUNT(l_quantity) as sold, SUBSTR(l_shipdate,1,4) as lsd
--         FROM supplier, nation, lineitem
--         WHERE ((s_nationkey = n_nationkey)
--             AND (s_suppkey = l_suppk
--             ey))
--         GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t1,
--         (SELECT n_name as nn, COUNT(l_quantity) as bought, SUBSTR(l_shipdate,1,4) as lsd
--         FROM customer, nation, orders, lineitem
--         WHERE ((c_nationkey = n_nationkey)
--             AND (c_custkey = o_custkey)
--             AND (o_orderkey = l_orderkey))
--         GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t2
--     WHERE ((t1.lsd = t2.lsd)
--         AND (t1.nn = t2.nn))
--     GROUP BY t1.nn, t1.lsd) as t3


SELECT DISTINCT t3.nn, (t4.ec - t3.ec), (t5.ec - t4.ec)
FROM (SELECT t1.nn as nn, (t1.sold - t2.bought) as ec, t1.lsd as date
    FROM (SELECT n_name as nn, COUNT(l_quantity) as sold, SUBSTR(l_shipdate,1,4) as lsd
        FROM supplier, nation, lineitem
        WHERE ((s_nationkey = n_nationkey)
            AND (s_suppkey = l_suppkey))
        GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t1,
        (SELECT n_name as nn, COUNT(l_quantity) as bought, SUBSTR(l_shipdate,1,4) as lsd
        FROM customer, nation, orders, lineitem
        WHERE ((c_nationkey = n_nationkey)
            AND (c_custkey = o_custkey)
            AND (o_orderkey = l_orderkey))
        GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t2
    WHERE ((t1.lsd = t2.lsd)
        AND (t1.nn = t2.nn)
        AND (t1.lsd = '1994'))
    GROUP BY t1.nn, t1.lsd) as t3,
    (SELECT t1.nn as nn, (t1.sold - t2.bought) as ec, t1.lsd as date
    FROM (SELECT n_name as nn, COUNT(l_quantity) as sold, SUBSTR(l_shipdate,1,4) as lsd
        FROM supplier, nation, lineitem
        WHERE ((s_nationkey = n_nationkey)
            AND (s_suppkey = l_suppkey))
        GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t1,
        (SELECT n_name as nn, COUNT(l_quantity) as bought, SUBSTR(l_shipdate,1,4) as lsd
        FROM customer, nation, orders, lineitem
        WHERE ((c_nationkey = n_nationkey)
            AND (c_custkey = o_custkey)
            AND (o_orderkey = l_orderkey))
        GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t2
    WHERE ((t1.lsd = t2.lsd)
        AND (t1.nn = t2.nn)
        AND (t1.lsd = '1995'))
    GROUP BY t1.nn, t1.lsd) as t4,
    (SELECT t1.nn as nn, (t1.sold - t2.bought) as ec, t1.lsd as date
    FROM (SELECT n_name as nn, COUNT(l_quantity) as sold, SUBSTR(l_shipdate,1,4) as lsd
        FROM supplier, nation, lineitem
        WHERE ((s_nationkey = n_nationkey)
            AND (s_suppkey = l_suppkey))
        GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t1,
        (SELECT n_name as nn, COUNT(l_quantity) as bought, SUBSTR(l_shipdate,1,4) as lsd
        FROM customer, nation, orders, lineitem
        WHERE ((c_nationkey = n_nationkey)
            AND (c_custkey = o_custkey)
            AND (o_orderkey = l_orderkey))
        GROUP BY n_name, SUBSTR(l_shipdate,1,4)) as t2
    WHERE ((t1.lsd = t2.lsd)
        AND (t1.nn = t2.nn)
        AND (t1.lsd = '1996'))
    GROUP BY t1.nn, t1.lsd) as t5
WHERE ((t3.nn = t4.nn)
    AND (t4.nn = t5.nn))

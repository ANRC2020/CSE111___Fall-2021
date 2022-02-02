/*Print the name of the parts supplied by suppliers from 
UNITED STATES that have total value in the top 1% total 
values across all the supplied parts. The total value 
is pssupplycost*psavailqty. Hint: Use the LIMIT keyword.*/

SELECT t1.pn
FROM (SELECT ps_availqty * ps_supplycost as pop, p_partkey as ptk, p_name as pn, n_nationkey as nnk
    FROM partsupp, part, supplier, nation 
    WHERE ((ps_partkey = p_partkey)
        AND (ps_suppkey = s_suppkey)
        AND (s_nationkey = n_nationkey))
    ORDER BY ps_availqty * ps_supplycost DESC
    LIMIT (SELECT COUNT(*) * 0.01 FROM partsupp)) as t1, nation
WHERE ((t1.nnk = n_nationkey)
    AND (n_name = 'UNITED STATES'))
ORDER BY t1.pop DESC

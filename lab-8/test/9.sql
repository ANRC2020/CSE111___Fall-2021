.eqp on
-- CREATE INDEX supplier_idx_s_nationkey_s_acctbal ON supplier(s_nationkey);
-- CREATE INDEX nation_idx_n_name ON nation(n_name);

select n_name, count(*) as cnt, max(s_acctbal)
from supplier, nation 
where s_nationkey = n_nationkey
group by n_name
having cnt > 5;

-- DROP INDEX supplier_idx_s_nationkey_s_acctbal;
-- DROP INDEX nation_idx_n_name;
.eqp on
-- CREATE INDEX customer_idx_c_custkey_c_nationkey ON customer(c_custkey, c_nationkey);
-- CREATE INDEX nation_idx_n_name ON nation(n_name, n_nationkey);
-- CREATE INDEX orders_idx_o_orderpriority_o_orderdate ON orders(o_orderpriority, o_orderdate);

select count(o_orderkey)
from orders, customer, nation
where c_custkey=o_custkey
    and c_nationkey=n_nationkey
    and n_name='BRAZIL'
    and o_orderpriority='1-URGENT'
    and o_orderdate >= '1994-01-01' and o_orderdate <= '1997-12-31';

-- DROP INDEX customer_idx_c_custkey_c_nationkey;
-- DROP INDEX nation_idx_n_name;
-- DROP INDEX orders_idx_o_orderpriority_o_orderdate;
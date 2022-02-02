.eqp on
-- CREATE INDEX lineitem_idx_l_orderkey_l_suppkey ON lineitem(l_orderkey, l_suppkey);
-- CREATE INDEX supplier_idx_s_nationkey_s_suppkey ON supplier(s_nationkey, s_suppkey);
-- CREATE INDEX nation_idx_n_name ON nation(n_name);
-- CREATE INDEX orders_idx_o_orderpriority_o_orderkey ON orders(o_orderpriority, o_orderkey);

select substr(o_orderdate, 1, 4) as year, count(*)
from orders, nation, supplier, lineitem
where l_orderkey = o_orderkey
    and l_suppkey = s_suppkey
    and n_nationkey = s_nationkey
    and o_orderpriority='3-MEDIUM'
    and n_name = 'CANADA'
group by year;

-- DROP INDEX lineitem_idx_l_orderkey_l_suppkey;
-- DROP INDEX supplier_idx_s_nationkey_s_suppkey;
-- DROP INDEX nation_idx_n_name;
-- DROP INDEX orders_idx_o_orderpriority_o_orderkey;
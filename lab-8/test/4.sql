.eqp on
-- CREATE INDEX lineitem_idx_l_shipdate_l_commitdate ON lineitem(l_shipdate,l_commitdate); --Not needed

select count(*) from lineitem where l_shipdate < l_commitdate;

-- DROP INDEX lineitem_idx_l_shipdate_l_commitdate;
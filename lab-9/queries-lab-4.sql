-- SQLite

--1
select c_name, sum(o_totalprice)
from orders, customer, nation
where o_custkey = c_custkey and
	n_nationkey = c_nationkey and
	n_name = 'FRANCE' AND
	o_orderdate like '1995-__-__'
group by c_name;

--2

-- CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
--     SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
--     FROM supplier, nation, region
--     WHERE (s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey);

-- SELECT *
-- FROM V2

-- DROP VIEW V2

-- SELECT V2.s_region, COUNT(*)
-- FROM V2
-- GROUP BY V2.s_region;

select r_name, count(*)
from supplier, nation, region
where s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
group by r_name;

--3
-- c_custkey, c_name, c_address, c_phone, c_acctbal, 
-- c_mktsegment, c_comment, n_name, r_name
-- SELECT V1.c_nation, COUNT(*)
-- FROM V1, orders
-- WHERE V1.c_custkey = o_custkey
--     and V1.c_region = 'AMERICA'
-- GROUP BY V1.c_nation;

select n_name, count(*)
from orders, nation, region, customer
where c_custkey = o_custkey
    and c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name='AMERICA'
group by n_name;

--4
-- s_suppkey, s_name, s_address, s_phone, s_acctbal, 
--s_comment, n_name, r_name

-- SELECT V2.s_name, count(ps_partkey)
-- FROM V2, partsupp, part
-- WHERE p_partkey = ps_partkey 
--     and ps_suppkey = V2.s_suppkey
--     and V2.s_nation = 'CANADA'
--     and p_size < 20
-- GROUP BY V2.s_name; 

select s_name, count(ps_partkey)
from partsupp, supplier, nation, part
where p_partkey = ps_partkey
    and ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
    and p_size < 20
group by s_name;

--5
-- V5(o orderkey, o custkey, o orderstatus, o totalprice, o orderyear, o orderpriority, o clerk,
-- o shippriority, o comment)

-- DROP VIEW V5;

-- CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS 
--     SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment
--     FROM orders;

-- V1 c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
-- V5 o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment

-- SELECT V1.c_name, COUNT(*)
-- FROM V1, V5
-- WHERE V5.o_custkey = V1.c_custkey
--     AND V1.c_nation = 'GERMANY'
--     AND V5.o_orderyear = '1993'
-- GROUP BY V1.c_name;

select c_name, count(*)
from orders, customer, nation
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and n_name = 'GERMANY'
    and o_orderdate like '1993-__-__'
group by c_name;

--6

-- V5 o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment

-- SELECT s_name, V5.o_orderpriority, count(distinct ps_partkey)
-- FROM V5, partsupp, lineitem, supplier, nation
-- WHERE l_orderkey = V5.o_orderkey
--     and l_partkey = ps_partkey
--     and l_suppkey = ps_suppkey
--     and ps_suppkey = s_suppkey
--     and s_nationkey = n_nationkey
--     and n_name = 'CANADA'
-- group by s_name, V5.o_orderpriority;

select s_name, o_orderpriority, count(distinct ps_partkey)
from partsupp, orders, lineitem, supplier, nation
where l_orderkey = o_orderkey
    and l_partkey = ps_partkey
    and l_suppkey = ps_suppkey
    and ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
group by s_name, o_orderpriority;

--7

-- V1 c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
-- V5 o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment

SELECT V1.c_nation, V5.o_orderstatus, COUNT(*)
FROM V1, V5
WHERE V1.c_custkey = V5.o_custkey
    and V1.c_region = 'AMERICA'
GROUP BY V1.c_nation, V5.o_orderstatus;

select n_name, o_orderstatus, count(*)
from orders, customer, nation, region
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name='AMERICA'
group by n_name, o_orderstatus;

--8

-- V2 s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
-- V5 o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment

-- SELECT V2.s_nation, COUNT(DISTINCT l_orderkey) as co
-- FROM V2, V5, lineitem
-- WHERE V5.o_orderkey = l_orderkey
--     and l_suppkey = V2.s_suppkey
--     and V5.o_orderstatus = 'F'
--     and V5.o_orderyear = '1995'
-- GROUP by V2.s_nation
-- HAVING co > 50;

select n_name, count(distinct l_orderkey) as co
from orders, nation, supplier, lineitem
where o_orderkey = l_orderkey
    and l_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and o_orderstatus = 'F'
    and o_orderdate like '1995-__-__'
group by n_name
having co > 50;

--9
-- V2 s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
-- V5 o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment

-- SELECT count(distinct V5.o_clerk)
-- FROM V2, V5, lineitem
-- WHERE V5.o_orderkey = l_orderkey
--     and l_suppkey = V2.s_suppkey
--     and V2.s_nation = 'UNITED STATES';

select count(distinct o_clerk)
from orders, supplier, nation, lineitem
where o_orderkey = l_orderkey
    and l_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'UNITED STATES';

--10

-- CREATE VIEW V10(p_type, min_discount, max_discount) AS
--     SELECT p_type, MIN(l_discount), MAX(l_discount)
--     FROM lineitem, partsupp, part
--     WHERE l_suppkey = ps_suppkey
--         and ps_partkey = p_partkey
--     GROUP BY p_type

-- V10 p_type, MIN(l_discount), MAX(l_discount)

-- SELECT V10.p_type, min(V10.min_discount), max(V10.max_discount)
-- FROM V10
-- WHERE V10.p_type like '%ECONOMY%'
--     AND V10.p_type like '%COPPER%'
-- GROUP BY V10.p_type;

select p_type, min(l_discount), max(l_discount)
from lineitem, part
where l_partkey = p_partkey
    and p_type like '%ECONOMY%'
    and p_type like '%COPPER%'
group by p_type;

--11

-- V2 s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name

-- SELECT V2.s_region, V2.s_name, MAX(V2.s_acctbal)
-- FROM V2
-- GROUP BY V2.s_region
-- ORDER BY V2.s_name ASC;

select r.r_name, s.s_name, s.s_acctbal
from supplier s, nation n, region r
where s.s_nationkey = n.n_nationkey
        and n.n_regionkey = r.r_regionkey
        and s.s_acctbal = (select max(s1.s_acctbal)
							from supplier s1, nation n1, region r1
							where s1.s_nationkey = n1.n_nationkey
								and n1.n_regionkey = r1.r_regionkey
								and r.r_regionkey = r1.r_regionkey
						);

--12

-- V2 s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name

-- SELECT V2.s_nation, max(V2.s_acctbal) as mb
-- FROM V2
-- GROUP BY V2.s_name
-- HAVING mb > 9000
-- ORDER BY V2.s_nation;

select n_name, max(s_acctbal) as mb
from supplier, nation
where s_nationkey = n_nationkey
group by n_name
having mb > 9000;

--13

-- V1 c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
-- V2 s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name

-- SELECT count(*)
-- FROM V1, V2, lineitem, orders
-- WHERE o_orderkey = l_orderkey
--     and o_custkey = V1.c_custkey
--     and l_suppkey = V2.s_suppkey
--     and V2.s_region = 'AFRICA'
--     and V1.c_nation = 'UNITED STATES';

select count(*)
from orders, lineitem, customer, supplier, nation n1, region, nation n2
where o_orderkey = l_orderkey
    and o_custkey = c_custkey
    and l_suppkey = s_suppkey
    and s_nationkey = n1.n_nationkey
    and n1.n_regionkey = r_regionkey
    and c_nationkey = n2.n_nationkey
    and r_name = 'AFRICA'
    and n2.n_name = 'UNITED STATES';

--14

-- V1 c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
-- V2 s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name

-- SELECT V2.s_region, V1.c_region, max(o_totalprice)
-- FROM V1, V2, lineitem, orders
-- WHERE l_suppkey = V2.s_suppkey
--     and l_orderkey = o_orderkey
--     and o_custkey = V1.c_custkey
-- GROUP BY V2.s_region, V1.c_region;

select r1.r_name as suppRegion, r2.r_name as custRegion, max(o_totalprice)
from lineitem, supplier, orders, customer, nation n1, region r1, nation n2, region r2
where l_suppkey = s_suppkey
    and s_nationkey = n1.n_nationkey
    and n1.n_regionkey = r1.r_regionkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_nationkey = n2.n_nationkey
    and n2.n_regionkey = r2.r_regionkey
group by r1.r_name, r2.r_name;

--15

CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) AS
    SELECT c_custkey, c_name, c_nationkey, c_acctbal
    FROM customer
    WHERE c_acctbal > 0

CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) AS
    SELECT s_suppkey, s_name, s_nationkey, s_acctbal
    FROM supplier
    WHERE s_acctbal < 0;

SELECT COUNT(DISTINCT l_orderkey)
FROM V151, V152, lineitem, orders
WHERE l_suppkey = V152.s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = V151.c_custkey;

select count(distinct l_orderkey)
from lineitem, supplier, orders, customer
where l_suppkey = s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_acctbal > 0
    and s_acctbal < 0;

DROP VIEW V1;

-- 4. Create triggers that update the attribute o_orderpriority to HIGH every time a new lineitem tuple
-- is added to or deleted from that order. Delete all the line items corresponding to orders from December
-- 1995. Write a query that returns the number of HIGH priority orders in the fourth trimester of 1995.
-- Put all the SQL statements in file test/4.sql. (3 points)

-- DROP TRIGGER t4;

CREATE TRIGGER t4 AFTER INSERT ON lineitem
BEGIN
    UPDATE orders
    SET o_orderpriority = '2-HIGH'
    WHERE o_orderkey = l_orderkey
END;

CREATE TRIGGER t5 AFTER DELETE ON lineitem
BEGIN 
    UPDATE orders
    SET o_orderpriority = '2-HIGH'
    WHERE o_orderkey = l_orderkey
END;

DELETE FROM lineitem
WHERE l_orderkey in (SELECT o_orderkey
    FROM orders
    WHERE (o_orderdate LIKE '1995-12%'));

SELECT COUNT(o_orderkey)
FROM orders
WHERE o_orderpriority = '2-HIGH' AND
    o_orderdate >= '1995-10-01' AND 
    o_orderdate < '1996-01-01';

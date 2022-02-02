-- 2. Create a trigger t2 that sets a warning Negative balance!!! in the comment attribute of the
-- customer table every time c acctbal is updated to a negative value from a positive one. Write a
-- SQL statement that sets the balance to -100 for all the customers in AMERICA. Write a query that
-- returns the number of customers with negative balance from CANADA. Put all the SQL statements in
-- file test/2.sql. (3 points)

-- DROP TRIGGER t2;

CREATE TRIGGER t2 AFTER UPDATE ON customer
BEGIN 
    UPDATE customer
    SET c_comment = 'Negative balance!!!'
    WHERE c_acctbal < 0;
END;

-- SELECT *
-- FROM customer, nation, region
-- WHERE c_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = 'AMERICA'

UPDATE customer
SET c_acctbal = -100
WHERE c_nationkey in (SELECT n_nationkey
    FROM nation, region
    WHERE n_regionkey = r_regionkey AND r_name = 'AMERICA');

SELECT COUNT(*)
FROM customer, nation
WHERE c_nationkey = n_nationkey and n_name = 'CANADA'

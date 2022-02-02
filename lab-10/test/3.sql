-- 3. Create a trigger t3 that resets the comment to Positive balance if the balance goes back positive
-- from negative. Write a SQL statement that sets the balance to 100 for all the customers in UNITED
-- STATES. Write a query that returns the number of customers with negative balance from AMERICA. Put
-- all the SQL statements in file test/3.sql. (3 points)

CREATE TRIGGER t3 AFTER UPDATE ON customer
BEGIN 
    UPDATE customer
    SET c_comment = 'Positive balance'
    WHERE c_acctbal > 0;
END;

UPDATE customer
SET c_acctbal = 100
WHERE c_nationkey in (SELECT n_nationkey
    FROM nation
    WHERE n_name = 'UNITED STATES');

SELECT COUNT(*)
FROM customer, nation, region
WHERE c_nationkey = n_nationkey and
    n_regionkey = r_regionkey AND
    r_name = 'AMERICA' AND
    c_acctbal < 0;

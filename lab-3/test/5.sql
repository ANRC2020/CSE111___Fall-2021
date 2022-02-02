/*What is the minimum, maximum, and total account 
balance among the customers in every marketsegment?*/
SELECT 
    c_mktsegment,
    MIN(c_acctbal) as MIN_BAL, 
    MAX(c_acctbal) as MAX_BAL, 
    SUM(c_acctbal) as total_account
FROM customer
GROUP BY c_mktsegment

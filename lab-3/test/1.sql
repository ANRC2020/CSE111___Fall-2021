/*What is the address, phone number, 
and account balance of Customer#000000010?*/
SELECT 
    c_address, 
    c_phone, 
    c_acctbal 
FROM customer 
WHERE c_name = 'Customer#000000010'
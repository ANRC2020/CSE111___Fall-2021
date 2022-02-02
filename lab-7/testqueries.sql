
-- CREATE TABLE temp(
--     counter INTEGER NOT NULL)

-- INSERT INTO temp(counter)
-- VALUES(1)

-- UPDATE temp
-- SET counter = counter + 1

-- UPDATE temp
-- SET counter = counter - 1

-- DROP TABLE temp

CREATE TABLE warehouseloc(
    supplier_name char(25),
    location VARCHAR(25))

SELECT DISTINCT s_name as SN, n_name as NN, COUNT(l_linenumber) AS CLN, n_nationkey
FROM supplier, lineitem, orders, customer, nation, part
WHERE ((s_name = 'Supplier#000000011') AND (s_suppkey = l_suppkey) 
    AND (l_orderkey = o_orderkey) AND (o_custkey = c_custkey) 
    AND (c_nationkey = n_nationkey) AND (l_partkey = p_partkey))
GROUP BY s_name, n_name
ORDER BY COUNT(l_linenumber) DESC
LIMIT 2

SELECT MAX(t1.SPS)
FROM (SELECT n_name as NN, SUM(p_size) * 2 as SPS
    FROM supplier, lineitem, orders, customer, nation, part
    WHERE ((s_name = 'Supplier#000000011') AND (s_suppkey = l_suppkey) 
        AND (l_orderkey = o_orderkey) AND (o_custkey = c_custkey) 
        AND (c_nationkey = n_nationkey) AND (l_partkey = p_partkey))
    GROUP BY n_name
    ORDER BY SUM(p_size) * 2 DESC, n_name) as t1

SELECT *
FROM warehouse

/*Q2 computes the number of warehouses and the total capacity for the warehouses in every nation. The
result is sorted in decreasing order of the number of warehouses and of the capacity, then alphabetical
order of the nation name. */

SELECT n_name, COUNT(w_capacity), SUM(w_capacity)
FROM warehouse, nation
WHERE ((w_nationkey = n_nationkey))
GROUP BY n_name
ORDER BY COUNT(w_capacity) DESC, SUM(w_capacity) DESC, n_name

/*Q3 computes the suppliers that have a warehouse in a given nation taken as input parameter. The
nation where warehouses are located is read from the input file input/3.in. Q3 prints the name of the
supplier, the nation of the supplier, and the name of the warehouse—sorted in alphabetical order by
supplier name. (3 points)*/

SELECT s_name, n_name, w_name
FROM warehouse, nation, supplier
WHERE ((w_suppkey = s_suppkey) AND (s_nationkey = n_nationkey))

/*Q4 finds the warehouses from a given region that have capacity larger than a given threshold. The
region name and the minimum capacity are parameters stored in the file input/4.in. Q4 prints the
warehouse name and its capacity in decreasing order of the capacity.*/

SELECT w_name, w_capacity, r_name
FROM warehouse, nation, region
WHERE ((w_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
ORDER BY r_name, w_capacity DESC 

/*Q5 determines the total capacity of the warehouses belonging to 
suppliers from a given nation in every region. The suppliers’ nation 
is a parameter stored in the file input/5.in. If there are no 
warehouses in a region, then value 0 is printed for that region. Q5 
prints the region and the capacity sorted alphabetically by region. */

SELECT r_name,SUM(w_capacity)
FROM (SELECT DISTINCT s_suppkey as snk
    FROM supplier, nation
    WHERE ((s_nationkey = n_nationkey) AND (n_name = 'UNITED STATES'))) as t1, warehouse
    , nation, region 
WHERE ((w_suppkey = t1.snk) AND (w_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
GROUP BY r_name

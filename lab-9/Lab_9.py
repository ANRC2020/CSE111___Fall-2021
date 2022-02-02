import sqlite3
from sqlite3 import Error
from sqlite3.dbapi2 import Cursor


def openConnection(_dbFile):

    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")

    #Comment out 'DROP' line if no VIEW is already created

    try:
        sql = """DROP VIEW V1"""

        _conn.execute(sql)

        sql = """CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS 
        SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
        FROM customer, region, nation
        WHERE (c_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)"""

        _conn.execute(sql)
    except Exception as e:
        sql = """CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS 
        SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
        FROM customer, region, nation
        WHERE (c_nationkey = n_nationkey) AND (n_regionkey = r_regionkey)"""

        _conn.execute(sql)

    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")

    try:
        sql = """DROP VIEW V2"""

        _conn.execute(sql)

        sql = """CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
        SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
        FROM supplier, nation, region
        WHERE (s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey);"""

        _conn.execute(sql)
    except Exception as e:
        sql = """CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
        SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
        FROM supplier, nation, region
        WHERE (s_nationkey = n_nationkey) AND (n_regionkey = r_regionkey);"""

        _conn.execute(sql)


    print("++++++++++++++++++++++++++++++++++")


def create_View5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V5")

    try:
        sql = """DROP VIEW V5"""
        _conn.execute(sql)

        sql = """CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS 
        SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment
        FROM orders;"""
        _conn.execute(sql)
    except Exception as e:
        sql = """CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS 
        SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, SUBSTR(o_orderdate,1,4), o_orderpriority, o_clerk, o_shippriority, o_comment
        FROM orders;"""
        _conn.execute(sql)

    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")

    try:
        sql = """DROP VIEW V10;"""

        _conn.execute(sql)

        sql = """CREATE VIEW V10(p_type, min_discount, max_discount) AS
        SELECT p_type, MIN(l_discount), MAX(l_discount)
        FROM lineitem, partsupp, part
        WHERE l_suppkey = ps_suppkey
            and ps_partkey = p_partkey
        GROUP BY p_type"""

        _conn.execute(sql)
    except Exception as e:
        sql = """CREATE VIEW V10(p_type, min_discount, max_discount) AS
        SELECT p_type, MIN(l_discount), MAX(l_discount)
        FROM lineitem, partsupp, part
        WHERE l_suppkey = ps_suppkey
            and ps_partkey = p_partkey
        GROUP BY p_type"""

        _conn.execute(sql)

    print("++++++++++++++++++++++++++++++++++")


def create_View151(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V151")

    try:
        sql = """DROP VIEW V151;"""

        _conn.execute(sql)

        sql = """CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) AS
        SELECT c_custkey, c_name, c_nationkey, c_acctbal
        FROM customer
        WHERE c_acctbal > 0;"""

        _conn.execute(sql)
    except Exception as e:
        sql = """CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) AS
        SELECT c_custkey, c_name, c_nationkey, c_acctbal
        FROM customer
        WHERE c_acctbal > 0;"""

        _conn.execute(sql)

    print("++++++++++++++++++++++++++++++++++")


def create_View152(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V152")

    try:
        sql = 'DROP VIEW V152;'

        _conn.execute(sql)

        sql = """CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) AS
        SELECT s_suppkey, s_name, s_nationkey, s_acctbal
        FROM supplier
        WHERE s_acctbal < 0;"""

        _conn.execute(sql)
    except Exception as e:
        sql = """CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) AS
        SELECT s_suppkey, s_name, s_nationkey, s_acctbal
        FROM supplier
        WHERE s_acctbal < 0;"""

        _conn.execute(sql)

    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    sql = """SELECT V1.c_name, SUM(o_totalprice)
        FROM orders, V1
        WHERE o_custkey = V1.c_custkey and 
            V1.c_nation = 'FRANCE' AND 
            o_orderdate like '1995-__-__'
        GROUP by V1.c_name;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()       

    try:
        f = open("output/1.out", "x")
        f = open("output/1.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/1.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    sql = """SELECT V2.s_region, COUNT(*)
    FROM V2
    GROUP BY V2.s_region;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/2.out", "x")
        f = open("output/2.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/2.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    sql = """SELECT V1.c_nation, COUNT(*)
    FROM V1, orders
    WHERE V1.c_custkey = o_custkey
        and V1.c_region = 'AMERICA'
    GROUP BY V1.c_nation;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/3.out", "x")
        f = open("output/3.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/3.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    sql = """SELECT V2.s_name, count(ps_partkey)
    FROM V2, partsupp, part
    WHERE p_partkey = ps_partkey 
        and ps_suppkey = V2.s_suppkey
        and V2.s_nation = 'CANADA'
        and p_size < 20
    GROUP BY V2.s_name; """

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/4.out", "x")
        f = open("output/4.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/4.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    sql = """SELECT V1.c_name, COUNT(*)
    FROM V1, V5
    WHERE V5.o_custkey = V1.c_custkey
        AND V1.c_nation = 'GERMANY'
        AND V5.o_orderyear = '1993'
    GROUP BY V1.c_name;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/5.out", "x")
        f = open("output/5.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/5.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")

    sql = """SELECT s_name, V5.o_orderpriority, count(distinct ps_partkey)
    FROM V5, partsupp, lineitem, supplier, nation
    WHERE l_orderkey = V5.o_orderkey
        and l_partkey = ps_partkey
        and l_suppkey = ps_suppkey
        and ps_suppkey = s_suppkey
        and s_nationkey = n_nationkey
        and n_name = 'CANADA'
    group by s_name, V5.o_orderpriority;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/6.out", "x")
        f = open("output/6.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{res[i][2]}\n")
        
        f.close()
    except Exception as e:
        f = open("output/6.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{res[i][2]}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")

    sql = """SELECT V1.c_nation, V5.o_orderstatus, COUNT(*)
    FROM V1, V5
    WHERE V1.c_custkey = V5.o_custkey
        and V1.c_region = 'AMERICA'
    GROUP BY V1.c_nation, V5.o_orderstatus;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/7.out", "x")
        f = open("output/7.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{res[i][2]}\n")
        
        f.close()
    except Exception as e:
        f = open("output/7.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{res[i][2]}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")

    sql = """SELECT V2.s_nation, COUNT(DISTINCT l_orderkey) as co
    FROM V2, V5, lineitem
    WHERE V5.o_orderkey = l_orderkey
        and l_suppkey = V2.s_suppkey
        and V5.o_orderstatus = 'F'
        and V5.o_orderyear = '1995'
    GROUP by V2.s_nation
    HAVING co > 50;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/8.out", "x")
        f = open("output/8.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/8.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")

    sql = """SELECT count(distinct V5.o_clerk)
    FROM V2, V5, lineitem
    WHERE V5.o_orderkey = l_orderkey
        and l_suppkey = V2.s_suppkey
        and V2.s_nation = 'UNITED STATES';"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/9.out", "x")
        f = open("output/9.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}\n")
        
        f.close()
    except Exception as e:
        f = open("output/9.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")

    sql = """SELECT V10.p_type, min(V10.min_discount), max(V10.max_discount)
    FROM V10
    WHERE V10.p_type like '%ECONOMY%'
        AND V10.p_type like '%COPPER%'
    GROUP BY V10.p_type;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/10.out", "x")
        f = open("output/10.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{round(res[i][2],1)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/10.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{round(res[i][2],1)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")

    sql = """SELECT V2.s_region, V2.s_name, MAX(V2.s_acctbal)
    FROM V2
    GROUP BY V2.s_region;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/11.out", "x")
        f = open("output/11.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{round(res[i][2],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/11.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{round(res[i][2],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")

    sql = """SELECT V2.s_nation, max(V2.s_acctbal) as mb
    FROM V2
    GROUP BY V2.s_name
    HAVING mb > 9000
    ORDER BY V2.s_nation;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/12.out", "x")
        f = open("output/12.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/12.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{round(res[i][1],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")

    sql = """SELECT count(*)
    FROM V1, V2, lineitem, orders
    WHERE o_orderkey = l_orderkey
        and o_custkey = V1.c_custkey
        and l_suppkey = V2.s_suppkey
        and V2.s_region = 'AFRICA'
        and V1.c_nation = 'UNITED STATES';"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/13.out", "x")
        f = open("output/13.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}\n")
        
        f.close()
    except Exception as e:
        f = open("output/13.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")

    sql = """SELECT V2.s_region, V1.c_region, max(o_totalprice)
    FROM V1, V2, lineitem, orders
    WHERE l_suppkey = V2.s_suppkey
        and l_orderkey = o_orderkey
        and o_custkey = V1.c_custkey
    GROUP BY V2.s_region, V1.c_region;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()
    
    try:
        f = open("output/14.out", "x")
        f = open("output/14.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{round(res[i][2],2)}\n")
        
        f.close()
    except Exception as e:
        f = open("output/14.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}|{res[i][1]}|{round(res[i][2],2)}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")

    sql = """SELECT COUNT(DISTINCT l_orderkey)
    FROM V151, V152, lineitem, orders
    WHERE l_suppkey = V152.s_suppkey
        and l_orderkey = o_orderkey
        and o_custkey = V151.c_custkey;"""

    cur = _conn.cursor()
    cur.execute(sql)

    res = cur.fetchall()

    try:
        f = open("output/15.out", "x")
        f = open("output/15.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}\n")
        
        f.close()
    except Exception as e:
        f = open("output/15.out", "w")

        for i in range(len(res)):
            f.write(f"{res[i][0]}\n")        

        f.close()

    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)
        Q4(conn)

        create_View5(conn)
        Q5(conn)

        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)

        create_View151(conn)
        create_View152(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()

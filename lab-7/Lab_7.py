import sqlite3
from sqlite3 import *


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

def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")

    try:
        sql = """CREATE TABLE warehouse (
        w_warehousekey decimal(9,0) NOT NULL,
        w_name char(100) NOT NULL,
        w_capacity decimal(6,0) NOT NULL,
        w_suppkey decimal(9,0) NOT NULL,
        w_nationkey decimal(2,0) NOT NULL)"""

        _conn.execute(sql)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")

    try:
        sql = """DROP TABLE warehouse"""

        _conn.execute(sql)
        
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    
    cursor = _conn.cursor()
    
    sql = """SELECT COUNT(*) FROM SUPPLIER"""

    cursor.execute(sql)
    num_supplier = cursor.fetchall()

    wId = 1

    for i in range(1,num_supplier[0][0] + 1):
        
        if(i < 10):
            supplier = """'Supplier#00000000""" + str(i) + """'"""
            # print(supplier)
        elif(i < 100):
            supplier = """'Supplier#0000000""" + str(i) + """'"""
            # print(supplier)
        elif(i < 1000):
            supplier = """'Supplier#000000""" + str(i) + """'"""
            # print(supplier)

        sql = """SELECT DISTINCT s_name, n_name, n_nationkey
                FROM supplier, lineitem, orders, customer, nation, part
                WHERE ((s_name = """ + supplier + """) AND (s_suppkey = l_suppkey) 
                    AND (l_orderkey = o_orderkey) AND (o_custkey = c_custkey) 
                    AND (c_nationkey = n_nationkey) AND (l_partkey = p_partkey))
                GROUP BY s_name, n_name
                ORDER BY COUNT(l_linenumber) DESC
                LIMIT 2"""

        cursor.execute(sql)

        temp = cursor.fetchall()

        temp1 = list(temp[0])
        temp2 = list(temp[1])

        nkey1 = temp1[2]
        nkey2 = temp2[2]

        sql = """SELECT MAX(t1.SPS)
                FROM (SELECT n_name as NN, SUM(p_size) * 2 as SPS
                    FROM supplier, lineitem, orders, customer, nation, part
                    WHERE ((s_name = """ + supplier + """) AND (s_suppkey = l_suppkey) 
                        AND (l_orderkey = o_orderkey) AND (o_custkey = c_custkey) 
                        AND (c_nationkey = n_nationkey) AND (l_partkey = p_partkey))
                    GROUP BY n_name
                    ORDER BY SUM(p_size) * 2 DESC, n_name) as t1"""
        
        cursor.execute(sql)

        temp = cursor.fetchall()

        temp1[2] = (temp[0][0])
        temp2[2] = (temp[0][0])

        temp1[1] = temp1[0] + "___" + temp1[1]
        temp1[0] = wId
        wId += 1
        temp2[1] = temp2[0] + "___" + temp2[1]
        temp2[0] = wId
        wId += 1
        temp1.append(i)
        temp2.append(i)
        temp1.append(nkey1)
        temp2.append(nkey2)

        # print(temp1)
        # print(temp2)

        sql = f"""INSERT INTO warehouse
                (w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey)
                VALUES
                (?, ?, ?, ?, ?)"""
        _conn.execute(sql, temp1)
        _conn.commit()
        sql = f"""INSERT INTO warehouse(w_warehousekey,w_name,w_capacity,w_suppkey,w_nationkey)
                VALUES(?,?,?,?,?)"""
        _conn.execute(sql,temp2)
        _conn.commit()      
        

    print("++++++++++++++++++++++++++++++++++")

def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    cap = len('Supplier#000000002___SAUDI ARABIA              ')

    try:
        sql = """SELECT *
                FROM warehouse"""
        
        temp = list(_conn.execute(sql))

        f = open('output/1.out','w')

        print("        wId wName                                          wCap        sId        nId")
        f.write("        wId wName                                          wCap        sId        nId\n")

        for i in range(len(temp)):
            cur_id_len = len(str(temp[i][0]))
            cur_name_len = len(temp[i][1])
            cur_sid_len = len(str(temp[i][3]))
            cur_nid_len = len(str(temp[i][4]))

            idspace = ''
            for j in range(3 - cur_id_len):
                idspace = idspace + " "

            namespace = ''
            for j in range(cap - cur_name_len):
                namespace = namespace + " "

            sidspace = ''
            for j in range(3 - cur_sid_len):
                sidspace = sidspace + " "

            nidspace = ''
            for j in range(2 - cur_nid_len):
                nidspace = nidspace + " "

            print("        " + idspace + str(temp[i][0]) + " " + temp[i][1] + namespace + str(temp[i][2]) 
                + "        " + sidspace + str(temp[i][3]) + "         " + nidspace + str(temp[i][4]))
            f.write("        "+ idspace + str(temp[i][0]) + " " + temp[i][1] + namespace + str(temp[i][2]) 
                + "        " + sidspace + str(temp[i][3]) + "         " + nidspace + str(temp[i][4]) + "\n")

        f.close()
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    sql = """SELECT n_name, COUNT(w_capacity), SUM(w_capacity)
            FROM warehouse, nation
            WHERE ((w_nationkey = n_nationkey))
            GROUP BY n_name
            ORDER BY COUNT(w_capacity) DESC, SUM(w_capacity) DESC, n_name"""

    temp = list(_conn.execute(sql))

    cap = len("CANADA                                           ")

    f = open('output/2.out','w')

    print("nation                                         numW     totCap")
    f.write("nation                                         numW     totCap\n")

    for i in range(len(temp)):
        cur_country_len = len(str(temp[i][0]))
        cur_numW_len = len(str(temp[i][1]))
        cur_totCap_len = len(str(temp[i][2]))

        namespace = ''
        for j in range(cap - cur_country_len):
            namespace = namespace + " "

        numWspace = ''
        for j in range(2 - cur_numW_len):
            numWspace = numWspace + " "
        
        totCapspace = ''
        for j in range(5 - cur_totCap_len):
            totCapspace = totCapspace + " "

        print(temp[i][0] + namespace + numWspace + str(temp[i][1]) + "      " + totCapspace + str(temp[i][2]))
        f.write(temp[i][0] + namespace + numWspace + str(temp[i][1]) + "      " + totCapspace + str(temp[i][2]) + '\n')

    f.close()

    print("++++++++++++++++++++++++++++++++++")

def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    with open('input/3.in','r') as f:
        lines = f.readlines()
    f.close()

    country = lines[0]
    country = country.replace('\n','')

    sql = """SELECT s_name, n_name, w_name
            FROM warehouse, nation, supplier
            WHERE ((w_suppkey = s_suppkey) AND (s_nationkey = n_nationkey))"""

    temp = list(_conn.execute(sql))

    cap = len('Supplier#000000086___')

    ans = []

    for i in range(len(temp)):

        if(str(temp[i][2][cap:]) == str(country)):
            ans.append(temp[i])
    
    f = open('output/3.out','w')
    
    print('supplier             nation               warehouse')
    f.write('supplier             nation               warehouse\n')

    cap = len('ARGENTINA            ')

    for i in range(len(ans)):
        cur_country_len = len(ans[i][1])

        ccl_space = ''
        for j in range(cap - cur_country_len):
            ccl_space = ccl_space + ' '

        print(ans[i][0] + '   ' + ans[i][1] + ccl_space + ans[i][2])
        f.write(ans[i][0] + '   ' + ans[i][1] + ccl_space + ans[i][2] + "\n")

    f.close()
    print("++++++++++++++++++++++++++++++++++")

def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    with open('input/4.in','r') as f:
        lines = f.readlines()
    f.close()

    country = lines[0]
    country = country.replace('\n','')

    threshold = lines[1]
    threshold = int(threshold.replace('\n',''))

    sql = """SELECT w_name, w_capacity, r_name
            FROM warehouse, nation, region
            WHERE ((w_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
            ORDER BY r_name, w_capacity DESC"""
    
    temp = list(_conn.execute(sql))

    ans = []

    for i in range(len(temp)):

        if(temp[i][2] == country and int(temp[i][1]) >= threshold):
            ans.append(temp[i])

    cap = len('Supplier#000000073___JAPAN                     ')

    f = open('output/4.out','w')

    print('warehouse                                  capacity')
    f.write('warehouse                                  capacity\n')

    for i in range(len(ans)):
        cur_name_len = len(ans[i][0])
        
        name_space = ''
        for j in range(cap - cur_name_len):
            name_space = name_space + ' '

        print(ans[i][0] + name_space + str(ans[i][1]))
        f.write(ans[i][0] + name_space + str(ans[i][1]) + "\n")

    f.close()

    print("++++++++++++++++++++++++++++++++++")

def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

    with open('input/5.in','r') as f:
        lines = f.readlines()
    f.close()

    country = lines[0]
    country = country.replace('\n','')

    sql = """SELECT r_name,SUM(w_capacity)
    FROM (SELECT DISTINCT s_suppkey as snk
        FROM supplier, nation
        WHERE ((s_nationkey = n_nationkey) AND (n_name = '""" + country + """'))) as t1, warehouse
        , nation, region 
    WHERE ((w_suppkey = t1.snk) AND (w_nationkey = n_nationkey) AND (n_regionkey = r_regionkey))
    GROUP BY r_name"""

    temp = list(_conn.execute(sql))

    sql = """SELECT r_name
            FROM region"""

    regions = list(_conn.execute(sql))

    f = open('output/5.out','w')

    print('region                           capacity')
    f.write('region                           capacity\n')

    cap = len('AFRICA                               4314')

    j = 0
    for i in range(len(regions)):
        cur_region_len = len(regions[i][0])
        cur_num_len = len(str(temp[j][1]))

        space = ''
        for k in range(cap - cur_region_len - cur_num_len):
            space = space + " "

        if(regions[i][0] == temp[j][0]):
            print(str(regions[i][0]) + space + str(temp[j][1]))
            f.write(str(regions[i][0]) + space + str(temp[j][1]) + "\n")
            j += 1
        else:
            print(str(regions[i][0]) + space + '   0')
            f.write(str(regions[i][0]) + space + '   0\n')

    print("++++++++++++++++++++++++++++++++++")

def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        # Q2(conn)
        # Q3(conn)
        # Q4(conn)
        # Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()

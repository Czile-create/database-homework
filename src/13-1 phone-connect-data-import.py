import cx_Oracle, random
con = cx_Oracle.connect('scott/tiger@127.0.0.1/orcl')

# 手机号表
phone_number = [
    int(1e10) + random.randint(0, 1e10) 
    for i in range(5)
]

# 基站表
station = [
    random.randint(0, 1e5)
    for i in range(10)
]

to_insert = [(
    random.randint(1652371200, 1652457600),
    random.choice(phone_number),
    random.choice(station))
    for i in range(300)
]

with open('data.csv', 'w') as f:
    for i in to_insert:
        f.write(','.join(map(str, i)))
        f.write('\n')

cur = con.cursor()
cur.bindarraysize = 10000
cur.setinputsizes(int, int, int)
cur.executemany("insert into phone values (:1, :2, :3)", to_insert)
con.commit()
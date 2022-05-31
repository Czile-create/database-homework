import cx_Oracle
import MySQLdb

con = cx_Oracle.connect('scott/tiger@127.0.0.1/orcl')
cur = con.cursor()
cur.execute('select * from emp')
emp = [result for result in cur]
db = MySQLdb.connect(
    'localhost', 'Czile', '1q2w3e', 
    'mysql', charset='utf-8'
)
cur = db.cursor()
import cx_Oracle, json
import numpy as np

def insertData():
    con = cx_Oracle.connect('scott/tiger@127.0.0.1/ORCL')
    news = json.loads(open('news.json', encoding='utf-8').read())['news']
    news = [(
        i['order'],
        i['news'],
        i['class'],
        i['source'],
        i['link'],
        i['rating']
    ) for i in news]

    news = [news[i] for i in np.random.randint(0, len(news)-1, size=1000)]
    true_news = set(news)
    cur = con.cursor()
    try:
        cur.bindarraysize = len(news)
        cur.setinputsizes(int, 300)
        cur.executemany("insert into news values (:1, :2, :3, :4, :5, :6)", news)
        con.commit()
    except Exception as e:
        print(e)
        con.rollback()
    con.close()
    print(f'已插入 {len(news)} 行，非重复行数{len(true_news)}行')

insertData()
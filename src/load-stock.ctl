options(skip=1,rows=4096)
load data
infile "data/000001.SS.csv"
truncate
INTO table ss001
fields terminated by ","
(day,open,high,low,close,adjclose,volume)
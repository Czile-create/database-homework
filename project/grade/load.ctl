options(skip=1,rows=4096)
load data
infile "D:\Work\Êý¾Ý¿â\project\grade\grade.csv"
truncate
INTO table grade
fields terminated by ","
(day,subject,full,score,class_rank,grade_rank,avg_score)
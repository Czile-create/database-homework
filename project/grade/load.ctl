options(skip=1,rows=4096)
load data
infile "D:\Work\���ݿ�\project\grade\grade.csv"
truncate
INTO table grade
fields terminated by ","
(day,subject,full,score,class_rank,grade_rank,avg_score)
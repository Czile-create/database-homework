OPTIONS (skip=0) 
load data
INFILE  'score_data.csv'  
insert into table score
FIELDS TERMINATED BY ', '
trailing nullcols (
    SID,
    CID,
    SCORE
)
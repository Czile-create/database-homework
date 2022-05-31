set colsep  ,
set feedback off
set heading off
set newp none
set pagesize 0
set linesize 200
set trimout on

spool EMP.CSV
select * from EMP;  
spool off  
exit
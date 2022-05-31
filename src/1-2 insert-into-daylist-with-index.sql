-- 环境变量设置
set serveroutput on;

-- 建表
create table tmp(
    c1 date
);
create index idd on tmp(c1);

-- 插入
Declare
    i integer;
    st PLS_INTEGER;
    ed PLS_INTEGER;
Begin
    st := dbms_utility.get_time;
    << To_insert >>
    for i in 1..1000000 loop
        if mod(i, 2) = 1 then
            insert into tmp values(sysdate);
        else
            insert into tmp values(sysdate + 1);
        end if;
    end loop To_insert;
    ed := dbms_utility.get_time;
    dbms_output.put_line('Use time: '||(ed - st)/100||'s');
End;
/
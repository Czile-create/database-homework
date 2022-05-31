set serveroutput on;

declare
    cursor most_sal is
        select ename, sal from emp
        order by sal desc;
    sal emp.sal%type;
    ename emp.ename%type;
    i integer;
begin
    open most_sal;
    for i in 1..3 loop
        fetch most_sal into ename, sal;
        dbms_output.put_line(ename||' '||sal);
    end loop;
    close most_sal;
end;
/
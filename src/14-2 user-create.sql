declare
    usernum varchar2(4);
begin
    for i in 1..99 loop
        usernum := substr(to_char(i, '09'), 2, 2);
        execute immediate 'create user A'||usernum||' identified by tiger';
        execute immediate 'grant resource,connect,dba to A'||usernum;
        execute immediate 'create table A'||usernum||'.emp as (select * from scott.emp)';
    end loop;
end;
/
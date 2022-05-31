create or replace procedure bs(u varchar2) is 
begin
    declare
        c clob;
        v varchar2(32767);
        i int := 1;
    begin
        c := http_get(u);
        loop
            -- 截取信息片段用于处理
            exit when i > dbms_lob.getlength(c);
            v := replace(dbms_lob.substr(c, 32767, i), ' ', '');
            i := i + 20000;

            -- 利用正则表达式找到 <title> 标签的内容
            v := regexp_substr(v, '<title>.*?</title>', 1, 1);
            v := substr(v, 8, length(v) - 15);
            if v is not null then
                insert into webinfo values(
                    u,
                    'title',
                    null,
                    v
                );
            end if;
        end loop;
        commit;
    end;
end;
/
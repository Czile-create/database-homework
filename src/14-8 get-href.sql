set serveroutput on;
create or replace procedure get_link(u varchar2) is 
begin
    declare
        c clob;
        v varchar2(32767);
        l varchar2(32767);
        t varchar2(32767);
        i int := 1;
        j int := 1;
    begin
        c := http_get(u);
        <<first_loop>>
        loop
            -- 截取信息片段用于处理
            exit first_loop when i > dbms_lob.getlength(c);
            v := replace(dbms_lob.substr(c, 32767, i), ' ', '');
            i := i + 20000;
            j := 1;

            -- 利用正则表达式找到 <a> 标签的内容
            <<second_loop>>
            loop
                t := regexp_substr(v, '<a.*?</a>', 1, j);
                j := j + 1;
                exit second_loop when t is null;
                
                -- 找出链接
                l := regexp_substr(t, 'href=".*?"', 1, 1);
                l := substr(l, 7, length(l) - 7);
                if l like '/%' then
                    l := 'http://www.itpub.net' || l;
                end if;
                dbms_output.put_line(l);

                -- 找出描述
                t := regexp_substr(t, '>.*<', 1, 1);
                t := substr(t, 2, length(t) - 2);
                dbms_output.put_line(t);
            end loop;
        end loop;
        commit;
    end;
end;
/
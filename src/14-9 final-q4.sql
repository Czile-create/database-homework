create or replace procedure record_webinfo(u varchar2) is 
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
        bs(u);
        commit;
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
                if l like 'http:%' then
                    -- 记录
                    insert into webinfo values (
                        u,
                        'a',
                        'href',
                        l
                    );

                    -- 找出描述
                    t := regexp_substr(t, '>.*<', 1, 1);
                    t := substr(t, 2, length(t) - 2);
                    insert into webinfo values (
                        u,
                        'a',
                        null,
                        t
                    );
                    commit;
                    if l like '%itpub.net%' then
                        bs(l);
                    end if;
                end if;
            end loop;
        end loop;
        commit;
    end;
end;
/
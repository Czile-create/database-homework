declare 
    l_file  utl_file.file_type;
    l_text  varchar2(32767);
    i       number;
begin
    l_file := utl_file.fopen('DATA', '000001.SS.csv', 'R', 32767);
    for i in 1..6189 loop
        utl_file.get_line(l_file, l_text, 32767);
        if instr(l_text, 'null') = 0 then
            insert into ss001 values(
                regexp_substr(l_text, '[^,]+', 1, 1),
                regexp_substr(l_text, '[^,]+', 1, 2),
                regexp_substr(l_text, '[^,]+', 1, 3),
                regexp_substr(l_text, '[^,]+', 1, 4),
                regexp_substr(l_text, '[^,]+', 1, 5),
                regexp_substr(l_text, '[^,]+', 1, 6),
                regexp_substr(l_text, '[^,]+', 1, 7)
            );
        end if;
    end loop;
    utl_file.fclose(l_file);
    commit;
end;
/
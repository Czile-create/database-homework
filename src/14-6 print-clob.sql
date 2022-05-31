create or replace procedure print_clob(c clob) is
    i   int := 1;
begin    
    loop  
        exit when i > dbms_lob.getlength(c);  
        dbms_output.put_line(
            translate(replace(
                dbms_lob.substr(c, 255, i), '  ', ''
            ), chr(10)||chr(11)||chr(13), '   '
        ));  
        i := i + 255;  
    end loop;  
end;
/

set serveroutput on;
declare
    c clob;
begin
    c := http_get('itpub.net');
    print_clob(c);
end;
/
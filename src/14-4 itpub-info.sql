create or replace function http_get(u varchar2)
return clob as
begin
    declare
        resp    utl_http.html_pieces;
        txt     clob := '';
        i       pls_integer;
    begin
        resp := utl_http.request_pieces(u, 100);
        for i in 1..resp.count loop
            txt := txt || resp(i);
        end loop;
        return txt;
    end;
end;
/

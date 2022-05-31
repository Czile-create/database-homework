declare
    fname   varchar2(100);
    content blob;
    buffer  raw(32767);
    f       UTL_FILE.FILE_TYPE;
    csize   integer;
    bsize   integer;
    amount  integer;
    offset  number(38):= 1;
begin
    select  data 
    into    content 
    from    scott.filedata;

    select  fname
    into    fname
    from    scott.filedata;

    csize := dbms_lob.getchunksize(content);
    if (csize <= 32767) then
        bsize := csize;
    else
        bsize := 32767;
    end if;
    amount := bsize;
    dbms_lob.open(content, dbms_lob.lob_readonly);


    f := UTL_FILE.FOPEN(
        location      => 'DATA', 
        filename      => '[db] '||fname, 
        open_mode     => 'wb',
        max_linesize  => 32767
    );

    while amount >= bsize loop
        dbms_lob.read(
            lob_loc => content,
            amount  => amount,
            offset  => offset,
            buffer  => buffer
        );
        offset := offset + amount;
        utl_file.put_raw(
            file    => f,
            buffer  => buffer
        );
        utl_file.fflush(file => f);
    end loop;
    utl_file.fflush(file => f);
    utl_file.fclose(f);
    dbms_lob.close(content);
end;
/
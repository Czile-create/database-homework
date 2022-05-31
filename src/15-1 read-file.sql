declare
    fname   varchar2(100);
    fdata   blob;
    content blob;
    f       bfile;
begin
    fname := '15.pdf';
    f := bfilename('DATA', fname);

    insert into scott.filedata 
    values      (fname, empty_blob())
    returning   data
    into        content;

    dbms_lob.fileopen(f, dbms_lob.file_readonly);
    dbms_lob.loadfromfile(content, f, dbms_lob.getlength(f));
    dbms_lob.fileclose(f);
    commit;
end;
/
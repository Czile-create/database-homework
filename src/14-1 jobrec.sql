declare jobnum number := 1;
begin
    dbms_job.submit(
        :jobnum, 
        'emprec;', 
        sysdate, 
        'sysdate + 1/24/12'
    );
    commit;
end;
/
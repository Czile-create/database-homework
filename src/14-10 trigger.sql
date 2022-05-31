create or replace trigger emp_time
    before insert or update or delete on emp
begin
    if (to_char(sysdate,'DY') in ('星期六','星期日')) or
        (to_char(sysdate,'HH24') not between '08' and '18')
    then
        if deleting then 
            RAISE_APPLICATION_ERROR (-20502,'You may delete from
            EMP table only during business hours.');
        elsif inserting then
            RAISE_APPLICATION_ERROR (-20500,'You may insert into
            EMP table only during business hours.');
        elsif updating then
            RAISE_APPLICATION_ERROR (-20503,'You may update
            EMP only during business hours.');
        else
            RAISE_APPLICATION_ERROR (-20504,'You mayupdate
            EMP table only during normal hours.');
        end if;
    end if;
end; 
/ 
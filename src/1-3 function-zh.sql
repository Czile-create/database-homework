create or replace function zh (x in number)
return varchar2 is
    cn varchar2(2);
Begin
    cn := translate(
        to_char(mod(x, 10)), 
        '1234567890', 
        'Ò¼·¡ÈşËÁÎéÂ½Æâ°Æ¾ÁÁã'
    );
    return cn;
End;
/
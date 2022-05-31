create or replace function dx(x in float)
return varchar2 is
    cn varchar2(50);
Begin
    cn := translate(
        to_char(x, '099990.99'),
        '1234567890.', 
        'Ò¼·¡ÈşËÁÎéÂ½Æâ°Æ¾ÁÁãÔª'
    );
    cn := translate(
        '01Ê°2Íò3Çª4°Û5Ê°678½Ç9·Ö',
        '0123456789',
        cn
    );
    return cn;
End;
/
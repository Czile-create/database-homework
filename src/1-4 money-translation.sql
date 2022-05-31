create or replace function dx(x in float)
return varchar2 is
    cn varchar2(50);
Begin
    cn := translate(
        to_char(x, '099990.99'),
        '1234567890.', 
        'Ҽ��������½��ƾ���Ԫ'
    );
    cn := translate(
        '01ʰ2��3Ǫ4��5ʰ678��9��',
        '0123456789',
        cn
    );
    return cn;
End;
/
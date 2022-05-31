with analysis1 as (
    select 
        day,
        close,
        avg(close) over (
            order by day
            rows between 10 preceding and 1 preceding
        ) MA10,
        avg(close) over (
            order by day
            rows between 30 preceding and 1 preceding
        ) MA30
    from ss001
), analysis2 as (
    select 
        day, close, MA10, MA30,
        lag(MA10 - MA30) over(order by day) LAST_DAY,
        MA10 - MA30 TODAY
    from analysis1
), analysis3 as (
    select day,close,MA10,MA30,LAST_DAY,TODAY,
    case 
        when LAST_DAY < 0 and TODAY > 0 then 'GOLDEN'
        when LAST_DAY > 0 and TODAY < 0 then 'DEAD'
        else null
    end OPERATE 
    from analysis2
    where day >= '2012-05-01' and day <= '2022-05-01'
)
select * from analysis3;
select 1000000 * exp((
    select sum(ln(close)) from analysis3 where OPERATE = 'DEAD'
) - (
    select sum(ln(close)) from analysis3 where OPERATE = 'GOLDEN'
)) / 2363.43701 money from dual;
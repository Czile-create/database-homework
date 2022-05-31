with t1 as (
    select day, close,
        close - lag(close) over (order by day) gradient
    from ss001
), t2 as (
    select day, close,
        min(gradient) over (
            order by day
            rows between 2 preceding and current row
        ) min_gradient,
        max(gradient) over (
            order by day
            rows between 2 preceding and current row
        ) max_gradient
    from t1
), t3 as (
    select 
        day, close, min_gradient, max_gradient,
        case 
            when min_gradient > 0 then 'RISE'
            when max_gradient < 0 then 'DOWN'
            else null
        end status
    from t2
    where min_gradient * max_gradient > 0 and day >= '2012-05-01' and day <= '2022-05-01'
), t4 as (
    select close, status from (
        select close, status, lag(status) over (order by day) ls from t3
    ) where status <> ls
)
select 1000000 * exp((
    select sum(ln(close)) from t4 where status = 'RISE'
) - (
    select sum(ln(close)) from t4 where status = 'DOWN'
)) money from dual;

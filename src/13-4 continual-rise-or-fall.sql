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
)
select 
    day, close, min_gradient, max_gradient,
    case 
        when min_gradient > 0 then 'RISE'
        when max_gradient < 0 then 'DOWN'
        else null
    end status
from t2
where min_gradient * max_gradient > 0 and day >= '1997-07-05';
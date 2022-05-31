with analysis1 as (
    select 
        to_char(num) num, time, station, 
        lag(station) over (
           partition by num
            order by time 
        ) lagstation,
        time - lag(time) over (
            partition by num
            order by time
        ) t
    from phone
), analysis2 as (
    select * from analysis1
    where t is not null
)
select  num, lagstation station,
        sum(t), grouping(lagstation)
from analysis2
group by rollup(num, lagstation);
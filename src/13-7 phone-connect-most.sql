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
), analysis3 as (
    select  num, lagstation station,
            sum(t) s, grouping(lagstation) g,
            rank() over (partition by num order by sum(t) desc) r
    from analysis2
    group by rollup(num, lagstation)
)
select num, station, s time from analysis3
where r <= 4 and r >= 2;
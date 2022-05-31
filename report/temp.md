```sql
select a.ename i, b.ename j from emp a, emp b
where b.empno in (
    select empno from emp
    start with empno = a.empno
    connect by prior mgr = empno or empno = mgr
) and a.ename <> b.ename;

with children(n) as (
    select level l, ename from emp
    start with ename = children.n
    connect by prior empno = mgr
), parents(n) as (
    select level l, ename from emp
    start with empno = parents.n
    connect by prior mgr = empno
)
select l, ename from parents where name = 'SMITH';


select e1.ename, (
    select ename from emp 
    start with 
    select ename from emp e2 where ename in (
        select level from emp
        start with ename = e1.ename
        connect by prior mgr = empno
    )
) from emp e1;
```
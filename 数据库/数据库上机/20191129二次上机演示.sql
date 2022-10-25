select ename,empno,sal
from emp
where deptno in
(
select deptno
from dept
where loc='new york')

select sum(sal)
from emp
where deptno in (select deptno
                 from emp
                 where ename='blake')

select *
from emp
where deptno not in(
				 select deptno
                 from emp
                 where ename='blake')
and job in (select job 
            from emp
			where deptno in(
				 select deptno
                 from emp
                 where ename='blake'))

           =    <>    >=      <=
some/any  in    --    >=min   <=max
all       --  not in  >=max   <=min 

select id,name
from student
where id  <>all (select id
           from takes
		   where course_id='cs-347')


select ename
from emp
where sal =some(
		   select sal
		   from emp
		   where deptno=30)
		   and deptno <>30

select ename
from emp
where sal>all(
		   select avg(sal)
		   from emp
		   group by deptno)

select ename
from emp 
where empno not in (select distinct mgr
                    from emp
					where mgr is not null)

select ename,sal
from emp
where sal not in (1000,2000,3000,null)

select avg(sal),deptno
from emp
group by deptno
having avg(sal)>=all(
                   select avg(sal)
                   from emp
                   group by deptno)

select <>
from <>
where ...in/not in/some/all
(select <>
 from <>
 where<>)

    select course_id   
	from section as S   
	where semester = 'Fall' and year= 2009 and 
	        exists (select *                           
				  from section as T        
				where semester = 'Spring' and year= 2010                                         
				and S.course_id= T.course_id);





select *
from emp a
where not exists (select *
                    from emp b
					where a.empno=b.mgr
					)
select name
from student s
where not exists (select 1
                  from takes t
				  where s.ID=t.id and course_id='cs-347' )
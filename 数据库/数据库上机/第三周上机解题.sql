
--1
insert into instructor
select id,name,dept_name,40000
from student
where id in (select id from takes where grade is null);
--2
delete from instructor
where id in (select id from student);
--3
with tmp(id,tot_credit) 
as(select distinct id,sum(credits) from teaches t join course c on t.course_id = c.course_id group by id)
update instructor
set salary = salary + 1120 * (select tot_credit from tmp where instructor.id = tmp.id)
where id in (select id from teaches);
--4
with tmp(id,point)
as(select id,case when grade = 'A+'	then 10.5
				  when grade = 'A'	then 10
				  when grade = 'A-'	then 9.5
				  when grade = 'B+'	then 8.5
				  when grade = 'B'	then 8
				  when grade = 'B-'	then 7.5
				  when grade = 'C+'	then 6.5
				  when grade = 'C'	then 6
				  when grade = 'C-'	then 5.5
				  when grade = 'D+'	then 4.5
				  when grade = 'D'	then 4
				  when grade = 'D-'	then 3.5
				  when grade = 'F'	then 0
				  end
	from takes)
select s.id,name,count(*) 'count of course',avg(point) 'avg_grade point'
from student s left join tmp t on s.id = t.id
where s.id not in (select id from takes where grade is null)
group by s.id,name;
--5
with con(bud,con)
as (select building,count(*) from section group by sec_id,semester,year,building,time_slot_id)
select room_number,building,sec_id
from section join con on building = bud
where con > 1;
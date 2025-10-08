-- Q11
select dept_name
from department d
where (select sum(s.fee_paid) from student s where s.dept_id = d.dept_id) > 1000000;

-- Q12
select d.dept_name 
from department d 
where (
    select count(*) from faculty f where d.dept_id = f.dept_id and f.salary > 100000
) > 5;

-- Q13
delete from student
where gpa < (select avg(gpa) from student);

-- Q14
delete from course c where c.course_id not in (select en.course_id from enrollment en);

-- Q15
create table HighFee_Students as
select s.* from students s
where s.student_id in (
    select en.student_id from enrollment en
    where en.course_id in (
        select c.course_id from course c
        where c.fee > (select avg(fee) from course)
    )
);

-- Q16
create table Retired_Faculty as
select *
from faculty
where joining_date < (
    select min(joining_date)
    from faculty
);

-- Q17
select * from (select dept_id from students group by dept_id order by sum(fee_paid)) where rownum = 1;

-- Q18
select * from (select course_id from enrollment group by course_id order by count(student_id)) where rownum <= 3;

-- Q19
select student_id, student_name from students 
where student_id in (
    select student_id from enrollment
    group by student_id
    having count(course_id) > 3
) and gpa > (select avg(gpa) from students);

-- Q20
create table Unassigned_Faculty as
select * from faculty
where faculty_id not in (select faculty_id from faculty_course);
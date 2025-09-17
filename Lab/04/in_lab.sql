-- Q1
select d.dept_id, (select count(*) from student s where d.dept_id = s.dept_id) from department d; 

-- Q2
select dept_name
from department d
where (select avg(s.gpa) from student s where s.dept_id = d.dept_id) > 3.0;

-- Q3
select
  c.course_name,
  round((select avg(s.fee_paid)
  from enrollment e, student s
  where e.student_id = s.student_id
    and e.course_id = c.course_id), 2) AS avg_fee
from course c;

-- Q4
select d.dept_name, (select count(*) from faculty f where d.dept_id = f.dept_id) from department d;

-- Q5
select * from faculty where salary > (select avg(salary) from faculty);

-- Q6
select student_name, gpa from student s where gpa > (select min(gpa) from student where dept_id = 1);

-- Q7
select *
from (select student_name, gpa from student order by gpa desc)
where rownum <= 3;

-- Q8
select s.student_name 
from student s
where s.student_id in (
    select unique e2.student_id 
    from enrollment e2 
    where e2.course_id in (
        select e.course_id 
        from enrollment e 
        where e.student_id = (
            select s.student_id from student s where s.student_name = 'Ali'
        )
    )
);

-- Q9
select dept_name,
  (select sum(s.fee_paid) from Student s where s.dept_id = d.dept_id) as total_fees
from Department d;

-- Q10
select unique c.course_name 
from course c 
where c.course_id in (
    select e.course_id 
    from enrollment e 
    where e.student_id in (
        select s.student_id 
        from student s 
        where s.gpa > 3.5
    )
);
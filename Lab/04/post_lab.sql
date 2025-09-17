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


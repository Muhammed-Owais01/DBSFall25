-- Q11
alter table student add city varchar(20);
alter table teacher add city varchar(20);

update student set city = 'karachi';
update teacher set city = 'karachi';

select s.student_name, t.teacher_name from student s join teacher t on s.city = t.city;

-- Q12
select e1.emp_name as emp_name, e2.emp_name as mgr_name from employee e1 left join employee e2 on e1.mgr_id = e2.emp_id;
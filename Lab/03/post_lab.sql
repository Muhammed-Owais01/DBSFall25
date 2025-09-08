-- Q11
alter table employees modify bonus number(6,2) constraint uniq_bonus unique;
insert into employees values (4, 'Alice', 25000, 3, 2000, 'Karachi', 23, 'alice@email.com');
insert into employees values (5, 'James', 21000, 3, 2000, 'Karachi', 22, 'james@email.com'); -- Error Due To Unique Constraint

-- Q12
alter table employees add DOB date constraint chk_dob_age_gt18 check((dob <= DATE '2007-09-08'));

-- Q13
insert into employees values (5, 'James', 21000, 3, 4000, 'Karachi', 22, 'james@email.com', '02-02-2008'); -- Not A Valid Month

-- Q14
alter table employees drop constraint fk_employees_dept;
insert into employees (emp_id, full_name, salary, dept_id, bonus, city, age, email, dob) values (6, 'Mark', 22000, 99, 3000, 'Lahore', 25, 'mark@email.com', DATE '1999-05-05');
alter table employees add constraint fk_employees_dept foreign key (dept_id) references departments(dept_id); -- Error as 99 does not exist in the dept_id of departments table

-- Q15
alter table employees drop (age, city);

-- Q16
select e.emp_id, e.full_name, d.dept_id, d.dept_name from employees e join departments d on e.dept_id = d.dept_id;

-- Q17
alter table employees rename column salary to monthly_salary;

-- Q18
select d.* from departments d where (select count(*) from employees e where d.dept_id = e.dept_id) = 0;

-- Q19
delete from employees;

-- Q20
select dept_id, count(*) as total_employees from employees group by dept_id having count(*) = (select max(count(*)) from employees group by dept_id);

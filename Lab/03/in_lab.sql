-- Q1 
create table employees (
    emp_id int primary key,
    emp_name varchar(100) not null,
    salary int constraint chk_salary_gt20k check(salary > 20000),
    dept_id int
);

-- Q2
alter table employees rename column emp_name to full_name;

-- Q3
alter table employees drop constraint chk_salary_gt20k;
insert into employees values (1, 'Josh', 5000, 2);

-- Q4
create table departments (
    dept_id int primary key,
    dept_name varchar(50) unique
);

insert into departments values (1, 'HR');
insert into departments values (2, 'Finance');
insert into departments values (3, 'IT');

-- Q5
alter table employees add constraint fk_employees_dept foreign key (dept_id) references departments(dept_id);

-- Q6
alter table employees add bonus number(6,2) default 1000;

-- Q7
alter table employees add city varchar(20) default 'Karachi';
alter table employees add age int constraint chk_age_gt18 check(age >= 18);

-- Q8
insert into employees (emp_id, full_name, salary, dept_id, age) values (2, 'Simon', 4000, 1, 22);
insert into employees (emp_id, full_name, salary, dept_id, age) values (3, 'Ethan', 20000, 3, 25);
delete from employees where emp_id in (1,3);

-- Q9
alter table employees modify full_name varchar(20);
alter table employees modify city varchar(20);

-- Q10
alter table employees add email varchar(50) constraint uniq_email unique;
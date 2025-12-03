create table employee (
    emp_id int primary key,
    emp_name varchar(100),
    dpt_id int
);

create table department (
    dpt_id int primary key,
    dpt_name varchar(50)
);

alter table employee add constraint fk_dpt_id foreign key (dpt_id) references department(dpt_id);

insert into department values(1, 'CS');
insert into department values(2, 'AI');
insert into department values(3, 'DS');

insert into employee values(1, 'Alice', 2);
insert into employee values(2, 'Bob', 1);
insert into employee values(3, 'Charlie', 3);
insert into employee values(4, 'David', 1);
insert into employee values(5, 'Ethan', 2);
insert into employee values(6, 'Frank', 3);

-- Q1
select e.*, d.* from employee e cross join department d;

-- Q2
select * from department d left join employee e on d.dpt_id = e.dpt_id;

-- Q3
alter table employee add mgr_id int;

update employee set mgr_id = 1 where EMP_ID in (2, 3);

select e1.emp_name, e2.emp_name from employee e1 inner join employee e2 on e1.mgr_id = e2.emp_id;

-- Q4
create table emp_project (
    proj_id int primary key,
    proj_name varchar(20)
);

alter table employee add (proj_id int, foreign key (proj_id) references emp_project(proj_id));

insert into emp_project values (1, 'Orange');
insert into emp_project values (2, 'Apple');
insert into emp_project values (3, 'Mango');

update employee set proj_id = 1 where emp_id in (1, 3, 4);
update employee set proj_id = 2 where emp_id in (2, 5);

select * from employee where proj_id is null;



-- Q5
create table student (
    student_id int primary key,
    student_name varchar(100),
    gpa number(3,2),
    crs_id int,
    foreign key (crs_id) references course(crs_id)
);

insert into student values (1, 'Alice', 3.8, null);
insert into student values (2, 'Bob', 3.5, null);
insert into student values (3, 'Charlie', 3.9, null);
insert into student values (4, 'David', 2.9, null);
insert into student values (5, 'Emma', 3.7, null);

create table course (
    crs_id int primary key,
    crs_name varchar(20)
);

alter table student add (crs_id int, foreign key (crs_id) references course(crs_id));

insert into course values (1, 'FT');
insert into course values (2, 'CS');

update student set crs_id = 2 where student_id = 1;

select s.student_name, c.crs_name from student s inner join course c on s.crs_id = c.crs_id;

-- Q6
create table customer (
    customer_id int primary key,
    customer_name varchar(100)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    foreign key (customer_id) references customer(customer_id)
);

insert into customer values (1, 'John');
insert into customer values (2, 'Emma');
insert into customer values (3, 'Sophia');

insert into orders values (101, 1, to_date('2025-09-01', 'YYYY-MM-DD'));
insert into orders values (102, 2, to_date('2025-09-02', 'YYYY-MM-DD'));

select c.customer_name, o.order_id, o.order_date
from customer c
left join orders o on c.customer_id = o.customer_id;

-- Q7
select d.dpt_name, e.emp_name
from department d
left join employee e on d.dpt_id = e.dpt_id;

-- Q8
create table teacher (
    teacher_id int primary key,
    teacher_name varchar(100)
);

create table subject (
    subject_id int primary key,
    subject_name varchar(100)
);

insert into teacher values (1, 'Dr. Smith');
insert into teacher values (2, 'Prof. Johnson');

insert into subject values (1, 'Math');
insert into subject values (2, 'Science');

select t.teacher_name, s.subject_name
from teacher t
cross join subject s;

-- Q9
select d.dpt_name, count(e.emp_id) as total_employees
from department d
left join employee e ON d.dpt_id = e.dpt_id
group by d.dpt_name;

-- Q10
alter table course add (teacher_id int, foreign key (teacher_id) references teacher(teacher_id));

insert into student values (1, 'Alice');
insert into student values (2, 'Bob');

insert into teacher values (1, 'Dr. Taylor');
insert into teacher values (2, 'Prof. Parker');

insert into course values (1, 'Math', 1);
insert into course values (2, 'Science', 2);

update student set crs_id = 1 where student_id = 1;
update student set crs_id = 2 where student_id = 2;

select s.student_name, c.crs_name, t.teacher_name
from student s
inner join course c on s.crs_id = c.crs_id
inner join teacher t on c.teacher_id = t.teacher_id;

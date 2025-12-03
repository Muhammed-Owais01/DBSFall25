set serveroutput on

declare
    sec_name varchar(20) := 'Sec-A';
    course_name varchar(20) := 'DB Lab';
begin
    dbms_output.put_line('This is ' || sec_name || ' and the course is ' || course_name);
end;
/

declare
    a integer := 10;
    b integer := 20;
    c integer;
    d real;
begin
    c := a + b;
    dbms_output.put_line('Value of c is ' || c);
    d := 70.0/3.0;
    dbms_output.put_line('Value of d is ' || d);
end;
/

declare
    num1 number := 95;
    num2 number := 85;
begin
    dbms_output.put_line('Outer Variable num1: ' || num1);
    dbms_output.put_line('Outer Variable num2: ' || num2);
    declare
        num1 number := 195;
        num2 number := 185;
    begin
        dbms_output.put_line('Inner Variable num1: ' || num1);
        dbms_output.put_line('Inner Variable num2: ' || num2);
    end;
end;
/

declare
    e_id employees.employee_id%type;
    e_fname employees.first_name%type;
    e_lname employees.last_name%type;
    d_name departments.department_name%type;
begin
    select employee_id, first_name, last_name, department_name into e_id, e_fname, e_lname, d_name
    from employees inner join departments on employees.department_id = departments.department_id and employee_id = 100;
    dbms_output.put_line('Employee ID: ' || e_id);
    dbms_output.put_line('First Name: ' || e_fname);
    dbms_output.put_line('Last Name: ' || e_lname);
    dbms_output.put_line('Department Name: ' || d_name);
end;
/

-- IF THEN ELSE
declare
    e_id employees.employee_id%type := 100;
    e_sal employees.salary%type;
begin
    select salary into e_sal from employees where employee_id = e_id;
    if (e_sal >= 5000) then
        update employees set salary = e_sal + 1000;
        dbms_output.put_line('Salary updated');
    end if;
end;
/

declare
    n_count number;
    e_id employees.employee_id%type := 1100;
begin
    select count(1) into n_count from employees where employee_id = e_id;
    if n_count > 0 then
        dbms_output.put_line('Record Already Exists.');
    else
        insert into employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        values (e_id, 'Bruce', 'Austin', 'DAUSTIN7', '590.423.4569', '25-JUN-05', 'IT_PROG', 6000, 0.2,100,60);
        dbms_output.put_line('Record Insert With Employee ID: ' || e_id);
    end if;
end;
/

-- CASE
declare
    e_id employees.employee_id%type := 100;
    e_sal employees.salary%type;
    e_did employees.department_id%type;
begin
    select salary, department_id into e_sal, e_did from employees where employee_id = e_id;
    case when e_did = 80 then
        update employees set salary = e_sal + 1000 where employee_id = e_id;
        dbms_output.put_line('Salary Updated: ' || e_sal);
    when e_did = 50 then
        update employees set salary = e_sal + 2000 where employee_id = e_id;
        dbms_output.put_line('Salary Updated: ' || e_sal);
    else
        dbms_output.put_line('No such record');
    end case;
end;
/

-- Loop
declare
begin
    for user_record in (select first_name, salary, hire_date from employees where department_id = 80)
    loop
        dbms_output.put_line('User name is ' || user_record.first_name || ', salary is ' || user_record.salary || ', and hire date is ' || user_record.hire_date);
    end loop;
end;
/

-- Views
create or replace view simple_employee_view as
select employee_id, first_name, last_name, email, salary from employees where department_id = 80;

select * from simple_employee_view;

create or replace view complex_emp_dpt_view as 
select e.employee_id, e.first_name, e.last_name, d.department_name, e.salary from employees e
join departments d on d.department_id = e.department_id
where e.salary > 5000;

select * from complex_emp_dpt_view;

create materialized view mat_emp_dept as
select distinct employees.employee_id, employees.first_name, employees.email, departments.department_name 
from employees inner join departments on employees.department_id = departments.department_id
where employees.department_id = 80;

select * from mat_emp_dept;

-- Functions
create or replace function calculateSAL(dept_id in number) return number 
is total_salary number; -- Local Variables of function
begin
    select sum(salary) into total_salary from employees where department_id = dept_id;
    return total_salary;
end;
/

select calculateSAL(80) from dual;

-- Objects
create or replace type employees_type as object (
    emp_id number,
    emp_name varchar(20),
    hire_date date,
    member function years_of_service return number
);
/

create or replace type body employees_type as
    member function years_of_service return number is 
    begin
        return trunc(MONTHS_BETWEEN(sysdate, hire_date) / 12);
    end;
end;
/

create table employees_data of employees_type (
    primary key (emp_id)
);
insert into employees_data values (employees_type(3, 'Aqsa', DATE '2023-08-13'));
insert into employees_data values (employees_type(4, 'Amna', DATE '2024-01-13'));

select e.emp_id, e.emp_name, e.hire_date from employees_data e;
select * from EMPLOYEES_DATA;

select e.emp_name, e.years_of_service() as years_with_company
from employees_data e;

create or replace type emp_obj_type as object (
    emp_id number,
    first_name varchar(20),
    last_name varchar(20),
    department_id number
);
/

create or replace type emp_tbl_type as table of emp_obj_type;
/

create or replace function getall(emp_id in number) return emp_tbl_type is
    employee_id number;
    first_name varchar(20);
    last_name varchar(20);
    department_id number;
    emp_details emp_tbl_type := emp_tbl_type();
begin
    emp_details.extend();
    
    select employee_id, first_name, last_name, department_id
    into employee_id, first_name, last_name, department_id
    from employees where employee_id = emp_id;
    
    emp_details(1) := emp_obj_type(employee_id, first_name, last_name, department_id);
    
    return emp_details;
end;
/

create or replace function getall1 return emp_tbl_type
is emp_details emp_tbl_type := emp_tbl_type();
begin
    select emp_obj_type(employee_id, first_name, last_name, department_id)
    bulk collect into emp_details from employees;
    
    return emp_details;
end;
/
 
select * from table(getall(100));    
select * from table (getall1);

-- Procedures
create or replace procedure select_all is
    begin
        for c in (select * from employees)
        loop
            dbms_output.put_line('Name is ' || c.first_name);
            dbms_output.put_line('Salary is ' || c.salary);
        end loop;
    end;
/

execute select_all;

create or replace procedure insert_data(e_id number, e_name varchar, hire_date date) 
    is user_exists number;
    begin
        select count(*) into user_exists from employees_data where emp_id = e_id;
        if user_exists = 0 then
            insert into employees_data values (e_id, e_name, hire_date);
            dbms_output.put_line('Employee ' || e_id || ' ' || e_name || ' ' || hire_date);
        else
            dbms_output.put_line('Error ' || e_id || ' already exists');
        end if;
    end;
/

execute insert_data(e_id => 6, e_name => 'RAFAY', hire_date => DATE '2023-08-12');

-- CURSOR
declare
    cursor emp_cursor is
        select first_name, salary from employees where department_id = 80;
    v_name employees.first_name%type;
    v_salary employees.salary%type;
    begin
        open emp_cursor;
        loop
            fetch emp_cursor into v_name, v_salary;
            exit when emp_cursor%NOTFOUND;
            dbms_output.put_line(v_name || ' earns ' || v_salary);
        end loop;
    end;
/
        
        
        
        
        
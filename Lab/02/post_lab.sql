select lpad(first_name, 15, '*') from employees;

select ltrim(' oracle', ' ') from dual;

select initcap(first_name) from employees;

select next_day('20-AUG-2022', 'Monday') from dual;

select to_char(to_date('25-DEC-2023'), 'MM-YYYY') from dual;

select distinct salary from employees order by salary asc;

select employee_id, round(salary, -2) from employees;

select department_id, count(*) from employees group by department_id having count(*) = (select max(dept_count) from (select count(*) as dept_count from employees group by department_id));

select * from (select department_id, sum(salary) from employees group by department_id order by sum(salary) desc) where rownum <= 3;

select department_id, count(*) from employees group by department_id having count(*) = (select max(dept_count) from (select count(*) as dept_count from employees group by department_id)); 
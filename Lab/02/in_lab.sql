select sum(salary) as total_salary from employees;

select avg(salary) as average_salary from employees;

select manager_id, COUNT(*) from employees where manager_id is not null group by manager_id;

select * from employees where salary = (select min(salary) from employees);

select to_char(sysdate, 'DD-MM-YYYY') from dual;

select to_char(sysdate, 'DAY MONTH YEAR') from dual;

select * from employees where to_char(hire_date, 'Day') = 'Wednesday';

select months_between(to_date('01-JAN-2025', 'DD-MON-YYYY'), to_date('31-OCT-2024', 'DD-MON-YYYY')) as month_diff from dual;

select employee_id, round(months_between(sysdate, hire_date)) as months_worked from employees;

select substr(last_name, 1, 5) from employees;
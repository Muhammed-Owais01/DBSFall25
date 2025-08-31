-- Q1. Find the total salary of all employees.
select sum(salary) as total_salary from employees;

-- Q2. Find the average salary of employees.
select avg(salary) as average_salary from employees;

-- Q3. Count the number of employees reporting to each manager.
select manager_id, COUNT(*) from employees where manager_id is not null group by manager_id;

-- Q4. Select * employees who has lowest salary.
select * from employees where salary = (select min(salary) from employees);

-- Q5. Display the current system date in the format DD-MM-YYYY.
select to_char(sysdate, 'DD-MM-YYYY') from dual;

-- Q6. Display the current system date with full day, month, and year (e.g., MONDAY AUGUST 2025).
select to_char(sysdate, 'DAY MONTH YEAR') from dual;

-- Q7. Find all employees hired on a Wednesday.
select * from employees where to_char(hire_date, 'Day') = 'Wednesday';

-- Q8. Calculate months between 01-JAN-2025 and 01-OCT-2024.
select months_between(to_date('01-JAN-2025', 'DD-MON-YYYY'), to_date('31-OCT-2024', 'DD-MON-YYYY')) as month_diff from dual;

-- Q9. Find how many months each employee has worked in the company (using hire_date).
select employee_id, round(months_between(sysdate, hire_date)) as months_worked from employees;

-- Q10.Extract the first 5 characters from each employee’s last name.
select substr(last_name, 1, 5) from employees;
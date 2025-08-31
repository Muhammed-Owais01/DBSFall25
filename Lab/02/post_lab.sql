-- Q11. Pad employee first names with * on the left side to make them 15 characters wide.
select lpad(first_name, 15, '*') from employees;

-- Q12. Remove leading spaces from &#39; Oracle&#39;.
select ltrim(' oracle', ' ') from dual;

-- Q13. Display each employee’s name with the first letter capitalized.
select initcap(first_name) from employees;

-- Q14. Find the next Monday after 20-AUG-2022.
select next_day('20-AUG-2022', 'Monday') from dual;

-- Q15. Convert &#39;25-DEC-2023&#39; (string) to a date and display it in MM-YYYY format.
select to_char(to_date('25-DEC-2023'), 'MM-YYYY') from dual;

-- Q16. Display all distinct salaries in ascending order.
select distinct salary from employees order by salary asc;

-- Q17. Display the salary of each employee rounded to the nearest hundred.
select employee_id, round(salary, -2) from employees;

-- Q18. Find the department that has the maximum number of employees.
select department_id, count(*) from employees group by department_id having count(*) = (select max(dept_count) from (select count(*) as dept_count from employees group by department_id));

-- Q19. Find the top 3 highest-paid departments by total salary expense.
select * from (select department_id, sum(salary) from employees group by department_id order by sum(salary) desc) where rownum <= 3;

-- Q20. Find the department that has the maximum number of employees.
select department_id, count(*) from employees group by department_id having count(*) = (select max(dept_count) from (select count(*) as dept_count from employees group by department_id)); 
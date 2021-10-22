-- List all data from the departments table.
select * from departments;

-- List all data from the employees table
select * from employees;

-- Write a query to display the last name, 
-- job id, hire date and employee ID for each employee with the employee ID column listed first.
-- Provide an alias of start date for the hire date column.
select employee_id, job_id, hire_date as "start date" from employees;

-- List all the unique job IDS from the employees table.
select distinct(job_id) from employees;

-- Write a query to list all employees and job IDs in a single column output with a comma and a space between the last name and the job id. 
select first_name || ' ' || last_name || ', ' || job_id as "Employee, Job ID" from employees;

-- Write a query to list employees last name, department ID and salary for employees with a salary between 3000 and 4000.
select last_name, department_id, salary from employees where salary > 3000 and salary < 4000;

-- Write a query to display the first name, the last name, the hiredate and the salary for employees with a name of Tobias end Jones.
-- Sort the output by salary.
select first_name, last_name, hire_date, salary from employees where first_name = 'Tobias' or first_name = 'Jones' order by salary;

-- Display the last name and department ID of employees in departments 30 or 80 in ascending alphabetical order by name.
select last_name, department_id from employees where department_id = 30 or department_id = 80 order by last_name;

-- List all employees with a hire date in 2005.
select * from employees where extract(year from hire_date) = 2005; 

--Write a query to list employees who have no manager.
select * from employees where manager_id is null;

-- Write a query to show show the last name, salary and commission of all employees who earn a commission.
-- Sort the data in ascending order of salary.
select last_name, salary, commission_pct  from employees where commission_pct is not null order by salary;

-- Write a query to list all employees where the third character is a g.
select last_name  from employees where last_name like '__e%';

-- List all employees that have a commission of 20%
select * from employees where commission_pct = '0.2';

-- Write a query to list all employees their last name their salary and include a new salary column which is their original salary plus a 30% increase.
select last_name as "Last Name", salary as "Salary", (salary + (salary * 0.3)) as "New Salary" from employees 

-- Write a query that lists the employees last name and the length of the last name.
select last_name, length(last_name) from employees

-- Write a query that lists employee last name and calculate how many weeks they have worked for the company. Hint: (current_date-hire_date).
select last_name, round((current_date - hire_date)/7) as "Weeks hired" from employees

-- Write a query that Returns employee last name in uppercase and employ first name in lowercase.
select upper(last_name), lower(first_name) from employees

-- Write a query that lists the highest salary, The sum of all salaries, the average salary and the minimum salary of all employees.
select max(salary), min(salary), avg(salary), sum(salary) from employees

-- Write a query to display the number of people working in each department.
 select department_id, count(department_id) from employees group by department_id

-- Write a query to determine the number of Managers in the employees table. Hint: the result is 18.
select count(distinct(manager_id)) from employees

-- Write a query to find the difference between the highest and the lowest salary give the column alias of difference.
select (max(salary) - min(salary)) as "Difference" from employees

-- Write a query to display the manager number and the salary of the highest paid employee for that manager.
select manager_id, max(salary) as "max" from employees where manager_id is not null group by manager_id order by "max" desc fetch first 1 rows only

-- Write a query that lists the employee first name, last name, job id and department name for all employees and their departments.
---Hint: you need to join the employees and department tables for this.
select e.first_name, e.last_name, e.job_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id

-- Write a query that joins the employees table to the employees table so you can display an employee last name and their managers last name. 
-- Hint: remember to give the employees tables two different aliases.
select e.last_name as "Employee Last Name", m.last_name as "Manager Last Name"
from employees e left join employees m
on m.employee_id = e.manager_id 
order by m.last_name

-- Write a query that shows the names and addresses of all departments. You need to join locations, countries and departments.
select d.department_name as "Department Name", l.street_address || ', ' || l.city 
|| ', ' || l.state_province || ', ' || c.country_name as "Address"
from departments d
inner join locations l
on d.location_id = l.location_id
inner join countries c
on l.country_id = c.country_id

-- Write a query to list employee last names who were hired after ‘Bull’.
select e.last_name, e.hire_date from employees e 
where e.hire_date > (select e1.hire_date from employees e1 where e1.last_name = 'Bull') 

-- --Write a query that shows the name, the location and the number of employees for department. 
-- Make sure all departments are included even the ones without employees.
select d.department_name as "Department Name", 
l.street_address || ', ' || l.city as "Department Address",
(select count(e.department_id) from employees e where e.department_id = d.department_id) as "Number of employees"
from departments d
inner join locations l
on d.location_id = l.location_id


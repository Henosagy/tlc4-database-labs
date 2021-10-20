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

select * from employee;
select * from department;
select * from project;


#1 Retrieve all employee records ordered by salary in descending order
select * from employee order by salary desc;

#2 Display only the top 4 highest paid employees.
 select emp_name from employee order by salary desc limit 4;

 #3 Display employees who joined before the year 2021.
select * from employee where join_date < '2021-01-01';

#4 Display employees whose salary is between 40,000 and 80,000.
select emp_name from employee where salary>=40000 and salary <=80000;

#5 Display employees whose names end with the letter a
select * from employee where emp_name like '%a';
#6 Display employees who are not assigned to any department.
select * from employee where dept_id is NULL;

#7 Display department-wise total salary.
select dept_name as Department, sum(salary) as total_salary
from employee as e
left join department as d
on e.dept_id=d.dept_id
GROUP BY  dept_name;

#8 Display department-wise average salary where the average salary is greater than 55,000.
select dept_name as Department,AVG(salary)
from employee as e
left join department as d
on e.dept_id=d.dept_id
group by dept_name
having AVG(salary)>55000;

#9 Display the number of employees working in each department.

select count(emp_id) as Total_Employee,dept_name as Department
from employee as e
left join department as d
on e.dept_id=d.dept_id
group by dept_name;

#10 Display only departments where more than one employee works.
select dept_name as Department,count(e.emp_id) as Total_Employees
from employee as e
left join department as d
on e.dept_id=d.dept_id
group by dept_name
having COUNT(e.emp_id)>1;

#11 Display employee name and department name.
select emp_name,dept_name from employee as e
inner join department as d
on e.dept_id=d.dept_id;

#12 Display all employees including those who do not belong to any department.
SELECT 
    e.emp_id, 
    e.emp_name, 
    e.dept_id, 
    e.salary, 
    e.join_date, 
    d.dept_name
FROM employee e
LEFT JOIN department d ON e.dept_id = d.dept_id;

#13 Display all departments including those that have no employees.
select d.dept_id as id,d.dept_name as department_name
from department as d
left join employee as e
on d.dept_id=e.dept_id;

#14 Display department name and highest salary in that department.
SELECT dept_name as Department,max(salary) as Highest_Salary
from department as d
left join employee as e
on d.dept_id=e.dept_id
GROUP BY dept_name;

#15 Display employees working in the Finance department.

select e.emp_name as NAME
from employee as e
left join department as d
on e.dept_id=d.dept_id
where dept_name='Finance';

#16 Display employee name, department name, salary ordered by salary descending.
select e.emp_name as Employee_Name,d.dept_name as Department,Salary
from employee as e
left join department as d
on e.dept_id=d.dept_id
order by salary desc;

#17 Display the second highest salary.
select e.emp_name as Name,e.salary as Salary
from employee as e
order by salary DESC
limit 1,1;

#18 Display employees whose salary is greater than the average salary.
select e.emp_name as Name,e.salary as Salary
from employee as e
where salary >(select avg(salary) from employee);
#condition where we cannot use group by so no having an still we need to use aggregate as aggregate cannot be directly used inside where clause so we need to take help of subquery

#19 Display department-wise employee count including departments with zero employees.

select d.dept_name as Department,count(e.emp_id) as Employee_Count
from department as d
left JOIN employee as e
on d.dept_id=e.dept_id
GROUP BY dept_name;

#20 Display employees who are working on at least one project.

select e.emp_name as Employee ,count(p.proj_id) as Project_Count
from employee as e
left join project as p
on e.emp_id=p.emp_id
GROUP BY e.emp_name
HAVING COUNT(p.proj_id)>=1;
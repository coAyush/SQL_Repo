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

#21 Display employees who are not working on any project.
select e.emp_id as Id,e.emp_name as Employees
from employee as e
left join project as p
on e.emp_id=p.emp_id
where p.proj_id is null;

#22 Display total project hours worked by each employee.

select e.emp_name as Employee,sum(p.hours) as Total_Hours
from employee as e
left join project as p
on e.emp_id=p.emp_id
group by e.emp_name
order by Total_Hours desc;

#23 Display employees whose total project hours are greater than 150.
select e.emp_name as Employee,sum(p.hours) as Total_Hours
from employee as e
left join project as p
on e.emp_id=p.emp_id
GROUP BY(e.emp_name)
having SUM(p.hours)>150
order by Total_Hours desc;

#24 Display the employee who has worked the maximum total hours.
select e.emp_name as Employee,sum(p.hours) as Total_Hours
from employee as e
left join project as p
on e.emp_id=p.emp_id
GROUP BY(e.emp_name)
order by Total_Hours desc
limit 1;

#25 Display department-wise total project hours.
select d.dept_name as Department, coalesce(sum(p.hours),0) as Total_Hours
from employee as e
left join project as p
on e.emp_id=p.emp_id
left join department as d
on e.dept_id=d.dept_id
GROUP BY d.dept_name,d.dept_id
order by Total_Hours desc;

#26 Display departments whose total project hours exceed 200.
select d.dept_name as Depatments,sum(p.hours) as HOUR
from department as d
left join employee as e
on d.dept_id=e.dept_id
left join project as p
on e.emp_id=p.emp_id
group by d.dept_name,d.dept_id
having sum(p.hours)>200
order by Hour desc;

#27 Display employees from the Sales department who joined after 2021.
select e.emp_name as Employee
from employee as e
left join department as d
on e.dept_id=d.dept_id
where join_date > '2021-12-31'
and d.dept_name='SALES';

#28 Display the most recently joined employee.
select e.emp_name as Employee
from employee as e
left join department as d
on e.dept_id=d.dept_id
where e.join_date<CURDATE()
order by e.join_date desc
limit 1;

#29 Display employees having duplicate salaries.(Imp)
select emp_name as Employees,salary
from employee
where salary in  (SELECT salary
from employee
GROUP BY salary
having COUNT(emp_id)>1)
ORDER BY salary DESC;

#30 Display all employee IDs who either work in the IT department or are working on a project.
SELECT  e.emp_id as IDs
from employee as e
left join department as d
on e.dept_id=d.dept_id
left join project as p
on e.emp_id=p.emp_id
WHERE d.dept_name='IT'
UNION
select emp_id from project;

#31 Display employee IDs of employees who belong to the IT department but do not appear in the Project table.
select e.emp.id as IDs
from employee as e
left join department as d
on e.dept_id=d.dept_id
where d.dept_name='IT'
UNION
SELECT emp_id from project

#32 Display employee names of employees who are working on a project or belong to the Finance department.
select e.emp_name as Employee
from employee as e
left join project as p
on e.emp_id=p.emp_id
where p.proj_id is not NULL
UNION
SELECT e.emp_name as Employee
from employee as e
left join department as d
on e.dept_id=d.dept_id
where dept_name='FINANCE';

#33 Display distinct department IDs that appear either in the Employee table or are associated with at least one project through employees.
SELECT d.dept_id as ID
from department as d
left join employee as e
on d.dept_id=e.dept_id
where e.dept_id is not NULL
UNION
select e.dept_id as ID
from employee as e
left join project as p
on e.emp_id=p.emp_id
where p.proj_id is not null

#34 Display employee IDs of employees whose salary is greater than 60,000 and who joined before 2021.
SELECT emp_id as ID
from employee
where salary>60000 and join_date < '2021-01-01';

#35 Display employee IDs of employees who joined after 2021 or who are not assigned to any department.
select emp_id as ID from employee
where join_date > '2021-12-31'
OR
dept_id is NULL;

#36 Display employee IDs of employees who are working on a project but whose department name is not ‘IT
select e.emp_id as ID FROM
employee as e left join project as p
on e.emp_id=p.emp_id
left join department as d
on e.dept_id=d.dept_id
where p.proj_id is not null and dept_name !='IT';

#37 Display employee names of employees who either earn more than 70,000 or whose total project hours exceed 150.
SELECT e.emp_name 
from employee as e
where e.salary>70000
UNION
select e.emp_name
from employee as e
left join project as p
on e.emp_id=p.emp_id
GROUP BY e.emp_name,p.emp_id
having sum(hours)>150;

#38 Display employee IDs of employees who belong to departments having more than one employee or who are working on at least one project.
select e.emp_id
from employee as e
where e.dept_id in(select e.dept_id
from employee as e
left join department as d
on e.dept_id=d.dept_id
group by e.dept_id
having COUNT(*)>1)
UNION
select p.emp_id 
from project as p; 

#39 Display employee names of employees who are not working on any project and do not belong to the Sales department.
select e.emp_name as Employees
from employee as e
left join project as p
on e.emp_id=p.emp_id
where p.proj_id is NULL
UNION
select e.emp_name 
from employee as e
left join department as d
on e.dept_id=d.dept_id
where dept_name!='SALES';


create database company ;

use company ;

create table employee(
	fname varchar(30),			
	minit char(1),
	lname varchar(30),
	ssn char(9),  
	bdate date,
	address varchar(50),
	sex char(1),
	salary decimal(10, 2),
	super_ssn char(9),
	dno char(3)) ;



insert into employee(fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno) VALUES 
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M',30000,'333445555',5), 
('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',40000,'888665555',5), 
('Alicia','J','Zelaya','999887777','1968-01-09','3321 Castle, Spring, TX','F',25000,'987654321',4), 
('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire, TX','F',43000,'888665555',4), 
('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000,'333445555',5), 
('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000,'333445555',5), 
('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000,'987654321',4), 
('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000,NULL,1);



create table department( 
dname varchar(30), 
dnumber char(1), 
mgr_ssn char(9), 
mgr_start_date date, 
constraint pk_department PRIMARY KEY (dnumber)); 



insert into department(dname,dnumber,mgr_ssn,mgr_start_date) VALUES 
('Research',5,333445555,'1988-05-22'), 
('Administration',4,987654321,'1995-01-01'), 
('Headquarters',1,888665555,'1981-06-19'); 




create table dept_locations( 
dnumber int, 
dlocation varchar(20)); 



insert into dept_locations values 
(1, 'Houston'), 
(4, 'Stafford'), 
(5, 'Bellaire'), 
(5, 'Sugarland'), 
(5, 'Houston'); 



create table works_on( 
essn char(9), 
pno int, 
hours decimal(4,2));



insert into works_on (essn, pno, hours) values 
('123456789', 1, 32.5), 
('123456789', 2, 7.5), 
('666884444', 3, 40.0), 
('453453453', 1, 20.0), 
('453453453', 2, 20.0), 
('333445555', 2, 10.0), 
('333445555', 3, 10.0), 
('333445555', 10, 10.0), 
('333445555', 20, 10.0), 
('999887777', 30, 30.0), 
('999887777', 10, 10.0), 
('987987987', 10, 35.0), 
('987987987', 30, 5.0), 
('987654321', 30, 20.0), 
('987654321', 20, 15.0), 
('888665555', 20, NULL); 



create table project( 
pname varchar(30), 
pnumber smallint, 
plocation varchar(30), 
dnum smallint, 
constraint pk_project PRIMARY KEY (pnumber) 
); 



insert into project(pname,pnumber,plocation,dnum) values 
('ProductX', 1, 'Bellaire', 5), 
('ProductY', 2, 'Sugarland', 5), 
('ProductZ', 3, 'Houston', 5), 
('Computerization', 10, 'Stafford', 4), 
('Reorganization', 20, 'Houston', 1), 
('Newbenefits', 30, 'Stafford', 4); 





create table dependent( 
essn char(9), 
dependent_name varchar(30), 
sex char(1), 
bdate date, 
relationship varchar(20), 
constraint pk_dependent PRIMARY KEY (essn, dependent_name) 
); 



insert into dependent(essn,dependent_name,sex,bdate,relationship) values 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'), 
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'), 
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'), 
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'), 
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'), 
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');




# 1. Retrieve all rows and all columns of employee table.
Select *
FROM Employee;


# 2. Retrieve full names of all employees.

Select concat(fname,' ',minit,' ',Lname) as Full_names
From Employee;

# 3. Retrieve bdate and super_ssn of all employees using alias.

Select Bdate as Birtdate, Super_ssn as SSN
from employee;

# 4. Retrieve details of all employees who draw salary which is at least 40000.

Select *
from Employee
where salary >40000;

# 5. Retrieve the relationships of all dependents of essn 333445555.

Select Relationship, super_ssn
from employee join Dependent
where super_ssn = 333445555;

# 6. Retrieve details of "Female" employees who draw a salary which is at least 40000.

Select * 
from Employee
where sex = 'F' AND salary > 40000;

# 7. Retrieve details of "Female" employees or employees who draw a salary which is at least 40000.

Select * 
from Employee
where (sex = 'F' AND salary > 40000) OR (salary >40000);

# 8. Display details of all (male employee who earn more than 40000) or (female employees who earn less than 40000).
# Hint: Pay attention to paranthesis.

Select * 
from Employee
where (sex = 'M' AND salary > 40000) OR (sex = 'F' AND salary < 40000);

# 9. Retrieve details of projects that are based at Houston or Stafford.

Select * 
from project
where (plocation ='Houston') OR (plocation ='Stafford');

# 10. Retrieve details of projects that are NOT based at Houston or Stafford.

Select * 
from project
where plocation Not in ('Houston','Stafford');

# 11. Display the essn of employees who have worked between 25 and 50 hours.

Select essn, Sum(hours) as total_no
from works_on 
group by essn
having total_no;



# 12. Calculate total salary of employees.

Select sum(salary) as total_salary
from employee;


# 13. Find no. of employees in dept 4.

select Count(ssn)
from employee
where dno = 4;

# 14. Find no. of employees who have dependents.

Select count(distinct essn)
from employee join Dependent
where relationship not in ("null");


# 15.  Display the highest salary among female employees and 
#  	   the least salary among male employees.

Select max(Salary) as max_m
from employee
where sex ='F' 
AND 
Select max(Salary) as max_m
from employee

# 16. Display employees whose name begins with 'J'.

Select * 
from employee
where fname like 'J%';



# 17. Display details of all employees who live in Houston.

Select * 
from employee
where address like '%Houston%';

# 18. Display the employee details who does not have supervisor.

Select * 
from 
where 


# 19. Display full names of all employees in one-go.



# 20. Display the name of  manager and and the year in which the manager was appointed.

Select fname ,year(mgr_start_date) as date_s
from employee join department
where ssn = mgr_ssn;


# 21. Display the ssn of employees sorted by their salary in descending mode.



# 22. Sort the works_on table based on Pno and Hours.




# 23. Display the number of employees in each department.

Select dno, count(ssn) as no_of_employee
from employee
group by dno;

# 24. Display the department-wise average salary of employees.

Select dno, avg(salary) 
from employee
group by dno;


# 25. Among the people who draw at least 30000 salary, what is the department-wise average?

Select dno, avg(salary) 
from employee
where salary >=30000
group by dno;


# 26. Display the essn of employees who have worked between 25 and 50 hours.

Select essn, hours
from works_on join employee
where hours > 25 AND hours < 50 ;


# 27. Display the Dno of those departments those have at least 3 employees.

select dno, count(ssn) as no_of_employees
from employee
group by dno
having no_of_employees >= 3;

# 28. Display the fname and salary of employees whose salary is more than the average salary of all the employees.




# 29. Display the fname of employees working in the Research department.



# 30. Which department has the most number of employees?





# 31. Display the name of each employee and the name of their project(s). 



# 32. Print full name and dept. name of all employees working on Product 'Z'.





# 33. Display the ssn, their department, the project they work on and the department no. which runs that project
#     Output heading should be: ssn, emp-dept-name, pname, proj-dept-no .




# 34. Display all employees' full names along with their dependents' names.

select e.fname, d.dependent_name,d.relationship
from employee as e left join dependent as d
on e.ssn = d.essn;




# 35. What is the average salary of those employees who have at least one dependent?

select avg(distinct salary) 
from employee as e join dependent as d
on e.ssn = d.essn;


select avg(salary) 
from employee 
where ssn  in (select essn from dependent);


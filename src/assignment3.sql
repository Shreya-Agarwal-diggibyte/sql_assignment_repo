create table employee2(id_deptname varchar(20), emp_name varchar(20), salary int )

insert into employee2 values
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('3333-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('4444-BIO', 'AKSHAY', 10000)

select * from employee2

select Distinct RIGHT(id_deptname, CHARINDEX('-', REVERSE(id_deptname)) - 1)  as depat_name, sum(salary) as total_salary
from employee2 
group by id_deptname




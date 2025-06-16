CREATE DATABASE ecommerces
USE ecommerces

--Creating tables
CREATE TABLE gold_members_data
(User_Id INT PRIMARY KEY,
User_name VARCHAR(20), Signup_date DATE)

CREATE TABLE Users_data(User_Id INT PRIMARY KEY,
User_name VARCHAR(20),Signup_date DATE)

CREATE TABLE Sales_data(User_Id INT,Created_date DATE, Product_id INT )
ALTER TABLE Sales_data ADD User_name VARCHAR(20);

CREATE TABLE Product_data(Product_id INT,Product_name VARCHAR(50),Price INT)

--Inserting data into table
INSERT INTO gold_members_data VALUES
(001,'Shreya','2024-08-09'),
(002,'Pravi','2009-09-08'),
(003,'Gori','2014-08-20'),
(004,'Michkel','2010-02-14'),
(005,'Sky','2017-01-25'),
(006,'Mick','2015-07-23'),
(007,'Rock','2025-03-21');

INSERT INTO Users_data VALUES
(001,'Shreya','2024-08-09'),
(002,'Pravi','2009-09-08'),
(005,'Sky','2017-01-25'),
(008,'Rocky','2020-09-12'),
(009,'Vani','2019-03-01'),
(010,'Khusi','2011-08-09'),
(006,'Mick','2015-07-23'),
(007,'Rock','2025-03-21'),
(003,'Gori','2014-08-20'),
(004,'Michkel','2010-02-14');

INSERT INTO Sales_data(User_Id,User_name,Created_date,Product_id) VALUES
(001,'Shreya','2024-08-09',1),
(001,'Shreya','2024-10-04',2),
(002,'Pravi','2009-09-08',3),
(005,'Sky','2017-01-25',1),
(008,'Rocky','2020-09-12',4),
(009,'Vani','2019-03-01',2),
(010,'Khusi','2011-08-09',1),
(006,'Mick','2015-07-23',4),
(007,'Rock','2025-03-21',3),
(003,'Gori','2014-08-20',1),
(004,'Michkel','2010-02-14',1),
(002,'Pravi','2011-09-08',2),
(005,'Sky','2014-01-25',1),
(008,'Rocky','2021-09-12',4),
(009,'Vani','2015-03-01',2),
(010,'Khusi','2021-08-09',1),
(006,'Mick','2023-07-23',3),
(007,'Rock','2025-06-21',1),
(003,'Gori','2013-08-20',2),
(004,'Michkel','2023-02-14',3);

INSERT INTO Product_data VALUES
(1,'laptop',45000),
(2,'Headset',2500),
(3,'Mobile',35000),
(4,'Charger',2999);

--Show all the tables in the same database
SELECT * FROM gold_members_data;
SELECT * FROM Users_data;
SELECT * FROM Sales_data;
SELECT * FROM Product_data;

--Count all the record of all four tables using single query.

SELECT COUNT(*) AS RECORD_COUNT FROM gold_members_data
UNION ALL
SELECT COUNT(*)AS RECORD_COUNT  FROM Users_data
UNION ALL
SELECT COUNT(*)AS RECORD_COUNT  FROM Sales_data
UNION ALL
SELECT COUNT(*)AS RECORD_COUNT  FROM Product_data

--Total amount each customer spent on ecommerce company

select s.User_name, SUM(Price) as total_price
from Sales_data as s
join Product_data as p on s.Product_id = p.Product_id
group by User_name;

--Distinct dates of each customer visited the website

SELECT DISTINCT s.created_date AS Visited_Date, u.User_name AS Customer
FROM sales_data s
INNER JOIN Users_data u ON s.user_id = u.User_Id
ORDER BY Visited_Date, Customer;

--Find the first product purchased by each customer using 3 tables(users, sales, product)

 
 Select u.user_id , u. user_name as customers , p.product_id as first_product , s.created_date
 from Users_data u
 Join Sales_data s on u.User_Id=s.User_Id
 join Product_data p on s.Product_id=p.product_id
 where s.Created_date= ( select min(s2.created_date)
 from Sales_data s2 
 where s2.User_Id =u.User_Id);

 --Find duplicate in product table

 insert into Product_data values(4,'Charger',2999);
 
 select count(*) as Duplicate_value , product_id
 from product_data
 group by Product_id
 having count(*)>1;


-- find out the user who is not gold member
select user_name ,user_id from Users_data
where user_id not in(select user_id from gold_members_data);

--customer whose name start with M

Select user_name from Users_data
where user_name like 'M%';


--Find the Distinct customer Id of each customer

Select distinct user_id,user_name
from Users_data;

--Change the Column name from product table as price_value from price
exec sp_rename 'dbo.product_data.price','price_value','column';

select * from Product_data;

-- Change the Column value product_name – Mobile to Iphone from product table
Update Product_data
set product_name ='Iphone'
where product_name='mobile';

--Change the table name of gold_member_users to gold_membership_users
exec sp_rename 'dbo.gold_members_data', 'gold_membership_users';

select name 
from sys.tables

--most purchased item of each customer and how many times the customer has purchased it

SELECT s.user_id, u.user_name, p.product_name, COUNT(*) AS item_count
FROM sales_data s
JOIN users_data u ON s.user_id = u.user_id
JOIN product_data p ON s.product_id = p.product_id
GROUP BY s.user_id, u.user_name, p.product_name
ORDER BY s.user_id, item_count DESC;

--amount spent by each customer when he was the gold_member user
select u.user_name,sum(p.price_value) as total_amount
from gold_membership_users g
join sales_data s on g.user_id=s.user_id
join product_data p on s.product_id=p.product_id
join users_data u on g.user_id=u.user_id
group by u.user_name;

--a new column as Status in the table crate above gold_membership_users 
--the Status values should be 2 Yes and No if the user is gold member, then status should be Yes else No.

alter table users_data
add status varchar(20);

select * from Users_data;

update users_data
set status='yes'
where users_data.user_name in
(select gold_membership_users.user_name from gold_membership_users)
update Users_data
set status='no'
where status is null



begin transaction

delete from users_data where user_id=1

delete from Users_data where user_id=2

select * from Users_data

rollback
select * from Users_data


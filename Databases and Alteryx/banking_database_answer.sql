/*Assignment 3 Thomas Courtney
July 19, 2020*/

SET sql_mode = 'ONLY_FULL_GROUP_BY';

-- Query 1
select FIRST_NAME,LAST_NAME,START_DATE,TITLE
from employee
where Title='Teller'
order by START_DATE;

-- Query 2
select NAME
from product
WHERE NAME like '%account%';

-- Query 3
select p.NAME, avg(a.AVAIL_BALANCE), min(a.AVAIL_BALANCE), max(a.AVAIL_BALANCE)
from product p, account a
where a.PRODUCT_CD=p.PRODUCT_CD
group by p.Name;


-- Query 4
Select c.CUST_ID, avg(a.AVAIL_BALANCE), count(ACCOUNT_ID)
From customer c, account a
where c.CUST_ID=a.CUST_ID 
group by c.CUST_ID
having avg(a.AVAIL_BALANCE) > 1000;

-- Query 5
select max(a.PENDING_BALANCE), b.BRANCH_ID, p.PRODUCT_CD
from account a, branch b, product p
where b.BRANCH_ID = a.OPEN_BRANCH_ID and p.PRODUCT_CD = a.PRODUCT_CD
group by b.BRANCH_ID, p.PRODUCT_CD
having max(PENDING_BALANCE) > 2000;

-- Query 6
select a.ACCOUNT_ID, c.CUST_ID, p.PRODUCT_CD, b.BRANCH_ID
from account a, customer c, product p, branch b
where c.CUST_ID = a.CUST_ID and b.BRANCH_ID = a.OPEN_BRANCH_ID and p.PRODUCT_CD = a.PRODUCT_CD
and a.AVAIL_BALANCE < (
select avg(a.AVAIL_BALANCE)
from account a
);

-- Query 7
select a.ACCOUNT_ID, i.LAST_NAME, i.FIRST_NAME, p.PRODUCT_CD, b.BRANCH_ID
from account a, individual i, product p, branch b
where b.BRANCH_ID = a.OPEN_BRANCH_ID and p.PRODUCT_CD = a.PRODUCT_CD
and a.AVAIL_BALANCE < (
select avg(a.AVAIL_BALANCE)
from account a
)
order by i.LAST_NAME;

-- Query 8
select LAST_NAME,FIRST_NAME
from individual 
where CUST_ID in (select CUST_ID
from account a
Group by CUST_ID
Having count(*)>2);

-- Query 9
select e.LAST_NAME, e.FIRST_NAME, year(CURDATE()) - year(e.START_DATE) as 'years with company', s.LAST_NAME as "Supervisor Last Name"
from employee e, employee s
where e.SUPERIOR_EMP_ID = s.EMP_ID
order by s.LAST_NAME;

-- Query 10
select s.LAST_NAME as 'Supervisor Last Name', count(e.EMP_ID) as 'Number of employees'
from employee e, employee s
where e.SUPERIOR_EMP_ID = s.EMP_ID
group by s.LAST_NAME
order by s.LAST_NAME;
use company;

-- Lisst first/last names of all employees either female/female dependent
select fname, lname from employee where sex = "f";

select fname, lname from employee e join dependent d on e.ssn = d.essn where sex = "f";

-- make a list of the names of all departments w/ more than 3 employees or less than 2 projects associated w/ them
select dname from department join employee on dnumber = dno group by dname having count(*) > 3
union
select dname from department join project on dnumber = dnum group by dname having count(*) < 2;

-- make a list of all project numbers for projects that involve an employee whose last name is "Smith",
-- either as a worker or as a manager of the department that controls the project
select pno from employee join works_on on ssn = essn where lname like "Smith"
union
select pnumber from employee, dependent, project where ssn = mgrssn and dnum = dnumber and lname like "Smith";

-- for eadch project rettrieve project number, name, and # of employees working on project
select pnumber, pname, count(essn) from project left join works_on pnumber = ;

-- show all employee first and last names and resulting salaries if every employee working on "ProductX" project is given a 10% raise
select fname, lname, salary*1.10 from employee where ssn in
(select essn from works_on join project on pno = pnumber and pname = "ProductX")
union
select fname, lname, salary from employee where ssn not in 
(select essn from works_on join project on pno = pnumber and pname = "ProductX");


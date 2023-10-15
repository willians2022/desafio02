-- Quais as bases de dados instanciadas no Mysql da Azure:
show databases;

-- Base de dados a ser utilizada para o desafio:
use azure_company;

-- Verificação das tabelas e suas estruturas para realizar as consultas:
show tables;
desc employee;
desc departament;
desc dependent;
desc dept_locations;
desc project;
desc works_on;

-- Verificando a existência de nulos:
SELECT * FROM employee 
WHERE Fname IS NULL
	or Minit IS NULL
	or Lname IS NULL
	or Ssn IS NULL
	or Bdate IS NULL
	or Address IS NULL
	or Sex IS NULL
	or Salary IS NULL
	or Super_ssn IS NULL
	or Dno IS NULL;
    
SELECT * FROM departament 
WHERE Dname IS NULL
	OR Dnumber IS NULL
	OR Mgr_ssn IS NULL
	OR Mgr_start_date IS NULL
	OR Dept_create_date IS NULL;
    
SELECT * FROM dependent 
WHERE Essn IS NULL
	OR Dependent_name IS NULL
	OR Sex IS NULL
	OR Bdate IS NULL
	OR Relationship IS NULL;

SELECT * FROM dept_locations 
WHERE Dnumber IS NULL
	OR Dlocation IS NULL;

SELECT * FROM project 
WHERE Pname IS NULL
	OR Pnumber IS NULL
	OR Plocation IS NULL
	OR Dnum IS NULL;

SELECT * FROM works_on 
WHERE Essn IS NULL
	OR Pno IS NULL
	OR Hours IS NULL;

-- Verificação de colaboradores sem gerente:
SELECT * FROM employee WHERE Super_ssn is null;

-- Verificação se há departamentos sem gerente:
select Dname from departament where Mgr_ssn is null;

-- Verificar quais colunas indicam o código da função:
select * from employee; -- Ssn
select * from departament; -- Mgr_ssn (gerentes)

-- Quem são os gerentes e seus departamentos:
select concat(Fname, ' ', Lname) as Manager, Dname, Ssn from employee e, departament d where
	e.Ssn = d.Mgr_ssn;

-- Qual(is) o(s) funcionário(s) com maior cargo gerencial:
SELECT * FROM employee WHERE Super_ssn is null;
SELECT * FROM employee WHERE Super_ssn is not null;
select concat(Fname, ' ', Lname) as Super_Manager, Ssn, Dname from employee e, departament d where
	e.Ssn = d.Mgr_ssn and Super_ssn is null;

-- Verificação do total de horas trabalhadas em cada projeto (com JOIN):
select * from project;
select * from works_on;
select Pnumber, Pname from project order by Pnumber; -- Quais são os projetos
SELECT Pname as nome_proj, Pnumber as num_proj, SUM(Hours) as total_horas_proj
FROM project p
JOIN works_on w ON p.Pnumber = w.Pno
WHERE p.Pnumber IN ('1', '2', '3', '10', '20', '30') -- números dos projetos
GROUP BY p.Pnumber, p.Pname order by num_proj;

-- Verificação da soma total de horas trabalhadas:
SELECT SUM(Hours) as soma_total_horas
FROM project p
JOIN works_on w ON p.Pnumber = w.Pno
WHERE p.Pnumber IN ('1', '2', '3', '10', '20', '30');

-- Verificar quais são os colaboradores por gerente:
SELECT Super_ssn, GROUP_CONCAT(Fname ORDER BY Fname ASC) as Nomes
FROM employee
GROUP BY Super_ssn;

-- Verificar quantos são os colaboradores por gerente:
SELECT Super_ssn, COUNT(Fname) as Contagem
FROM employee
GROUP BY Super_ssn;

-- Verificar quais colaboradores por qual gerente:
SELECT 
    -- e1.Super_ssn, 
    GROUP_CONCAT(e1.Fname ORDER BY e1.Fname ASC) as Nomes_func,
    e2.Fname
    -- GROUP_CONCAT(e2.Fname ORDER BY e2.Fname ASC) as Nomes_mgr
FROM employee e1
LEFT JOIN employee e2 ON e1.Super_ssn = e2.Ssn
GROUP BY e1.Super_ssn;



-- Consultas diversas:
select Dname as nome_departamento, Fname as funcionario, Ssn, Super_ssn, Dnumber, Dno from departament, employee;
select Dname as nome_departamento, Fname as funcionario, Ssn, Super_ssn, Dnumber from departament d, employee e where
	d.Dnumber = e.Dno;
SELECT * FROM employee WHERE Dno IN (3,6,9);

select * from departament where Mgr_ssn = 888665555;

select Fname, Bdate, Salary from employee Where Salary < 50000 and Salary > 30000;
select all Salary from employee;
select distinct Salary from employee;
SELECT Fname FROM employee ORDER BY Fname asc;
SELECT * FROM employee LIMIT 2,3;
SELECT Fname from employee where Fname like 'a%';
SELECT LEFT(Fname,3) from employee;
SELECT RIGHT(Fname,3) From employee;
select Dname as Department, concat(Fname, ' ', Lname) as Manager from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;
select Dname as Department, Mgr_ssn as Manager from departament d, dept_locations l
where d.Dnumber = l.Dnumber;

select * from departament where Dname = 'Research';

select Ssn, count(Essn) from employee e, dependent d where (e.Ssn = d.Essn);
select Ssn from employee e, dependent d where (e.Ssn = d.Essn);

select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.011 as INSS from employee;

select Dname as Department, concat(Fname, ' ', Lname) as Manager from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and d.Mgr_ssn = e.Ssn;

select e.Fname, e.Lname, e.Address from employee e, departament d
	where d.Dname = 'Research' and d.Dnumber = e.Dno;
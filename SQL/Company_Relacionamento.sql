CREATE SCHEMA IF NOT EXISTS company;

-- drop schema company;

use company;

create table employee(
	Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null,
    Bdate Date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check(Salary > 2000),
    constraint pk_employee primary key(Ssn)
);


alter table employee 
modify Dno int not null default 1;

alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;
    
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE
    REFERENCED_TABLE_NAME = 'employee';

    
desc employee;

create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date Date,
    Dept_create_date date,
    constraint chk_date_dept check(Dept_create_date < Mgr_start_date ),
    constraint pk_dept primary key(Dnumber),
    constraint unique_name_dept unique (Dname),
    constraint fk_dept_employee foreign key(Mgr_ssn) references employee(Ssn)
);

alter table departament drop constraint fk_dept_employee;

alter table departament
	add constraint fk_dept_employee foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;
    
desc departament;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
);

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    constraint pk_project primary key(Pnumber),
    constraint unique_name_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    constraint pk_works_on primary key (Essn, Pno), 
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on_pno foreign key (Pno) references project(Pnumber)
);


create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- F ou M
    Bdate Date,
    Relationship varchar(8),
    constraint pk_dependent primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

show tables;

select * from information_schema.table_constraints
	where constraint_schema = 'company';
    
select * from information_schema.referential_constraints
	where constraint_schema = 'company';
    
-- Inserção de Dados BD Company
-- Ativar para uso
use company;
-- Confirmar tabelas do BD
show tables;

insert into employee values ('Charles', 'A', 'Pereira', '111111100', '1991-03-15',
 '99708-138_Erechim_RS_BR', 'M', 15200.00, '987654321', 1) ;

insert into employee values ('Carlos', 'A', 'Pereira', '111111111', '1991-03-15',
 '99708-138_Erechim_RS_BR', 'M', 15200.00, '987654321', 1),

('Mariana', 'B', 'Oliveira', '222222222', '1992-07-10',
 '99708-138_Erechim_RS_BR', 'F', 6100.00, '987654321', 1),

('Lucas', 'C', 'Ferreira', '333333333', '1988-01-25',
 '99708-138_Erechim_RS_BR', 'M', 4800.00, '987654321', 1),

('Fernanda', 'D', 'Costa', '444444444', '1995-09-12',
 '99708-138_Erechim_RS_BR', 'F', 7300.00, '987654321', 1),

('Bruno', 'E', 'Ramos', '555555555', '1987-11-30',
 '99708-138_Erechim_RS_BR', 'M', 5600.00, '987654321', 1),

('Juliana', 'F', 'Almeida', '666666666', '1993-06-18',
 '99708-138_Erechim_RS_BR', 'F', 6900.00, '123456789', 1),

('Diego', 'G', 'Barbosa', '777777777', '1989-02-08',
 '99708-138_Erechim_RS_BR', 'M', 8200.00, '123456789', 1),

('Patricia', 'H', 'Lima', '888888888', '1991-08-22',
 '99708-138_Erechim_RS_BR', 'F', 7500.00, '123456789', 1),

('Renato', 'I', 'Souza', '999999998', '1985-04-05',
 '99708-138_Erechim_RS_BR', 'M', 9100.00, '123456789', 1),

('Aline', 'J', 'Martins', '999999997', '1994-12-14',
 '99708-138_Erechim_RS_BR', 'F', 6400.00, '987654321', 1);

update employee
set Address = '90108-011_Marau_RS_BR'
where Ssn = '666666666';

select * from employee;

UPDATE employee
SET Dno = 4
WHERE Ssn = '999999998';

SELECT Fname, Salary FROM employee WHERE salary < (SELECT avg(salary) FROM employee);

select min(salary),avg(salary),max(salary) from employee;

SELECT
    Fname,
    -- Salary,
    -- (SELECT AVG(Salary) FROM employee) AS Avg_Salary,
    (SELECT AVG(Salary) FROM employee) - Salary AS Diff_To_Avg
FROM employee
WHERE Salary < (SELECT AVG(Salary) FROM employee);

select 
	Fname,
    Salary,
     Salary - (SELECT avg(Salary) FROM employee)   AS Diff_Avg,
    (SELECT avg(Salary) FROM employee) as Salary_Avg
FROM employee
WHERE Salary >= (SELECT min(Salary) FROM employee)
order by Diff_Avg;

SELECT 
    -- Fname,
    Ssn as Registro,
   -- Salary,
    CASE
        WHEN Salary > (SELECT AVG(Salary) FROM employee) THEN 'Maior'
        WHEN Salary < (SELECT AVG(Salary) FROM employee) THEN 'Menor'
        ELSE 'NA'
    END AS Salary_level
FROM employee
ORDER BY Salary Asc;

drop table denpendent;
insert into dependent values
(111111111, 'Amarildo','F','1986-08-05','Spouse'),
(222222222, 'Arnaldo','F','1986-08-05','Spouse'),
(333333333, 'Amanda','F','1986-08-05','Spouse'),
(444444444, 'Armando','M','1996-04-05','Daughter'),
(555555555, 'Aline','F','1986-02-15','Daughter'),
(999999998, 'Alano','M','1976-04-05','Daughter')
;
select * from  dependent;

insert into departament values
('Reserach',5,111111111,'1991-03-15','1990-03-15'),
('Administration',4,222222222,'1994-07-10','1992-07-10'),
('Headquarters',3,333333333,'1990-01-25','1988-01-23');

insert into departament values
('Sesmt',7,444444444,'1991-03-15','1990-03-15')
;

select * from departament;

insert into dept_locations values
(3,'Houston'),
(4,'Stafford'),
(5,'Bellaire'),
(5,'Sugarland'),
(5,'Houston');
select * from dept_locations;

insert into project values
('ProductX', 1,'Bellaire',5),
('ProductY', 2,'Sugarland',5),
('ProductZ', 3,'Houston',5),
('Computerization', 10,'Stafford',4),
('Reorganization', 20,'Houston',3),
('Newbenefits', 30,'Stafford',4);

insert into project values
('ProductX', 7,'Bellaire',5),
('ProductY', 8,'Sugarland',5),
('ProductZ', 9,'Houston',5),
('Computerization', 12,'Stafford',4),
('Reorganization', 22,'Houston',3),
('Newbenefits', 33,'Stafford',4);
select * from project;

insert into works_on values
(777777777,30 , 31.2);
select * from works_on;

-- Exemplo de Recuperação de Dados

select * from employee;
-- gerente por departamento
select e.Ssn, e.Fname, d.Dname from employee e, departament d where (e.Ssn = d.Mgr_ssn);
-- Dependentes por funcionários
select e.Fname, d.Dependent_name, d.Relationship from employee e , dependent d where (e.Ssn = d.Essn);
-- Dados de funcionário Especifico
select e.Fname, e.Minit, e.Lname, e.Bdate, e.Address  from employee e
where  e.Fname = 'Bruno' and e.Minit = 'E' and e.Lname = 'Ramos';
-- Recuperar nome de departamento, com valor espeficio
select * from departament dept 
where dept.Dname = 'Reserach';
-- Recuperando dados dos funcionários por setor
select * from departament;
select e.Fname, e.Lname, e.Address
from employee e, departament d
where d.Dname = 'Administration' and d.Dnumber = e.Dno;
-- horas de funcionarios por projeto
select p.Pname, w.Essn, e.Fname, w.Hours 
from project p, works_on w, employee e 
where p.Pnumber = w.Pno and w.Essn = e.Ssn;
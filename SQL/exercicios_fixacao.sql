use company;
show tables;
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
-- Retirando aniguidades
desc departament; -- Dnumber
desc dept_locations; -- Dnumber
select d.Dname, dl.Dlocation 
from departament d, dept_locations dl
where d.Dnumber = dl.Dnumber;
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
desc departament; -- Coluna Dnumber
desc dept_locations; -- Coluna Dnumber
select d.Dname, dl.Dlocation 
from departament d, dept_locations dl
where d.Dnumber = dl.Dnumber;

-- Concater Colunas
select concat(e.Fname, ' ', e.Lname) as Nome_Funcionarios
from employee e;

-- Expressões e alias

select concat(e.Fname,' ', e.Minit,' ', e.Lname) as Nome_Completo
from employee e;

use company;

select d.Dname as Departamentos ,e.Fname as Funcionários, e.Salary as Salários , round( e.Salary * 0.11 ,2) as 'INSS' , Salary - round( e.Salary * 0.11, 2)  as Liquido
from employee e , departament d 
where (e.Ssn = d.Mgr_ssn);

-- Aumento de Salário para Gerentes que trabalham no projeto associado ao ProdutoX
select * from project;

select count(Pname) as Qtd_Projetos_ProductX from project where Pname = 'ProductX';

-- Aumento de Salário para Gerentes que trabalham no projeto associado ao ProdutoX

select *
	from employee as e , works_on as w, project as p
    where (e.Ssn = w.Essn and w.Pno=p.Pnumber and p.Pname = 'ProductX')
    ;
    
select concat(e.Fname, ' ' , e.Lname)as Nome_Completo , e.Salary as Salário_Atual , round(e.Salary * 0.1,2) as  Reajuste, round(e.Salary * 1.1,2) as Salario_Reajustado
	from employee as e , works_on as w, project as p
    where (e.Ssn = w.Essn and w.Pno=p.Pnumber and p.Pname = 'ProductX')  
    ;
    
-- Recuperando dados dos funcionários por setor
select e.Fname, e.Lname, e.Address
from employee e, departament d
where d.Dname = 'Administration' and d.Dnumber = e.Dno;

-- Expressões,concatenações de Strins e clausula Like e Numéricos com Between

-- Recuperar informações dos departamentos presentes em Staffors

select * from departament d;

-- recupearndo informações dos departamentos presentes em Sttaford
select d.Dname as Nome_Departamento, d.Mgr_Ssn as Gerente , e.Address
from departament d, employee e, dept_locations dl
where d.Dnumber = dl.Dnumber and dl.Dlocation like '%Stafford';

-- recuperando todos os gerentes que trabalham em stafford
select concat(e.Fname,' ', e.Lname) as Nome_Completo 
,Dname as Nome_Departamento, d.Mgr_Ssn as Gerente , e.Address
from departament d, employee e, dept_locations dl
where d.Dnumber = dl.Dnumber and dl.Dlocation like '%Stafford' and d.Mgr_Ssn = e.Ssn;

-- recuperando todos os gerentes, departamentos e seus nomes 
select Dname as Nome_Departamento, concat(e.Fname,' ', e.Lname) as Nome_Completo , dl.Dlocation as Localização
from departament d, employee e, dept_locations dl
where d.Dnumber = dl.Dnumber and d.Mgr_Ssn = e.Ssn;

-- recuperando Pnumber e Dnum projetos dentro de localização Stafford
select p.Pnumber, p.Dnum, e.Address, e.Bdate, p.Plocation
from departament d, project p, employee e
where d.Dnumber = p.Dnum and p.Plocation='Stafford' and Mgr_ssn = e. Ssn;

-- Like (Strings) e between (numéricos)
use company;
desc employee;
desc departament;
select * from employee;
select * from departament;

-- Like
select concat(Fname,' ', Lname) Nome_Funcionários, Dname Nome_Departamentos, Address
	from departament , employee 
	where (Dno=Dnumber and Address like'%Ernestina%')
;
select concat(Fname,' ', Lname) Nome_Funcionários, Address
	from employee 
	where (Address like'%Aurea%')
;

-- Between

Select concat(Fname,' ',Lname) Funcionários , Salary
from employee
where (Salary between 10000 and 20000);


-- Operadores Lógicos

select Bdate, Address 
	from employee
    where Fname='Rafael' and Lname='Silva'
    ;
    
select * 
	from departament
    where Dname = 'Reserach' or Dname = 'Administration'
    ;
    
select concat(Fname,' ',Lname) Nomes
	from departament, employee
    where Dname = 'Administration' and Dnumber=Dno
    ;
    
    
-- operadores Matemáticos - Union, except e intersect

(
select distinct Pnumber
	from project, departament, employee
    where Dnum=Dnumber and Mgr_Ssn = Ssn
		and Lname = 'Lucas'
)
union
(
select distinct Pnumber
	from project, works_on, employee
    where Pnumber=Pno and Essn = Ssn
		and Lname = 'Lucas'
);
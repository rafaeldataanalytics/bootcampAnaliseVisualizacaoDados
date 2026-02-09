use company;

-- ORDENAÇÃO ORDER BY

select Fname, lname, dno
from employee
where dno >= 2
order by (dno) desc;

select Fname, lname, dno
from employee
where Fname like 'R_%'
order by (Fname) ASC;

-- Nome Gerente e Nome Departament
SELECT DISTINCT d.Dname, concat(e.Fname,' ',e.Lname) as Gerente, e.Address
	from departament d, employee e, works_on w, project p
    where(d.Dnumber = e.Dno and e.Ssn <> d.Mgr_ssn and w.Pno = p.Pnumber)
    order by d.Dname ;

-- recupera todos funcionarios e os projetos que estão trabalhando
SELECT d.Dname as Departamento , concat(e.Fname,' ',e.Lname) as Funcionários, p.Pname as Nome_Projeto,  e.Address
	from departament d, employee e, works_on w, project p
    where(d.Dnumber = e.Dno and e.Ssn <> w.Essn and w.Pno = p.Pnumber)
    order by d.Dname asc;

-- AGRUPAWMENTO - AGREGAÇÃO  
select * from employee;

-- Retorna Numero Departament (Dno),  Qtd de Funcionarios count(*) e media de salario por departamento avg(Salary)
select Dno, count(*), avg(Salary)
from employee
group by Dno;

select count(*) from employee ;
select * from departament ;
select count(*) from employee e,  departament d
	where d.Dnumber=e.Dno and d.Dname='Reserach';
    
-- Média de Salários
select Dname, Dno Num_Reg_Dept, count(*) as Num_Func_Depts, round(avg(Salary),2) as Média_Salários_Dept
	from employee, departament
    where Dno=Dnumber
    group by Dno;
    
select * from works_on;

-- Quantos Funcionários tem por Projeto
select Pnumber Nº_Projt, Pname Name_Projt, count(*) Qtd_Func_Projt
	from project, works_on
    where Pnumber = Pno
    group by Pnumber,Pname;
    
-- Qtos valores de salários dos Funcionários
select count(distinct Salary) from employee;

-- Sum, Max e Min de Salários
select count(*) Qtd_Func, sum(Salary) Total_Sal, min(Salary) Menor_Sal, max(Salary) Maior_Sal, avg(Salary) Média_Sal
	from Employee;

select count(distinct Dname) Qtd_Dept from departament;

select Dname Nome_Dept from departament
group by Dname
order by Dname desc;


select Pnumber Nº_Projt, Pname Nome_Project, count(*) Qtd_Func, round(avg(Salary),2) Media_Sal
	from project, works_on, employee
    where Pno=Pnumber and Essn=Ssn
    group by Pnumber, Pname
    order by Media_Sal;
    
    
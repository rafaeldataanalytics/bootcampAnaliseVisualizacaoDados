-- Having

use company;

select Pnumber Nº_Projt, Pname Nome_Project, count(*) Qtd_Func, round(avg(Salary),2) Media_Sal
	from project, works_on, employee
    where Pno=Pnumber and Essn=Ssn
    group by Pnumber, Pname    
    having count(*) >= 1
    order by Media_Sal desc;
    
    
desc employee;
select concat(e.Fname,' ',e.Lname) as Nome_Func, round(avg(e.Salary),2) Media_Salario
from employee e
group by Nome_Func
having Media_Salario > 7000
order by Media_Salario desc;

select Dno, round(avg(e.Salary),2) Media_Salario
from employee e
group by Dno
having Media_Salario >= 2000
order by Media_Salario desc;

select Dno Reg_Dept, count(*) Qtd_Func_Dept
	from employee 
	where Salary > 4000
		and Dno in (select Dno
						from employee
                        group by Dno
                        having count(2) >= 2)
	group by Dno;        )

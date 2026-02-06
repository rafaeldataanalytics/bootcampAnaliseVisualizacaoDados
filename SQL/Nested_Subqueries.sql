-- Nested Subqueries
use company;

select Lname from employee;

-- Usando Claúsula IN 

SELECT distinct Pnumber
from Project
where Pnumber in
	(select distinct Pno
			from Works_on, Employee
			Where (Essn = Ssn and Lname = 'Oliveira'))	  
	or Pnumber in
    (select distinct Pnumber 
			from	Project, Departament, Employee
			where (Dnum = Dnumber and
				  Mgr_ssn = Ssn and Lname ='Oliveira')
                  );
 
 
 select distinct *
	from works_on
    where (Pno, Hours) in (select Pno, Hours
		from works_on
        where Essn=111111111
        );
        
        
-- Exists ot Exists e Unique

-- Quais employee possuem dependentes 
select e.Fname, e.Lname
	from employee e 
	where Exists( select *
					from dependent d 
					where e.Ssn = d.Essn
				   );
       
-- Quais employee não possuem dependentes 
select e.Fname, e.Lname
	from employee e 
	where not Exists( select *
					from dependent d 
					where e.Ssn = d.Essn 
                    );
                    
-- Quais Gerentes possuem ao menos um dependente
select distinct e.Fname, e.Lname
	from employee e , departament d
	where (e.Ssn = d.Mgr_ssn) and exists (select * from dependent d where e.Ssn = d.Essn);
                               
-- Quais gerentes >= 2 filhos

select e.Fname, e.Lname, Dependent_name
	from employee e , dependent d
	where Ssn = Essn and (select count(*) from dependent where Ssn = Essn ) >= 2;
    

-- Retorna todos com ou sem filhos e qtd de filhos
SELECT 
    CONCAT(e.Fname, '  ', e.Lname) AS Nomes_Gerentes,
    COUNT(d.Dependent_name) AS Filhos
FROM employee e
LEFT JOIN dependent d 
    ON e.Ssn = d.Essn
GROUP BY e.Ssn, e.Fname, e.Lname;

-- Retorna somente quem tem filhos e qtd de filhos
SELECT 
    CONCAT(e.Fname, ' ', e.Lname) AS Nomes_Gerentes,
    COUNT(d.Dependent_name) AS Filhos
FROM employee e
INNER JOIN dependent d 
    ON e.Ssn = d.Essn
GROUP BY e.Ssn, e.Fname, e.Lname;

select distinct concat(e.Fname ,'  ', e.Lname) Nome_Gerente, w.Essn Registro_Gerente, w.Pno Numero_Projeto
	from works_on w, employee e
    where w.Pno in (1,2,3) and e.Ssn = w.Essn;

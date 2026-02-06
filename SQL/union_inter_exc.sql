create database if not exists unionExceptionIntersection;

show databases;

use unionExceptionIntersection;

create table R(
A char(2));

create table S(
A char(2));

show tables;

insert into R
	values('a1'),('a2'),('a2'),('a3')
    ;
insert into S
	values('a1'),('a1'),('a2'),('a3'),('a4'),('a5')
    ;
    
select * from R;
select * from S;

-- except -> not in
select *  from S where A not in (select A from R);

-- union
(select distinct R.A from R)union(select distinct S.A from S);

-- intersection
select distinct R.A from R where R.A in (select S.A from S);
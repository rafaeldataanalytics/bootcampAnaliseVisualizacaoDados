show databases;

create table person(
person_id smallint unsigned,
fname varchar(20) not null,
lname varchar(20) not null,
gender enum('F','M') not null,
birth_date date not null,
street varchar(20) not null,
city varchar(20) not null,
state varchar(20) not null,
country varchar(20) not null,
postal_code varchar(20) not null,
salary int not null,
constraint pk_person primary key (person_id)
);

select  * from person;
desc person;


-- Explorando DDL

select now() as Timestamp;

create database if not exists manipulacao;

show databases;

use manipulacao;

create table contasBancarias(
	Id_conta INT auto_increment primary key,
    Ag_num INT NOT NULL,
    Ac_num INT NOT NULL,
    Saldo FLOAT,
    constraint retricao_identificacao_conta UNIQUE (Ag_num, Ac_num)
    );    
desc contasBancarias;

-- Utilização do alter

-- alter table nome_tabela modify nome_atributo tipos_dados condicao;
-- alter table nome_tabele ad constraint nome_constrarint condicoes;

alter table contasBancarias
add LimiteCredito float not null default 500.00;
alter table contasBancarias
add email varchar(20);
alter table contasBancarias
drop column email;

desc contasBancarias;

create table clienteBanco(
	Id_cliente INT auto_increment,
    ClienteConta  INT,
    CPF varchar(11) not null,
    RG varchar(9) not null,
    Nome varchar(50) not null,
    Endereco varchar(100) not null,
    Renda_mensal float,
    primary key (Id_cliente, ClienteConta),
    constraint fk_conta_cliente foreign key (ClienteConta) references contasBancarias(Id_conta)
	on update cascade
);

desc clienteBanco;

-- Utilização do alter

-- alter table nome_tabela modify nome_atributo tipos_dados condicao;
-- alter table nome_tabele ad constraint nome_constrarint condicoes;

alter table  clienteBanco
modify CPF char(11) not null ;
alter table  clienteBanco
modify RG char(9) not null ;

desc clienteBanco;

create table transacoesBancarias(
	Id_transacao INT auto_increment primary key,
    Ocorrencia datetime,
    Status_transacao varchar(20),
    Valor_transacao float,
    Conta_fonte int,
    Destinacao_conta int,
    constraint fk_conta_fonte foreign key (Conta_fonte) references
    contasBancarias(Id_conta),
    constraint fk_destino_transacao foreign key (Destinacao_conta) references
    contasBancarias(Id_conta)
);
show tables;




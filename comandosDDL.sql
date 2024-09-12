-- ****** configurações do github
-- definindo o usuario
git init
git config --global user.name "rosenclever"
git config --global user.email "rosenclever@gmail.com"
git add .
git commit -m "aula do dia 08/08"
git remote add origin https://github.com/rosenclever/BD2_licomp_20241.git
git push -u origin master

-- fazendo o backup do banco de dados
-- deve estar na tela de login do mysql
-- executar sempre ao final das aulas
mysqldump -u root --databases bancodb academico > E:\rosen\BD2_licomp_20241\bkp280324.sql 

-- para restaurar o backup de um banco de dados
-- executar o comando a seguir de dentro do mysql
-- executar este comando no início de cada aula
source E:\rosen\BD2_licomp_20241\bkp280324.sql

-- acessando o mysql pelo terminal do xampp
mysql -u root

-- visualizando os bancos de dados instalados
show databases;

-- criando um novo banco de dados
create database exemplodb;

-- acessando o banco de dados
use exemplodb;

-- excluindo um banco de dados
drop database exemplodb;

-- criar o bancoDB
create database bancoDB;

-- acessar o bancoDB
use bancoDB;

-- criando a tabela bancos
create table bancos(
    numero int not null,
    nome varchar(100) not null,
    constraint bancos_pk primary key(numero)
);

-- criar a tabela agencias
create table agencias(
    numero varchar(100) not null,
    nome varchar(100) not null,
    telefone int,
    banco int not null,
    constraint agencias_pk primary key(numero)
);

alter table agencias
add constraint bancos_agencias_fk
    foreign key(banco)
    references bancos(numero);

--criar a tabela clientes
create table clientes(
    id int not null auto_increment,
    nome varchar(100) not null,
    email varchar(100) not null,
    constraint clientes_pk primary key(id)
);

alter table clientes
add agencia varchar(100);

alter table clientes
add constraint agencias_clientes_fk
    foreign key(agencia)
    references agencias(numero)

-- criar a coluna uf do tipo char com tamanho 2 e valor padrão 'RJ' na tabela clientes
alter table clientes
add uf char(2) default 'RJ';

-- fixacao adicionar dia e mes aniversario
alter table clientes
add dia_niver int,
add mes_niver int;

desc clientes;

-- fixação regras
alter table clientes
add constraint dias_ck check(dia_niver >= 1 and dia_niver <= 31),
add constraint mes_ck check(mes_niver >= 1 and mes_niver <=12);

-- fixação
-- tabela Paises
create table Paises(
    numero int not null,
    nome varchar(50) not null,
    constraint paises_pk primary key(numero)
);

-- relacionamento entre paises e bancos
alter table bancos
add pais int not null,
add constraint paises_bancos_fk
    foreign key(pais) references paises(numero);

-- excluir relacionamento entre as tabelas Agencias e Clientes
alter table clientes
drop constraint agencias_clientes_fk;

-- excluir a coluna agencia da tabela Clientes
alter table clientes
drop column agencia;

-- criar a tabela contas com o relacionamento de Agencias e Clientes
create table contas(
    numero int not null auto_increment,
    saldo decimal(17,2) not null,
    limite decimal(17,2),
    agencia varchar(100) not null,
    cliente int not null,
    constraint contas_pk primary key(numero),
    constraint agencias_contas_fk
        foreign key(agencia) references agencias(numero),
    constraint clientes_contas_fk
        foreign key(cliente) references clientes(id)
);

-- fixacao produtos
alter table produtos
modify unidades varchar(50) default 'unidades';

-- correção dos exercícis dos slides 33 ao 35
create database academico;
use academico;

create table instituicoes(
    id integer not null,
    constraint instituicoes_pk primary key(id),
    nome varchar(100) not null,
    email varchar(100) not null,
    constraint inst_email_uq unique(email)
);

alter table instituicoes
add uf char(2) default 'RJ';

create table professores(
    prof_matr integer(6) not null,
    constraint professores_pk primary key(prof_matr),
    prof_nome varchar(100) not null,
    prof_email varchar(150) not null,
    constraint prof_email_uq unique(prof_email),
    prof_salario decimal(18,2),
    constraint prof_salario_ck check(prof_salario > 700)
);

alter table professores
add dia_niver int,
add mes_niver int;

alter table professores 
add constraint professores_dia_niver_ck
    check(dia_niver >= 1 and dia_niver <= 31),
add constraint professores_mes_niver_ck
    check(mes_niver >= 1 and mes_niver < 13);

alter table professores
add prof_cep char(7);

-- alterações no bancoDB

-- 1) O limite da conta deve ter como valor padrão 100,00

-- 2) O limite da conta não pode ser superior a 5000,00

-- 3) Modifique o nome da tabela conta para ContaCorrente

-- 4) Adicione a tabela Clientes o campo WhatsApp, do tipo char, tamanho 14, impedindo valores repetidos

-- 5) Exclua os campos dia_niver e mes_niver da tabela Clientes

-- 6) Adicione o campo data_de_nascimento na tabela clientes do tipo DateTime

-- COMANDOS DML
-- DML (Data Manipulation Language)
-- Inserir (INSERT), Alterar (UPDATE), Excluir (DELETE), Consultar (SELECT)

-- inserir um país
INSERT INTO PAISES(numero, nome)
VALUES(10, 'Brasil');

-- fixação cadastre o país Paraguai, com código 22
INSERT INTO PAISES
VALUES(22, 'Paraguai');

-- cadastrar 3 bancos conforme solicitado no word
INSERT INTO bancos
VALUES(141, 'Itaú', 10);

insert into bancos(pais, nome, numero)
values(22, 'La Grana', 654);

-- listar o nome de todos os bancos cadastrados
select nome from bancos;

-- cadastrar o banco bradesco
INSERT INTO bancos
VALUES(341, 'Bradesco', 10);

-- listar o nome de todos bancos do Brasil cadastrados
select nome from bancos
where pais = 10;

-- Listar o nome e o código de todos os bancos que não sejam do Brasil
select nome, numero
from bancos
where pais <> 10;

-- altere o nome do banco itaú para que fique sem acentuação
update bancos
set nome = 'Itau'
where numero = 141;

-- exclua todos os países cadastrados
delete from paises;

-- adicione o banco Real pertencente ao Paraguai
insert into bancos
values(342, 'Real', 22);

-- liste o nome e o país de todos os bancos cujo nome inicie com a letra R e não pertença ao Brasil


-- atualize o país de todos os bancos que possuem a letra E no nome para que pertençam a França
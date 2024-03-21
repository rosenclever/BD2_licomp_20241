-- ****** configurações do github
-- definindo o usuario
git init
git config --global user.name "rosenclever"
git config --global user.email "rosenclever@gmail.com"
git add .
git commit -m "aula do dia 14/03"
git remote add origin https://github.com/rosenclever/BD2_licomp_20241.git
git push -u origin master

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

--criar a tabela clientes
create table clientes(
    id int not null auto_increment,
    nome varchar(100) not null,
    email varchar(100) not null,
    constraint clientes_pk primary key(id)
);

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

-- fixacao produtos
alter table produtos
modify unidades varchar(50) default 'unidades';


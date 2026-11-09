create schema if not exists  dbex;


create table  if not exists  dbex.clientes (
    id_cliente int primary key,
    nome varchar(100) not null,
    email varchar(100) unique not null,
    data_nascimento date
);


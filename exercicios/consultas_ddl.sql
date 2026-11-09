create schema if not exists  dbex;


CREATE TABLE pessoa (
    cpf CHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf),
    CONSTRAINT uq_email UNIQUE (email, nome)
);
CREATE TABLE paciente (
    codigo INTEGER NOT NULL,
    cpf CHAR(11) NOT NULL,
    senha VARCHAR(10) NOT NULL,
    plano_saude BOOLEAN NOT NULL,
    CONSTRAINT pk_paciente PRIMARY KEY (codigo),
    CONSTRAINT uq_paciente_cpf UNIQUE (cpf),
    CONSTRAINT fk_paciente_pessoa FOREIGN KEY (cpf) REFERENCES pessoa(cpf),
    CONSTRAINT ck_paciente_paciente CHECK (plano_saude IN (0, 1)
)
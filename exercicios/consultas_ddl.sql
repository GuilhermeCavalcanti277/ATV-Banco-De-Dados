create schema if not exists dbex;

CREATE TABLE pessoa (
    cpf        CHAR(11)     NOT NULL,
    email      VARCHAR(50)  NOT NULL,
    nome       VARCHAR(150) NOT NULL,
    data_nasc  DATE         NOT NULL,
    endereco   VARCHAR(300) NOT NULL,
    telefone   VARCHAR(15)  NULL,
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf),
    CONSTRAINT pessoa_un UNIQUE (email, nome)
);

CREATE TABLE paciente (
    codigo       INTEGER     NOT NULL,
    cpf          CHAR(11)    NOT NULL,
    senha        VARCHAR(10) NOT NULL,
    plano_saude  BOOLEAN     NOT NULL,
    CONSTRAINT pk_paciente PRIMARY KEY (codigo),
    CONSTRAINT uq_paciente_cpf UNIQUE (cpf),
    CONSTRAINT fk_paciente_pessoa FOREIGN KEY (cpf) REFERENCES pessoa (cpf),
    CONSTRAINT ck_paciente_senha CHECK (senha ~ '^[A-Za-z0-9]{5,10}$')
);

CREATE TABLE medico (
    crm  VARCHAR(10) NOT NULL,
    cpf  CHAR(11)    NOT NULL,
    CONSTRAINT pk_medico PRIMARY KEY (crm),
    CONSTRAINT uq_medico_cpf UNIQUE (cpf),
    CONSTRAINT fk_medico_pessoa FOREIGN KEY (cpf) REFERENCES pessoa (cpf)
);

CREATE TABLE especialidade (
    id         INTEGER     NOT NULL,
    descricao  VARCHAR(50) NOT NULL,
    CONSTRAINT pk_especialidade PRIMARY KEY (id)
);

CREATE TABLE medico_especialidade (
    crm              VARCHAR(10) NOT NULL,
    id_especialidade INTEGER     NOT NULL,
    CONSTRAINT pk_medico_especialidade PRIMARY KEY (crm, id_especialidade),
    CONSTRAINT fk_me_medico FOREIGN KEY (crm) REFERENCES medico (crm),
    CONSTRAINT fk_me_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id)
);

CREATE TABLE agendamento (
    codigo_paciente  INTEGER      NOT NULL,
    crm              VARCHAR(10)  NOT NULL,
    dt_consulta      TIMESTAMP    NOT NULL,
    dt_agendamento   TIMESTAMP    NOT NULL,
    valor_consulta   NUMERIC(8,2) NOT NULL,
    CONSTRAINT pk_agendamento PRIMARY KEY (codigo_paciente, crm, dt_consulta),
    CONSTRAINT fk_agendamento_paciente FOREIGN KEY (codigo_paciente)
        REFERENCES paciente (codigo),
    CONSTRAINT fk_agendamento_medico FOREIGN KEY (crm) REFERENCES medico (crm),
    CONSTRAINT ck_agendamento_valor CHECK (valor_consulta >= 0)
);
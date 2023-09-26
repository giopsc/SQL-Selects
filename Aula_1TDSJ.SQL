-- Publico P:\1TDSJ\Correcao_CP1.SQL
-- Apagando as tabelas
DROP TABLE CP1_TBL_TELEFONES_PF1793 CASCADE CONSTRAINTS;
DROP TABLE CP1_TBL_FORNECEDORES_PF1793 CASCADE CONSTRAINTS;
DROP TABLE CP1_TBL_TIPO_TELEFONES_PF1793 CASCADE CONSTRAINTS;
DROP TABLE CP1_TBL_DESPESAS_PF1793 CASCADE CONSTRAINTS;
DROP TABLE CP1_TBL_CATEGORIAS_PF1793 CASCADE CONSTRAINTS;
DROP TABLE CP1_TBL_CIDADES_PF1793 CASCADE CONSTRAINTS;
DROP TABLE CP1_TBL_ESTADOS_PF1793 CASCADE CONSTRAINTS;

--Diagrama fisico.
CREATE TABLE cp1_tbl_estados_PF1793(
    sigla char(2) NOT NULL,
    nome_estado VARCHAR(30) NOT NULL,
    PRIMARY KEY(sigla)   
);

CREATE TABLE cp1_tbl_cidades_PF1793(
    id_cidade INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    nome_cidade VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_cidade),
    sigla CHAR(2) NOT NULL REFERENCES cp1_tbl_estados_PF1793 (sigla)
);

CREATE TABLE cp1_tbl_fornecedores_PF1793(
    id_fornecedor INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    PRIMARY KEY (id_fornecedor),
    nome VARCHAR(60) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(40) NOT NULL,
    complemento VARCHAR(10) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    id_cidade INTEGER REFERENCES cp1_tbl_cidades_PF1793(id_cidade),
    dt_cadastro DATE NOT NULL,
    email VARCHAR(80),
    status VARCHAR(7)
);

CREATE TABLE cp1_tbl_tipo_telefones_PF1793(
    id_tipo_tel INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    descricao VARCHAR(30) NOT NULL,
    --tbl_tipo_telefones_PF1793_ID NUMBER, -- Erro no diagrama
    PRIMARY KEY(id_tipo_tel)
);

CREATE TABLE cp1_tbl_telefones_PF1793(
    id_telefone INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    id_fornecedor INTEGER NOT NULL REFERENCES cp1_tbl_fornecedores_PF1793(id_fornecedor),
    id_tipo_tel INTEGER NOT NULL REFERENCES cp1_tbl_tipo_telefones_PF1793(id_tipo_tel),
    numero VARCHAR(20) NOT NULL,
    PRIMARY KEY(id_telefone)
);

CREATE TABLE cp1_tbl_categorias_PF1793(
    id_categoria INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    descricao VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_categoria)
);

CREATE TABLE cp1_tbl_despesas_PF1793(
    id_despesas INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    PRIMARY KEY(id_despesas),
    dt_cadastro DATE,
    id_fornecedor INTEGER NOT NULL REFERENCES cp1_tbl_fornecedores_PF1793(id_fornecedor),
    numero_dcto INTEGER NOT NULL,
    parcela_atual INTEGER NOT NULL,
    parcela_maxima INTEGER NOT NULL,
    dt_vencimento DATE NOT NULL ,
    valor NUMBER(10,2) NOT NULL,
    valor_pago NUMBER(10,2),
    id_categoria INTEGER NOT NULL REFERENCES cp1_tbl_categorias_PF1793(id_categoria),
    dt_pagamento DATE
);


--Inserindo registros
INSERT INTO cp1_tbl_estados_PF1793 (sigla, nome_estado) VALUES ('SP', 'São Paulo');

INSERT INTO cp1_tbl_cidades_PF1793 (nome_cidade, sigla) VALUES ('São Paulo','SP');
INSERT INTO cp1_tbl_cidades_PF1793 (nome_cidade, sigla) VALUES ('Campinas','SP');
INSERT INTO cp1_tbl_cidades_PF1793 (nome_cidade, sigla) VALUES ('Mairiporã','SP');

INSERT INTO cp1_tbl_tipo_telefones_PF1793 (descricao) VALUES ('Telefone');
INSERT INTO cp1_tbl_tipo_telefones_PF1793 (descricao) VALUES ('SAC');

--Primeira validação que exige atenção no checkpoint
ALTER TABLE cp1_tbl_fornecedores_PF1793 MODIFY complemento NULL;
INSERT INTO cp1_tbl_fornecedores_PF1793 (nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) VALUES ('Ferramentaria do Josué Ltda','Avenida Paulista','1515','Paulista','','1101010',(SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade = 'São Paulo'),current_date,'fe.josue@gmail.com','ATIVO');
INSERT INTO cp1_tbl_fornecedores_PF1793 (nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) VALUES ('Flix Tecnologia e Serviços Ltda','Rua Brasilia','23','Lapa','Sala 5','1101012',(SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade = 'São Paulo'),current_date,'flix@flix.com.br','ATIVO');
INSERT INTO cp1_tbl_fornecedores_PF1793 (nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) VALUES ('Rei dos Descartáveis Ltda','Rua Voluntários da Pátria','356','Santana','','1106012',(SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade = 'São Paulo'),current_date,'','ATIVO');
INSERT INTO cp1_tbl_fornecedores_PF1793 (nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) VALUES ('Manut Serviços de manutenção Ltda','Avenida Aquidaban','2000','Centro','','13250123',(SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade = 'Campinas'),current_date,'','ATIVO');
INSERT INTO cp1_tbl_fornecedores_PF1793 (nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) VALUES ('Serviços de Jardinagem Ltda','Rua Campinas','15','Centro','','1152222',(SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade = 'Mairiporã'),current_date,'','ATIVO');
INSERT INTO cp1_tbl_fornecedores_PF1793 (nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) VALUES ('ES Serviços Contábeis Ltda.','Avenida Pompéia','1500','Lapa','Sala 10','1101013',(SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade = 'São Paulo'),current_date, 'esservicocontabeis@gmail.com', 'ATIVO');

INSERT INTO cp1_tbl_telefones_PF1793 (ID_FORNECEDOR, ID_TIPO_TEL, NUMERO) VALUES (1, 1 , '(11)9965-2532');
INSERT INTO cp1_tbl_telefones_PF1793 (ID_FORNECEDOR, ID_TIPO_TEL, NUMERO) VALUES (2, 1 , '(11)9965-2533');
INSERT INTO cp1_tbl_telefones_PF1793 (ID_FORNECEDOR, ID_TIPO_TEL, NUMERO) VALUES (3, 2 , '1133556677');
INSERT INTO cp1_tbl_telefones_PF1793 (ID_FORNECEDOR, ID_TIPO_TEL, NUMERO) VALUES (4, 1 , '1925526565');
INSERT INTO cp1_tbl_telefones_PF1793 (ID_FORNECEDOR, ID_TIPO_TEL, NUMERO) VALUES (5, 1 , '1156565656');

INSERT INTO cp1_tbl_categorias_PF1793(descricao) VALUES ('Ferramentas');
INSERT INTO cp1_tbl_categorias_PF1793(descricao) VALUES ('Serviços de T.I');
INSERT INTO cp1_tbl_categorias_PF1793(descricao) VALUES ('Serviços contábeis');
INSERT INTO cp1_tbl_categorias_PF1793(descricao) VALUES ('Diversos');

INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 1, 10, TO_DATE('2023-08-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 2, 10, TO_DATE('2023-09-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 3, 10, TO_DATE('2023-10-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 4, 10, TO_DATE('2023-11-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 5, 10, TO_DATE('2023-12-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 6, 10, TO_DATE('2024-01-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 7, 10, TO_DATE('2024-02-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 8, 10, TO_DATE('2024-03-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 9, 10, TO_DATE('2024-04-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-01','YYYY-MM-DD'), 1, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Ferramentas'), 1516, 10, 10, TO_DATE('2024-05-15','YYYY-MM-DD'), 300.5);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-15','YYYY-MM-DD'), 2, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços de T.I'), 16988, 1, 1, TO_DATE('2023-08-15','YYYY-MM-DD'), 1356.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-09-02','YYYY-MM-DD'), 3, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Diversos'), 20230902, 1, 1, TO_DATE('2023-09-02','YYYY-MM-DD'), 120);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-02','YYYY-MM-DD'), 5, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 1, 12, TO_DATE('2024-01-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-30','YYYY-MM-DD'), 5, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Diversos'), 2023080, 1, 3, TO_DATE('2023-08-30','YYYY-MM-DD'), 150);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-30','YYYY-MM-DD'), 5, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Diversos'), 2023080, 2, 3, TO_DATE('2023-08-30','YYYY-MM-DD'), 150);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-30','YYYY-MM-DD'), 5, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Diversos'), 2023080, 3, 3, TO_DATE('2023-08-30','YYYY-MM-DD'), 150);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-02','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2023, 1, 5, TO_DATE('2023-08-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2023, 2, 5, TO_DATE('2023-09-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2023, 3, 5, TO_DATE('2023-10-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2023, 4, 5, TO_DATE('2023-11-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2023, 5, 5, TO_DATE('2023-12-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 2, 12, TO_DATE('2024-02-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 3, 12, TO_DATE('2024-03-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 4, 12, TO_DATE('2024-04-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 5, 12, TO_DATE('2024-05-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 6, 12, TO_DATE('2024-06-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 7, 12, TO_DATE('2024-07-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 8, 12, TO_DATE('2024-08-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 9, 12, TO_DATE('2024-09-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 10, 12, TO_DATE('2024-10-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 11, 12, TO_DATE('2024-11-19','YYYY-MM-DD'), 759.6);
INSERT INTO cp1_tbl_despesas_PF1793(dt_cadastro, id_fornecedor, id_categoria, numero_dcto, parcela_atual, parcela_maxima, dt_vencimento, valor) VALUES (TO_DATE('2023-08-03','YYYY-MM-DD'), 6, (SELECT id_categoria FROM cp1_tbl_categorias_PF1793 WHERE descricao ='Serviços contábeis'), 2024, 12, 12, TO_DATE('2024-12-19','YYYY-MM-DD'), 759.6);

--Lancamentos que foram pagos?
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 1 AND numero_dcto = 1516     AND parcela_atual = 1;
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 2 AND numero_dcto = 16988    AND parcela_atual = 1;
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 3 AND numero_dcto = 20230902 AND parcela_atual = 1;
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 5 AND numero_dcto = 2023080  AND parcela_atual = 1;
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 5 AND numero_dcto = 2023080  AND parcela_atual = 2;
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 5 AND numero_dcto = 2023080  AND parcela_atual = 3;
UPDATE cp1_tbl_despesas_PF1793 SET valor_pago = valor, dt_pagamento = dt_vencimento WHERE id_fornecedor = 6 AND numero_dcto = 2023     AND parcela_atual = 1;

--Conferindo os registros inseridos
SELECT 'tbl_despesas'       AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_despesas_PF1793       UNION 
SELECT 'tbl_fornecedores'   AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_fornecedores_PF1793   UNION 
SELECT 'tbl_estados'        AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_estados_PF1793        UNION 
SELECT 'tbl_cidades'        AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_cidades_PF1793        UNION 
SELECT 'tbl_categorias'     AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_categorias_PF1793     UNION 
SELECT 'tbl_tipo_telefones' AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_tipo_telefones_PF1793 UNION 
SELECT 'tbl_telefones'      AS name_table, COUNT(1) AS qtty_records FROM cp1_tbl_telefones_PF1793;

--2 - tbl_fornecedores_PF1793 - a.) Valor padrão no campo dt_cadastro para a data atual;
ALTER TABLE cp1_tbl_fornecedores_PF1793 MODIFY(dt_cadastro DEFAULT SYSDATE); --ou
ALTER TABLE cp1_tbl_fornecedores_PF1793 MODIFY(dt_cadastro DEFAULT current_date);

--2 - tbl_fornecedores_PF1793 - b.) Campo de Status deve ser obrigatório e aceitar somente os valores ATIVO e INATIVO;
ALTER TABLE cp1_tbl_fornecedores_PF1793 MODIFY ( status  NOT NULL);
ALTER TABLE cp1_tbl_fornecedores_PF1793 ADD CONSTRAINT chk_status CHECK (status IN ('ATIVO', 'INATIVO'));

--2 - tbl_despesas_PF1793 - c.) Valor padrão no campo dt_cadastro para a data atual;
ALTER TABLE cp1_tbl_despesas_PF1793 MODIFY (dt_cadastro DEFAULT SYSDATE); --ou
ALTER TABLE cp1_tbl_despesas_PF1793 MODIFY (dt_cadastro DATE DEFAULT current_date);

--2 - tbl_despesas_PF1793 - d.) A data de vencimento deve ser superior ou igual a data de cadastro;
-- O valor do atributo DT_LANCAMENTO (dt_cadastro) é igual ao SYSDATE, então podemos utilizá-la
ALTER TABLE cp1_tbl_despesas_PF1793
ADD CONSTRAINT chk_dt_vcto CHECK (DT_VENCIMENTO >= dt_cadastro );

--2 - tbl_despesas_PF1793 - e.) Altere o nome do atributo dt_cadastro para dt_lancamento;
ALTER TABLE cp1_tbl_despesas_PF1793 RENAME COLUMN dt_cadastro TO dt_lancamento;

--2 - tbl_despesas_PF1793 - f.) Adicione um atributo novo com a definição de situação 
--em que os valores aceitos devem ser PENDENTE, PAGO, EM ATRASO;
ALTER TABLE cp1_tbl_despesas_PF1793
  ADD situacao VARCHAR2(20) CHECK (situacao IN ('PENDENTE', 'PAGO', 'EM ATRASO'));

--2 - tbl_despesas_PF1793 - g.) Adicione comentários em todos os atributos para melhorar a documentação;
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.id_despesas IS 'ID da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.dt_lancamento IS 'Data de lançamento da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.id_fornecedor IS 'ID do fornecedor relacionado à despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.numero_dcto IS 'Número do documento da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.parcela_atual IS 'Número da parcela atual';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.parcela_maxima IS 'Número máximo de parcelas';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.dt_vencimento IS 'Data de vencimento da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.valor IS 'Valor da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.valor_pago IS 'Valor pago da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.id_categoria IS 'ID da categoria da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.dt_pagamento IS 'Data de pagamento da despesa';
COMMENT ON COLUMN cp1_tbl_despesas_PF1793.situacao IS 'Situação da despesa (PENDENTE, PAGO, EM ATRASO)';

--2 - tbl_despesas_PF1793 - h.) O valor das despesas deve ser obrigatório e maior que ZERO;
ALTER TABLE cp1_tbl_despesas_PF1793 ADD CONSTRAINT check_valor_maior_que_zero CHECK (valor > 0);

--2 - tbl_despesas_PF1793 - i.) O valor de parcela_atual não deve ser maior que o parcela_maxima;
ALTER TABLE cp1_tbl_despesas_PF1793
ADD CONSTRAINT check_parcela_atual_menor_ou_igual_parcela_maxima CHECK (parcela_atual <= parcela_maxima);

-- 3 - a.) Houve uma alteração de preço dos serviços do fornecedor ES Serviços Contábeis Ltda.
--A partir de 01/01/2024 em 10% calcule o valor e atualize as despesas após essa data;

SELECT id_fornecedor, dt_vencimento, valor, (valor*1.10) as acrescimo
  FROM cp1_tbl_despesas_PF1793
 WHERE id_fornecedor = 6 AND dt_vencimento >= TO_DATE('01/01/2024', 'DD/MM/YYYY');
--835.56
UPDATE cp1_tbl_despesas_PF1793
SET valor = valor * 1.10 
WHERE id_fornecedor = 6 --ES Serviços Contábeis Ltda
AND dt_vencimento >= TO_DATE('01/01/2024', 'DD/MM/YYYY');

--Conferindo
SELECT * FROM cp1_tbl_despesas_PF1793 WHERE id_fornecedor = 6 AND dt_vencimento >= TO_DATE('01/01/2024', 'DD/MM/YYYY');

-- 3 - b.) Atualize o nome do fornecedor “Manut Serviços de manutenção Ltda” para “Serviços de Manutenção Ltda”;

UPDATE cp1_tbl_fornecedores_PF1793
SET nome = 'Serviços de Manutenção Ltda' WHERE id_fornecedor = 4;

-- 3 - c.) Inative todos os fornecedores que não estão na cidade de São Paulo;

UPDATE cp1_tbl_fornecedores_PF1793 SET status = 'INATIVO'
WHERE id_cidade NOT IN (SELECT id_cidade FROM cp1_tbl_cidades_PF1793 WHERE nome_cidade= 'São Paulo');

/*
-- 3 - d.) Adicione o seguinte fornecedor: 
    Hotel Manjubinha – Congressos e Convenções Ltda.
    Rua Beira Rio, 1655 – Praia Sul
    Balneário Camboriú – Santa Catarina
    CEP 22333-333
    Telefone (54) 6598-9898
*/

INSERT INTO cp1_tbl_estados_PF1793 (sigla, nome_estado) VALUES ('SC', 'Santa Catarina');
INSERT INTO cp1_tbl_cidades_PF1793 (nome_cidade, sigla) VALUES ('Balneário Camboriú', 'SC'); --4
INSERT INTO cp1_tbl_fornecedores_PF1793 (dt_cadastro, nome, endereco, numero, bairro, cep, id_cidade, email, status, complemento)
VALUES (TO_DATE('06/08/2023', 'DD/MM/YYYY'), 'Hotel Manjubinha – Congressos e Convenções Ltda.', 'Rua Beira Rio', '1655', 'Praia Sul', '22333333', 4, '', 'ATIVO', '');
INSERT INTO cp1_tbl_telefones_PF1793(id_fornecedor, numero, id_tipo_tel) VALUES (7,'(54) 6598-9898',1);


-- 3 - e.) Adicione uma nova categoria com a descrição: Congressos e Convenções;
INSERT INTO cp1_tbl_categorias_PF1793 (descricao) VALUES ('Congressos e Convenções');

-- 3 - f.) Adicione a despesas no valor R$ 500,00 para o Hotel Manjubinha – Congressos e Convenções Ltda, na categoria Congressos e Convenções;
--SELECT id_categoria, descricao FROM cp1_tbl_categorias_PF1793; --5
--SELECT id_fornecedor, nome FROM cp1_tbl_fornecedores_PF1793 ; --7
INSERT INTO cp1_tbl_despesas_PF1793 (id_fornecedor, id_categoria, parcela_atual, parcela_maxima, valor, dt_vencimento, numero_dcto)
                             VALUES (7, 5, 1, 1, 500 , TO_DATE('2023-09-30', 'YYYY-MM-DD'), 1);

--


/*
3 - g.) Atualize o campo de status situação que foi adicionado na tabela tbl_despesas_RMxxxxx conforme a condição abaixo:
Todos os registros sem data de pagamento e a data atual maior que o vencimento deve ficar como PENDENTE;
Todos os registros com data de pagamento e valor de pagamento preenchido atualizar para PAGO;
Todos os registros sem informações de pagamento e data de vencimento menor que hoje: EM ATRASO;
*/
UPDATE cp1_tbl_despesas_PF1793 SET situacao = 'PENDENTE' WHERE dt_pagamento IS NULL AND valor_pago IS NULL;
UPDATE cp1_tbl_despesas_PF1793 SET situacao = 'PAGO' WHERE dt_pagamento IS NOT NULL AND valor_pago IS NOT NULL;
UPDATE cp1_tbl_despesas_PF1793 SET situacao = 'EM ATRASO' WHERE dt_pagamento IS NULL AND TO_DATE(SYSDATE, 'DD/MM/YYYY') > dt_vencimento;
--ou
UPDATE cp1_tbl_despesas_PF1793
SET situacao = CASE
                  WHEN valor_pago IS NULL AND dt_vencimento < SYSDATE THEN 'EM ATRASO'
                  WHEN valor_pago IS NULL AND dt_vencimento >= SYSDATE THEN 'PENDENTE'
                  WHEN valor_pago IS NOT NULL THEN 'PAGO'
               ELSE situacao
               END;

SELECT dt_vencimento, valor, dt_pagamento, valor_pago, situacao,
       CASE
           WHEN valor_pago IS NULL AND dt_vencimento < SYSDATE THEN 'EM ATRASO'
           WHEN valor_pago IS NULL AND dt_vencimento >= SYSDATE THEN 'PENDENTE'
           WHEN valor_pago IS NOT NULL THEN 'PAGO'
       END as situacao
FROM cp1_tbl_despesas_PF1793
  ORDER BY dt_vencimento;


--- Fim da correção




--Usando o comando CASE...
SELECT dt_vencimento, valor, dt_pagamento, valor_pago, situacao,
       CASE
           WHEN valor_pago IS NULL AND dt_vencimento < SYSDATE THEN 'EM ATRASO'
           WHEN valor_pago IS NULL AND dt_vencimento >= SYSDATE THEN 'PENDENTE'
           WHEN valor_pago IS NOT NULL THEN 'PAGO'
       END as situacao,
       CASE 
          WHEN valor_pago IS NULL AND (dt_vencimento - current_date) <= 10 THEN '+10 dias'
          WHEN valor_pago IS NULL AND (dt_vencimento - current_date) <= 30 THEN '+30 dias'
          WHEN valor_pago IS NULL AND (dt_vencimento - current_date) < 60 THEN '+60 dias'
          ELSE 'Vencimento futuro'
       END as dias_em_aberto
  FROM cp1_tbl_despesas_PF1793
  ORDER BY dt_vencimento;


--Usando funções de agregação
DESCRIBE cp1_tbl_despesas_PF1793;

SELECT SUM(valor) AS valor FROM cp1_tbl_despesas_PF1793;

  SELECT id_fornecedor,
         SUM(valor) AS valor
    FROM cp1_tbl_despesas_PF1793
GROUP BY id_fornecedor;

--INNER JOIN - Todos os registros que participam das N tabelas
  SELECT fornecedores.nome,
         SUM(valor) AS valor
    FROM cp1_tbl_despesas_PF1793 despesas
    INNER JOIN cp1_tbl_fornecedores_PF1793 fornecedores
        ON despesas.id_fornecedor = fornecedores.id_fornecedor
    INNER JOIN CP1_TBL_CIDADES_PF1793 cidades
        ON cidades.id_cidade = fornecedores.id_cidade
GROUP BY fornecedores.nome;

--Despesas por fornecedores, independente se teve ou não movimentação. LEFT
SELECT fornecedores.nome, COALESCE( SUM(valor) , 0 )  as Valor
  FROM cp1_tbl_fornecedores_PF1793 fornecedores
LEFT JOIN cp1_tbl_despesas_PF1793 despesas
  ON despesas.id_fornecedor = fornecedores.id_fornecedor
GROUP BY fornecedores.nome;


--Listagem de despesas
SELECT fornecedores.nome, valor, dt_vencimento
  FROM cp1_tbl_despesas_PF1793 despesas
LEFT JOIN cp1_tbl_fornecedores_PF1793 fornecedores
  ON despesas.id_fornecedor = fornecedores.id_fornecedor
WHERE fornecedores.id_fornecedor = :ID_FORNECEDOR --definindo uma variavel.
ORDER BY fornecedores.nome, dt_vencimento;

SELECT despesas.dt_vencimento,
       despesas.valor,
       categoria.descricao,
       fornecedores.nome
  FROM cp1_tbl_despesas_PF1793 despesas
  INNER JOIN cp1_tbl_categorias_PF1793 categoria
      ON despesas.id_categoria = categoria.id_categoria
  INNER JOIN cp1_tbl_fornecedores_PF1793 fornecedores
  ON despesas.id_fornecedor = fornecedores.id_fornecedor

--Montando um grafico
SELECT to_char(dt_vencimento, 'YYYY-MM') as anomes,
       situacao,
       SUM(valor) as valor
FROM cp1_tbl_despesas_PF1793 despesas
GROUP BY to_char(dt_vencimento, 'YYYY-MM'), situacao

/*
Serie: data, sequencial, dias-mes-ano
Legenda:  descricao (grupos)
Valor: que será exibido no gráfico
*/



SELECT despesas.dt_vencimento,
       fornecedores.nome,
       despesas.valor       
  FROM cp1_tbl_despesas_PF1793 despesas
  INNER JOIN cp1_tbl_fornecedores_PF1793 fornecedores
  ON despesas.id_fornecedor = fornecedores.id_fornecedor;

INSERT INTO cp1_tbl_categorias_PF1793 (descricao) VALUES ('Alimentação');

--
SELECT despesas.valor, categoria.descricao
FROM cp1_tbl_despesas_PF1793 despesas
RIGHT JOIN cp1_tbl_categorias_PF1793 categoria
    ON categoria.id_categoria = despesas.id_categoria;

  
SELECT fornecedor.nome, 
       COALESCE( telefone.numero , ' ')
FROM CP1_TBL_FORNECEDORES_PF1793 fornecedor
LEFT JOIN CP1_TBL_TELEFONES_PF1793 telefone ON 
   fornecedor.id_fornecedor = telefone.id_fornecedor

MESTRE-DETALHE











--INNER JOIN
      SELECT SUM(despesas.valor) AS valor, fornecedores.nome
        FROM cp1_tbl_despesas_PF1793 despesas
  INNER JOIN cp1_tbl_fornecedores_Pf1793 fornecedores
          ON despesas.id_fornecedor = fornecedores.id_fornecedor
    GROUP BY fornecedores.nome
    ORDER BY 1 DESC;

--LEFT JOIN
      SELECT SUM(despesas.valor) AS valor, fornecedores.nome
        FROM cp1_tbl_despesas_PF1793 despesas
  LEFT JOIN cp1_tbl_fornecedores_Pf1793 fornecedores
          ON despesas.id_fornecedor = fornecedores.id_fornecedor
    GROUP BY fornecedores.nome
    ORDER BY 1 DESC;

--RIGHT JOIN
      SELECT SUM(despesas.valor) AS valor, fornecedores.nome
        FROM cp1_tbl_despesas_PF1793 despesas
  RIGHT JOIN cp1_tbl_fornecedores_Pf1793 fornecedores
          ON despesas.id_fornecedor = fornecedores.id_fornecedor
    GROUP BY fornecedores.nome
    ORDER BY 1 DESC;

--COALESCE

SELECT id_fornecedor, nome FROM cp1_tbl_fornecedores_PF1793;

  SELECT TO_CHAR(dt_vencimento, 'YYYY-MM') AS periodo,
         SUM(valor) AS valor
    FROM cp1_tbl_despesas_PF1793 despesas
   WHERE id_fornecedor = :ID_FORNECEDOR
GROUP BY to_char(dt_vencimento, 'YYYY-MM')
ORDER BY 1;

SELECT to_char(dt_vencimento, 'YYYY-MM') as periodo, SUM(valor) AS valor
  FROM cp1_tbl_despesas_PF1793 despesas
GROUP BY to_char(dt_vencimento, 'YYYY-MM')
ORDER BY 1 ASC;

--Criando um novo relatório no SQL Developer
-- Gráfico
-- Mestre detalhe



SELECT id_fornecedor, nome FROM cp1_tbl_fornecedores_PF1793

SELECT despesas.*
  FROM cp1_tbl_despesas_PF1793 despesas
WHERE id_fornecedor = :ID_FORNECEDOR --definindo uma variavel.
ORDER BY dt_vencimento;

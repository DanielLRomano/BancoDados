CREATE DATABASE PIZZARIA;

CREATE TABLE IF NOT EXISTS CONTATOS (
    ID_CONTATO INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    CEL VARCHAR(255) NOT NULL,
    PIZZA VARCHAR(255) NOT NULL,
    CADASTRO DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE IF NOT EXISTS ENTREGAS (
    ID_ENTREGAS INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    CEL VARCHAR(255) NOT NULL,
    PIZZA VARCHAR(255) NOT NULL,
    CADASTRO DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ENTREGA VARCHAR(255) NOT NULL CHECK (ENTREGA IN ('Em Andamento', 'Finalizada')) 
)

CREATE TABLE IF NOT EXISTS PEDIDO (
    ID_PEDIDO SERIAL PRIMARY KEY, 
    ID_ENTREGAS INT NOT NULL, 
    ID_CONTATO INT NOT NULL, 
    ID_PIZZA INT NOT NULL, 
    DATA_PEDIDO DATE NOT NULL, 
    CONSTRAINT FK_ID_ENTREGAS FOREIGN KEY (ID_ENTREGAS) REFERENCES ENTREGAS (ID_ENTREGAS),
    CONSTRAINT FK_ID_PIZZA FOREIGN KEY (ID_PIZZA) REFERENCES PIZZAS (ID_PIZZA),
    CONSTRAINT FK_ID_CONTATO FOREIGN KEY (ID_CONTATO) REFERENCES CONTATOS (ID_CONTATO)
)

CREATE TABLE IF NOT EXISTS PIZZAS(
    ID_PIZZA SERIAL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL, 
    PRECO DECIMAL(10,2) NOT NULL, 
    INGREDIENTES TEXT NOT NULL
)

INSERT INTO PIZZAS (NOME, PRECO, INGREDIENTES) VALUES 
    ('Margherita', 20.99, 'Molho de tomate, mussarela, manjericão'),
    ('Pepperoni', 22.99, 'Molho de tomate, mussarela, pepperoni'),
    ('Calabresa', 21.99, 'Molho de tomate, mussarela, calabresa'),
    ('Quatro Queijos', 23.99, 'Molho de tomate, mussarela, gorgonzola, parmesão, catupiry'),
    ('Frango com Catupiry', 24.99, 'Molho de tomate, frango desfiado, catupiry'),
    ('Portuguesa', 23.99, 'Molho de tomate, mussarela, presunto, ovos, cebola, azeitonas'),
    ('Vegetariana', 22.99, 'Molho de tomate, mussarela, palmito, champignon, pimentão, cebola, tomate'),
    ('Napolitana', 24.99, 'Molho de tomate, mussarela, tomate, parmesão, azeitonas'),
    ('Bacon com Milho', 25.99, 'Molho de tomate, mussarela, bacon, milho, catupiry'),
    ('Brigadeiro', 18.99, 'Chocolate, granulado')


INSERT INTO CONTATOS (ID_CONTATO, NOME, EMAIL, CEL, PIZZA) VALUES 
    (1, 'João Silva', 'joao@example.com', '(11) 91234-5678', 'Margherita'),
    (2, 'Maria Oliveira', 'maria@example.com', '(21) 98765-4321', 'Pepperoni'),
    (3, 'José Santos', 'jose@example.com', '(31) 99876-5432', 'Calabresa'),
    (4, 'Ana Souza', 'ana@example.com', '(41) 92345-6789', 'Quatro Queijos'),
    (5, 'Pedro Costa', 'pedro@example.com', '(51) 93456-7890', 'Frango com Catupiry'),
    (6, 'Carla Pereira', 'carla@example.com', '(61) 94567-8901', 'Portuguesa'),
    (7, 'Lucas Ferreira', 'lucas@example.com', '(71) 95678-9012', 'Vegetariana'),
    (8, 'Mariana Almeida', 'mariana@example.com', '(81) 96789-0123', 'Napolitana'),
    (9, 'Fernando Lima', 'fernando@example.com', '(91) 97890-1234', 'Bacon com Milho'),
    (10, 'Camila Ribeiro', 'camila@example.com', '(01) 98701-2345', 'Brigadeiro');


INSERT INTO ENTREGAS (ID_ENTREGAS, NOME, EMAIL, CEL, PIZZA, ENTREGA) 
SELECT ID_CONTATO, NOME, EMAIL, CEL, PIZZA, 'Em Andamento' FROM CONTATOS;


INSERT INTO PEDIDO (ID_ENTREGAS, ID_CONTATO, ID_PIZZA, DATA_PEDIDO) VALUES 
    (1, 1, 1, '2024-05-24'),
    (2, 2, 2, '2024-05-24'),
    (3, 3, 3, '2024-05-24'),
    (4, 4, 4, '2024-05-24'),
    (5, 5, 5, '2024-05-24'),
    (6, 6, 6, '2024-05-24'),
    (7, 7, 7, '2024-05-24'),
    (8, 8, 8, '2024-05-24'),
    (9, 9, 9, '2024-05-24'),
    (10, 10, 10, '2024-05-24');
    

-- exercicio 1
SELECT 
    P.ID_PEDIDO,
    C.NOME AS NOME_CLIENTE,
    C.EMAIL AS EMAIL_CLIENTE,
    C.CEL AS CELULAR_CLIENTE,
    C.PIZZA AS PIZZA_PEDIDA,
    PI.NOME AS NOME_PIZZA,
    PI.PRECO AS PRECO_PIZZA,
    PI.INGREDIENTES AS INGREDIENTES_PIZZA,
    P.DATA_PEDIDO
FROM 
    PEDIDO P
JOIN 
    CONTATOS C ON P.ID_CONTATO = C.ID_CONTATO
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA;


-- exercicio 2
SELECT 
    P.ID_PEDIDO,
    PI.NOME AS NOME_PIZZA,
    PI.PRECO AS PRECO_PIZZA,
    PI.INGREDIENTES AS INGREDIENTES_PIZZA
FROM 
    PEDIDO P
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA;


-- exercicio 3
CREATE TABLE FUNCIONARIOS_AREAS (
    ID SERIAL PRIMARY KEY,
    NOME_FUNCIONARIO VARCHAR(255) NOT NULL,
    AREA_TRABALHO VARCHAR(255) NOT NULL
);

INSERT INTO FUNCIONARIOS_AREAS (NOME_FUNCIONARIO, AREA_TRABALHO) VALUES
    ('João Silva', 'Atendimento ao Cliente'),
    ('Maria Oliveira', 'Cozinha'),
    ('José Santos', 'Entrega'),
    ('Ana Souza', 'Limpeza'),
    ('Pedro Costa', 'Atendimento ao Cliente'),
    ('Carla Pereira', 'Cozinha'),
    ('Lucas Ferreira', 'Atendimento ao Cliente'),
    ('Mariana Almeida', 'Cozinha'),
    ('Fernando Lima', 'Entrega'),
    ('Camila Ribeiro', 'Atendimento ao Cliente');


SELECT NOME_FUNCIONARIO, AREA_TRABALHO
FROM FUNCIONARIOS_AREAS;

-- exercicio 4
CREATE TABLE FUNCIONARIOS_PEDIDOS (
    ID_PEDIDO INT,
    ID_FUNCIONARIO INT,
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO(ID_PEDIDO),
    FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIOS_AREAS(ID)
)

INSERT INTO FUNCIONARIOS_PEDIDOS (ID_PEDIDO, ID_FUNCIONARIO)
SELECT ID_PEDIDO, ID
FROM PEDIDO, FUNCIONARIOS_AREAS
LIMIT 10;


SELECT 
    P.ID_PEDIDO,
    E.ENTREGA AS STATUS,
    FA.NOME_FUNCIONARIO AS FUNCIONARIO_RESPONSAVEL
FROM 
    PEDIDO P
JOIN 
    ENTREGAS E ON P.ID_ENTREGAS = E.ID_ENTREGAS
JOIN 
    FUNCIONARIOS_PEDIDOS FP ON P.ID_PEDIDO = FP.ID_PEDIDO
JOIN 
    FUNCIONARIOS_AREAS FA ON FP.ID_FUNCIONARIO = FA.ID;


-- exercicio 5
SELECT 
    C.ID_CONTATO,
    C.NOME AS NOME_CLIENTE,
    C.EMAIL AS EMAIL_CLIENTE,
    C.CEL AS CELULAR_CLIENTE,
    C.PIZZA AS PIZZA_PEDIDA,
    P.DATA_PEDIDO
FROM 
    CONTATOS C
JOIN 
    PEDIDO P ON C.ID_CONTATO = P.ID_CONTATO;


-- exercicio 6 
SELECT 
    NOME AS NOME_PIZZA,
    INGREDIENTES
FROM 
    PIZZAS;


-- exercicio 7 
SELECT 
    P.ID_PEDIDO,
    P.ID_ENTREGAS,
    E.NOME AS NOME_CLIENTE,
    E.EMAIL AS EMAIL_CLIENTE,
    E.CEL AS CELULAR_CLIENTE,
    E.PIZZA AS PIZZA_ENTREGA,
    E.CADASTRO AS DATA_ENTREGA,
    E.ENTREGA AS STATUS_ENTREGA
FROM 
    PEDIDO P
JOIN 
    ENTREGAS E ON P.ID_ENTREGAS = E.ID_ENTREGAS;


-- exercicio 8
-- Passo 1: Criar a tabela SUPERVISORES
CREATE TABLE SUPERVISORES (
    ID SERIAL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL
);

-- Passo 2: Adicionar coluna na tabela FUNCIONARIOS_AREAS para armazenar o ID do supervisor
ALTER TABLE FUNCIONARIOS_AREAS
ADD COLUMN ID_SUPERVISOR INT,
ADD CONSTRAINT fk_supervisor FOREIGN KEY (ID_SUPERVISOR) REFERENCES SUPERVISORES(ID);

-- Passo 3: Inserir dados na tabela SUPERVISORES
INSERT INTO SUPERVISORES (NOME)
VALUES 
    ('Supervisor 1'),
    ('Supervisor 2'),
    ('Supervisor 3');

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 1
WHERE NOME_FUNCIONARIO = 'João Silva';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 2
WHERE NOME_FUNCIONARIO = 'Maria Oliveira';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 3
WHERE NOME_FUNCIONARIO = 'José Santos';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 1
WHERE NOME_FUNCIONARIO = 'Ana Souza';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 2
WHERE NOME_FUNCIONARIO = 'Pedro Costa';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 3
WHERE NOME_FUNCIONARIO = 'Carla Pereira';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 1
WHERE NOME_FUNCIONARIO = 'Lucas Ferreira';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 2
WHERE NOME_FUNCIONARIO = 'Mariana Almeida';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 3
WHERE NOME_FUNCIONARIO = 'Fernando Lima';

UPDATE FUNCIONARIOS_AREAS
SET ID_SUPERVISOR = 1
WHERE NOME_FUNCIONARIO = 'Camila Ribeiro';


SELECT * FROM FUNCIONARIOS_AREAS


-- exercicio 9 
ALTER TABLE PIZZAS
ADD COLUMN TAMANHO VARCHAR(50);

UPDATE PIZZAS
SET TAMANHO = CASE 
    WHEN NOME = 'Margherita' THEN 'Média'
    WHEN NOME = 'Pepperoni' THEN 'Grande'
    WHEN NOME = 'Calabresa' THEN 'Média'
    -- Adicione outras pizzas com seus respectivos tamanhos aqui
    ELSE 'Média' -- Defina um tamanho padrão para pizzas não especificadas
END;

SELECT 
    P.ID_PEDIDO,
    PI.NOME AS NOME_PIZZA,
    PI.TAMANHO AS TAMANHO_PIZZA,
    PI.PRECO AS PRECO_PIZZA,
    PI.INGREDIENTES AS INGREDIENTES_PIZZA
FROM 
    PEDIDO P
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA;


-- exercicio 10 
CREATE TABLE IF NOT EXISTS PROMOCOES (
    ID_PROMOCAO SERIAL PRIMARY KEY,
    NOME_PROMOCAO VARCHAR(255) NOT NULL,
    DESCONTO DECIMAL(5,2) NOT NULL
);

INSERT INTO PROMOCOES (NOME_PROMOCAO, DESCONTO) VALUES
    ('Desconto de 10%', 0.10),
    ('Promoção de Verão', 0.15),
    ('Combo Família', 0.20);


ALTER TABLE PIZZAS
ADD COLUMN ID_PROMOCAO INT,
ADD CONSTRAINT FK_ID_PROMOCAO FOREIGN KEY (ID_PROMOCAO) REFERENCES PROMOCOES(ID_PROMOCAO);


UPDATE PIZZAS
SET ID_PROMOCAO = 1
WHERE NOME = 'Margherita';

UPDATE PIZZAS
SET ID_PROMOCAO = 2
WHERE NOME = 'Pepperoni';

UPDATE PIZZAS
SET ID_PROMOCAO = 3
WHERE NOME = 'Calabresa';


SELECT 
    P.NOME AS NOME_PIZZA,
    PR.NOME_PROMOCAO AS PROMOCAO,
    PR.DESCONTO AS DESCONTO_PROMOCAO
FROM 
    PIZZAS P
LEFT JOIN 
    PROMOCOES PR ON P.ID_PROMOCAO = PR.ID_PROMOCAO;



-- Segunda Parte

-- exercicio 1
SELECT DISTINCT
    C.ID_CONTATO,
    C.NOME AS NOME_CLIENTE,
    C.EMAIL AS EMAIL_CLIENTE,
    C.CEL AS CELULAR_CLIENTE
FROM 
    CONTATOS C
JOIN 
    PEDIDO P ON C.ID_CONTATO = P.ID_CONTATO;


-- exercicio 2 
SELECT 
    P.ID_PEDIDO,
    P.ID_ENTREGAS,
    E.NOME AS NOME_CLIENTE,
    E.EMAIL AS EMAIL_CLIENTE,
    E.CEL AS CELULAR_CLIENTE,
    E.PIZZA AS PIZZA_ENTREGA,
    E.CADASTRO AS DATA_ENTREGA,
    E.ENTREGA AS STATUS_ENTREGA
FROM 
    PEDIDO P
JOIN 
    ENTREGAS E ON P.ID_ENTREGAS = E.ID_ENTREGAS
WHERE 
    P.DATA_PEDIDO BETWEEN '2024-05-01' AND '2024-05-31';


-- exercicio 3 
SELECT 
    P.ID_PEDIDO,
    PI.NOME AS NOME_PIZZA,
    PI.PRECO AS PRECO_PIZZA,
    PI.INGREDIENTES AS INGREDIENTES_PIZZA
FROM 
    PEDIDO P
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA
WHERE 
    P.ID_PEDIDO = 1;


-- exercicio 4
SELECT 
    C.NOME AS NOME_CLIENTE,
    SUM(PI.PRECO) AS TOTAL_GASTO
FROM 
    CONTATOS C
JOIN 
    PEDIDO P ON C.ID_CONTATO = P.ID_CONTATO
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA
WHERE 
    C.ID_CONTATO = 1 
GROUP BY 
    C.NOME;


-- exercicio 5
SELECT 
    PI.NOME AS NOME_PIZZA,
    COUNT(*) AS QUANTIDADE_PEDIDOS
FROM 
    PEDIDO P
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA
GROUP BY 
    PI.NOME
ORDER BY 
    QUANTIDADE_PEDIDOS DESC;


-- exercicio 6
SELECT 
    NOME AS NOME_PIZZA,
    PRECO,
    INGREDIENTES
FROM 
    PIZZAS
WHERE 
    NOME = 'Pepperoni';


-- exercicio 7
SELECT 
    FA.ID,
    FA.NOME_FUNCIONARIO,
    FA.AREA_TRABALHO,
    S.NOME AS NOME_SUPERVISOR
FROM 
    FUNCIONARIOS_AREAS FA
LEFT JOIN 
    SUPERVISORES S ON FA.ID_SUPERVISOR = S.ID;


-- exercicio 8
    CREATE TABLE HORARIOS_FUNCIONAMENTO (
    ID INT PRIMARY KEY,
    DIA_SEMANA VARCHAR(50) NOT NULL,
    ABERTURA TIME NOT NULL,
    FECHAMENTO TIME NOT NULL
);

INSERT INTO HORARIOS_FUNCIONAMENTO (ID, DIA_SEMANA, ABERTURA, FECHAMENTO) VALUES
(1, 'Segunda-feira', '10:00:00', '22:00:00'),
(2, 'Terça-feira', '10:00:00', '22:00:00'),
(3, 'Quarta-feira', '10:00:00', '22:00:00'),
(4, 'Quinta-feira', '10:00:00', '22:00:00'),
(5, 'Sexta-feira', '10:00:00', '23:00:00'),
(6, 'Sábado', '11:00:00', '23:00:00'),
(7, 'Domingo', '11:00:00', '21:00:00');

SELECT 
    DIA_SEMANA,
    ABERTURA,
    FECHAMENTO
FROM 
    HORARIOS_FUNCIONAMENTO;


-- exercicio 9
SELECT 
    P.ID_PEDIDO,
    C.NOME AS NOME_CLIENTE,
    C.EMAIL AS EMAIL_CLIENTE,
    C.CEL AS CELULAR_CLIENTE,
    PI.NOME AS NOME_PIZZA,
    P.DATA_PEDIDO,
    E.ENTREGA AS STATUS_ENTREGA
FROM 
    PEDIDO P
JOIN 
    CONTATOS C ON P.ID_CONTATO = C.ID_CONTATO
JOIN 
    PIZZAS PI ON P.ID_PIZZA = PI.ID_PIZZA
JOIN 
    ENTREGAS E ON P.ID_ENTREGAS = E.ID_ENTREGAS
WHERE 
    E.ENTREGA = 'Em Andamento';


-- exercicio 10 
ALTER TABLE ENTREGAS
ADD COLUMN DATA_ENTREGA TIMESTAMP;

SELECT 
    AVG(EXTRACT(EPOCH FROM (E.DATA_ENTREGA - P.DATA_PEDIDO)) / 60) AS TEMPO_MEDIO_ESPERA_MINUTOS
FROM 
    PEDIDO P
JOIN 
    ENTREGAS E ON P.ID_ENTREGAS = E.ID_ENTREGAS
WHERE 
    E.DATA_ENTREGA IS NOT NULL;



































































CREATE DATABASE SA05_Banco_DanielRomano;

CREATE TABLE Clientes (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Sobrenome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE PEDIDOS (
    ID SERIAL PRIMARY KEY,
    ID_CLIENTES SERIAL NOT NULL,
    DATA_PEDIDO DATE NOT NULL,
    TOTAL DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ID_CLIENTES) REFERENCES Clientes (ID)
);

CREATE TABLE PRODUTOS (
    ID SERIAL PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    DESCRICAO TEXT NOT NULL,
    PRECO DECIMAL(10, 2) NOT NULL CHECK (PRECO >= 0)
);

CREATE TABLE CATEGORIAS(
    ID SERIAL PRIMARY KEY,
    NOME VARCHAR (100) NOT NULL
);

CREATE TABLE PEDIDOS_PRODUTOS (
    ID_PEDIDO SERIAL NOT NULL,
    ID_PRODUTO SERIAL NOT NULL,
    FOREIGN KEY (ID_PEDIDO) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_PRODUTO) REFERENCES Produtos(ID),
    PRIMARY KEY (ID_PEDIDO, ID_PRODUTO)
);

CREATE TABLE PRODUTOS_CATEGORIAS(
    ID_PRODUTO SERIAL NOT NULL,
    ID_CATEGORIA SERIAL NOT NULL,
    FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTOS(ID),
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIAS(ID),
    PRIMARY KEY (ID_PRODUTO, ID_CATEGORIA)
);

CREATE TABLE EMPREGADOS (
    ID SERIAL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    SOBRENOME VARCHAR(255) NOT NULL,
    CARGO VARCHAR(255) NOT NULL CHECK (CARGO IN ('Gerente', 'Vendedor', 'Atendente'))
);

CREATE TABLE VENDAS (
    ID SERIAL PRIMARY KEY, 
    ID_PRODUTO SERIAL NOT NULL, 
    ID_CLIENTES SERIAL NOT NULL, 
    DATA_VENDA DATE NOT NULL, 
    QUANTIDADE INT NOT NULL, 
    FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTOS(ID),
    FOREIGN KEY (ID_CLIENTES) REFERENCES Clientes(ID)
);


ALTER TABLE Clientes
ADD TELEFONE VARCHAR(20); 

ALTER TABLE PRODUTOS
ALTER COLUMN DESCRICAO DROP NOT NULL;

ALTER TABLE PEDIDOS
DROP CONSTRAINT pedidos_id_clientes_fkey;

ALTER TABLE EMPREGADOS
RENAME TO FUNCIONARIOS;

INSERT INTO Clientes (Nome, Sobrenome, Email, Telefone)
VALUES
    ('Maria', 'Silva', 'maria.silva@senai.com', '123-456-7890'),
    ('João', 'Santos', 'joao.santos@senai.com', '987-654-3210'),
    ('Ana', 'Pereira', 'ana.pereira@senai.com', '555-123-4567'),
    ('Pedro', 'Gomes', 'pedro.gomes@senai.com', '777-888-9999'),
    ('Carla', 'Rodrigues', 'carla.rodrigues@senai.com', '111-222-3333');


INSERT INTO Pedidos (ID_Clientes, Data_Pedido, Total)
VALUES
    (1, '2024-04-15', 50.00),
    (2, '2024-04-16', 75.50),
    (3, '2024-04-17', 120.00),
    (4, '2024-04-18', 45.75),
    (5, '2024-04-19', 90.25),
    (1, '2024-04-20', 60.00),
    (2, '2024-04-21', 85.00),
    (3, '2024-04-22', 110.50),
    (4, '2024-04-23', 55.20),
    (5, '2024-04-24', 70.80);


INSERT INTO Produtos (Nome, Descricao, Preco)
VALUES
    ('Camiseta', 'Camiseta básica de algodão', 29.99),
    ('Calça Jeans', 'Calça jeans skinny', 49.99),
    ('Tênis Esportivo', 'Tênis para corrida leve', 79.99),
    ('Relógio de Pulso', 'Relógio analógico de aço inoxidável', 99.99),
    ('Bolsa Feminina', 'Bolsa de couro sintético', 39.99),
    ('Boné', 'Boné com ajuste de tamanho', 19.99),
    ('Mochila', 'Mochila escolar resistente', 59.99),
    ('Perfume Masculino', 'Perfume amadeirado', 69.99),
    ('Colar de Prata', 'Colar com pingente de coração', 34.99),
    ('Óculos de Sol', 'Óculos de sol com proteção UV', 29.99),
    ('Sapato Social', 'Sapato de couro para ocasiões formais', 89.99),
    ('Cinto de Couro', 'Cinto masculino de couro genuíno', 24.99),
    ('Bolsa Térmica', 'Bolsa térmica para alimentos', 49.99),
    ('Fone de Ouvido Bluetooth', 'Fone de ouvido sem fio', 59.99),
    ('Câmera Digital', 'Câmera compacta de alta resolução', 199.99);


INSERT INTO PEDIDOS_PRODUTOS (ID_PEDIDO, ID_PRODUTO)
VALUES
    (1,1),
    (2,2),
    (3,3);

INSERT INTO CATEGORIAS (NOME)
VALUES
    ('ROUPAS'),
    ('ACESSORIOS'), 
    ('SAPATOS');

INSERT INTO PRODUTOS_CATEGORIAS (ID_PRODUTO, ID_CATEGORIA)
VALUES
    (1, 1),
    (4, 2), 
    (3, 3);


INSERT INTO FUNCIONARIOS (Nome, Sobrenome, Cargo)
VALUES
    ('João', 'Silva', 'Gerente'),
    ('Maria', 'Santos', 'Vendedor'),
    ('Pedro', 'Ribeiro', 'Atendente'),
    ('Ana', 'Gomes', 'Vendedor'),
    ('Carlos', 'Ferreira', 'Atendente');


INSERT INTO VENDAS (ID_PRODUTO, ID_CLIENTES, DATA_VENDA, QUANTIDADE)
VALUES 
    (1, 1, '2024-04-15', 2),
    (2, 2, '2024-04-18', 1);


UPDATE Produtos
SET Preco = 34.99
WHERE ID = 1;

UPDATE Funcionarios
SET Cargo = 'Vendedor'
WHERE Nome = 'João' AND Sobrenome = 'Silva';

DELETE FROM Clientes
WHERE ID = 5;

DELETE FROM PEDIDOS
WHERE ID_CLIENTES = 5;

DELETE FROM PEDIDOS_PRODUTOS
WHERE ID_PRODUTO = 1;

DELETE FROM PRODUTOS_CATEGORIAS
WHERE ID_PRODUTO = 1;

DELETE FROM VENDAS
WHERE ID_PRODUTO = 1;

DELETE FROM PRODUTOS
WHERE ID = 1;

DELETE FROM Funcionarios
WHERE Nome = 'João' AND Sobrenome = 'Silva';

ALTER TABLE PEDIDOS
ADD COLUMN status VARCHAR(20) DEFAULT 'Em andamento' NOT NULL;

SELECT * FROM PEDIDOS
WHERE status = 'Em andamento';


SELECT
    c.Nome AS NomeCliente,
    p.Data_Pedido,
    p.Total
FROM
    Pedidos p,
    Clientes c
WHERE
    p.ID_Clientes = c.ID
    AND p.Data_Pedido >= CURRENT_DATE - INTERVAL '30 days';


SELECT 
    ID_PRODUTO
FROM
    PRODUTOS_CATEGORIAS
WHERE
    ID_CATEGORIA = 3;




  
















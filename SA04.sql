-- Exercicio 1 
CREATE DATABASE DB_SA04_EX1;

CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Email VARCHAR(100)
);

ALTER TABLE Clientes
ADD CONSTRAINT Email UNIQUE (Email);

CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

ALTER TABLE Pedidos
ADD COLUMN Status VARCHAR(20) NOT NULL CHECK(Status in ('Em andamento', 'Finalizado', 'Cancelado'));

INSERT INTO Clientes (ID, Nome, Sobrenome, Email)
VALUES (1, 'João', 'Silva', 'joao.silva@example.com');

INSERT INTO Clientes (ID, Nome, Sobrenome, Email)
VALUES (2, 'Maria', 'Santos', 'maria.santos@example.com');

INSERT INTO Clientes (ID, Nome, Sobrenome, Email)
VALUES (3, 'Pedro', 'Almeida', 'pedro.almeida@example.com');

-- Inserir pedido 1 associado ao Cliente com ID 1
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status)
VALUES (1, 1, '2024-04-08', 50.00, 'Em andamento');

-- Inserir pedido 2 associado ao Cliente com ID 2
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status)
VALUES (2, 2, '2024-04-09', 75.00, 'Finalizado');

-- Inserir pedido 3 associado ao Cliente com ID 3
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status)
VALUES (3, 2, '2024-04-10', 120.00, 'Em andamento');

-- Inserir pedido 4 associado ao Cliente com ID 4
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status)
VALUES (4, 3, '2024-04-11', 90.00, 'Em andamento');

-- Inserir pedido 5 associado ao Cliente com ID 5
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status)
VALUES (5, 3, '2024-04-12', 60.00, 'Cancelado');

UPDATE Pedidos
SET Total = 65.00
WHERE ID = 1;

-- Excluir os pedidos do cliente específico na tabela "Pedidos"
DELETE FROM Pedidos
WHERE ID_Cliente = 1;

-- Excluir o cliente da tabela "Clientes"
DELETE FROM Clientes
WHERE ID = 1;

SELECT *
FROM Pedidos
WHERE Status = 'Em andamento';

SELECT c.Nome, p.Data_Pedido, p.Total
FROM Pedidos p
JOIN Clientes c ON p.ID_Cliente = c.ID
WHERE p.Data_Pedido >= CURRENT_DATE - INTERVAL '30 days';

-- Exercicio 2 
CREATE DATABASE DB_SA04_EX2;

CREATE TABLE Produtos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10, 2)
);

ALTER TABLE Produtos
ADD CONSTRAINT Preco_Positivo CHECK (Preco >= 0);

CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    Data DATE NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(50) NOT NULL
);


CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);


CREATE INDEX idx_nome_produto ON Produtos (Nome);

CREATE TABLE Categorias (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);

CREATE TABLE Produtos_Categorias (
    ID_Produto INT,
    ID_Categoria INT,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);

CREATE TABLE Funcionarios (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Sobrenome VARCHAR(255) NOT NULL,
    Cargo VARCHAR(255) NOT NULL
);

ALTER TABLE Funcionarios
ADD CONSTRAINT CHK_Cargo_Valido CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'));

INSERT INTO Produtos (ID, Nome, Descricao, Preco)
VALUES
    (1, 'Camiseta', 'Camiseta de algodão branca', 29.99),
    (2, 'Calça Jeans', 'Calça jeans azul', 49.99),
    (3, 'Tênis Esportivo', 'Tênis para corrida preto', 79.99),
    (4, 'Óculos de Sol', 'Óculos de sol estilo aviador', 39.99),
    (5, 'Mochila', 'Mochila para notebook preta', 59.99);


INSERT INTO Pedidos (ID, Data, Valor, Status)
VALUES
    (1, '2024-04-10', 100.00, 'Em processamento'),
    (2, '2024-04-11', 75.50, 'Entregue'),
    (3, '2024-04-12', 120.25, 'Em transporte'),
    (4, '2024-04-13', 55.80, 'Em processamento'),
    (5, '2024-04-14', 90.00, 'Aguardando pagamento');

-- Associar produtos aos pedidos na tabela de junção "Pedidos_Produtos"
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto)
VALUES
    (1, 1),  -- Associar Produto ID 1 ao Pedido ID 1
    (1, 2),  -- Associar Produto ID 2 ao Pedido ID 1
    (2, 3),  -- Associar Produto ID 3 ao Pedido ID 2
    (3, 4),  -- Associar Produto ID 4 ao Pedido ID 3
    (3, 5);  -- Associar Produto ID 5 ao Pedido ID 3

UPDATE Produtos
SET Preco = 34.99
WHERE ID = 1;

BEGIN TRANSACTION;

-- Excluir registros na tabela "Pedidos_Produtos" associados ao produto com ID igual a 1
DELETE FROM Pedidos_Produtos
WHERE ID_Produto = 1;

-- Excluir o produto da tabela "Produtos" com ID igual a 1
DELETE FROM Produtos
WHERE ID = 1;

COMMIT;

SELECT p.ID, p.Nome, p.Descricao, p.Preco
FROM Produtos p
JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto
JOIN Categorias c ON pc.ID_Categoria = c.ID
WHERE c.ID = 2;

INSERT INTO Funcionarios (ID, Nome, Sobrenome, Cargo)
VALUES
    (1, 'João', 'Silva', 'Gerente'),
    (2, 'Maria', 'Santos', 'Vendedor'),
    (3, 'Pedro', 'Costa', 'Atendente'),
    (4, 'Ana', 'Pereira', 'Vendedor'),
    (5, 'Carlos', 'Oliveira', 'Atendente');

SELECT Nome, Sobrenome, Cargo
FROM Funcionarios;

UPDATE Funcionarios
SET Cargo = 'Vendedor'
WHERE Nome = 'João' AND Sobrenome = 'Silva';

DELETE FROM Funcionarios
WHERE Nome = 'João' AND Sobrenome = 'Silva';

SELECT *
FROM Pedidos;

SELECT ID, Nome, Descricao, Preco
FROM Produtos
ORDER BY Preco DESC
LIMIT 5;

SELECT SUM(Valor) AS ValorTotal
FROM Pedidos;

UPDATE Pedidos
SET Status = 'Finalizado'
WHERE Data < '2024-04-15';

DELETE FROM Pedidos
WHERE Status = 'Finalizado'
AND Data < NOW() - INTERVAL '1 year';

SELECT ID, Status, Data
FROM Pedidos
ORDER BY Status, Data;

UPDATE Pedidos
SET Status = 'Atrasado'
WHERE Data < NOW() - INTERVAL '30 days';

SELECT c.Nome AS Categoria, SUM(p.Preco) AS Total_Vendas
FROM Produtos p
JOIN Pedidos_Produtos pp ON p.ID = pp.ID_Produto
JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto
JOIN Categorias c ON pc.ID_Categoria = c.ID
GROUP BY c.ID, c.Nome;

SELECT * 
FROM Produtos 
WHERE ID NOT IN (SELECT DISTINCT ID_Produto FROM Pedidos_Produtos);






























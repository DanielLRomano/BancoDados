-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

CREATE DATABASE EXEMPLO;

CREATE TABLE cliente (
id_cliente serial PRIMARY KEY,
cpf_cliente varchar(14) NOT NULL,
nome_cliente varchar(100),
celular_clientes varchar(15)
);

CREATE TABLE produto (
id_produto serial PRIMARY KEY,
valor_produto decimal(7,2) NOT NULL,
quantidade_produto int
);

CREATE TABLE compra (
id_pedido serial PRIMARY KEY,
data_compra_produto date,
id_produto INT,
id_cliente INT,
FOREIGN KEY(id_produto) REFERENCES produto (id_produto),
FOREIGN KEY(id_cliente) REFERENCES cliente (id_cliente)
);

SELECT * FROM CLIENTE, PRODUTO


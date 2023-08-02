CREATE DATABASE aplicacao;
USE aplicacao;

CREATE TABLE tb_pessoas(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome CHAR(20) NOT NULL,
email VARCHAR(256) NOT NULL,
senha CHAR(8) NOT NULL
);

CREATE TABLE tb_delegacao(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
pais CHAR(25) NOT NULL,
uniforme CHAR(20) NOT NULL #isso é como se fosse um arquivo de imagem
);

CREATE TABLE tb_competidores(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome CHAR(20) NOT NULL,
id_delegacao INT NOT NULL,
FOREIGN KEY (id_delegacao) REFERENCES tb_delegacao(id),
id_competicao INT NOT NULL,
FOREIGN KEY (id_competicao) REFERENCES tb_competicao(id)
);

CREATE TABLE tb_votos(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
quantidade_votos INT NOT NULL,
id_delegacao INT NOT NULL,
FOREIGN KEY (id_delegacao) REFERENCES tb_delegacao(id)
);

CREATE TABLE tb_equipe(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome CHAR(20) NOT NULL,
email VARCHAR(256) NOT NULL,
senha CHAR(8) NOT NULL
);

CREATE TABLE tb_alimentacao(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome CHAR(20) NOT NULL,
preco FLOAT NOT NULL,
descricao VARCHAR(100) NOT NULL
);

CREATE TABLE tb_pagamento(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
dt DATE NOT NULL,
hora CHAR(6) NOT NULL,
preco CHAR(6) NOT NULL,
id_alimento INT NOT NULL,
FOREIGN KEY (id_alimento) REFERENCES tb_alimentacao(id)
);

CREATE TABLE tb_pix(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
qr_code CHAR(7) NOT NULL, # aqui é como se fosse a imagem de um qr code
chave_pix CHAR(9)NOT NULL,
id_pagamento INT NOT NULL,
FOREIGN KEY (id_pagamento) REFERENCES tb_pagamento(id)

);

CREATE TABLE tb_cartao(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
dt_validade INT NOT NULL,
cod_seguranca INT NOT NULL,
nome_pessoa CHAR(25) NOT NULL,
bandeira CHAR(10) NOT NULL,
id_pagamento INT NOT NULL,
FOREIGN KEY (id_pagamento) REFERENCES tb_pagamento(id)
);


CREATE TABLE tb_ingresso(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
setor CHAR(15) NOT NULL,
meia_entrada FLOAT NOT NULL,
inteira FLOAT NOT NULL

);


CREATE TABLE tb_pagamento_ingresso(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
dt DATE NOT NULL,
hora CHAR(6) NOT NULL,
preco CHAR(6) NOT NULL,
id_ingresso INT NOT NULL,
FOREIGN KEY (id_ingresso) REFERENCES tb_ingresso(id)
);

CREATE TABLE tb_pix_ingresso(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
qr_code CHAR(7) NOT NULL, # aqui é como se fosse a imagem de um qr code
chave_pix CHAR(9)NOT NULL,
id_pagamento_ingresso INT NOT NULL,
FOREIGN KEY(id_pagamento_ingresso) REFERENCES tb_pagamento_ingresso(id)
);

CREATE TABLE tb_cartao_ingresso (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
dt_validade INT NOT NULL,
cod_seguranca INT NOT NULL,
nome_pessoa CHAR(25) NOT NULL,
bandeira CHAR(10) NOT NULL,
id_pagamento_ingresso INT NOT NULL,
FOREIGN KEY(id_pagamento_ingresso) REFERENCES tb_pagamento_ingresso(id)
);

CREATE TABLE tb_competicao(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
regulamentos VARCHAR(200),
dt DATE NOT NULL,
hora CHAR(6) NOT NULL,
local_competicao CHAR(25) NOT NULL
);

INSERT INTO tb_pessoas (nome, email, senha) VALUES("Jose da Silva", "JS@jose.com","12345678"),("mariana","maria@ana.com","@123456@"),("pedro","pedrinho@matador.com","#123456#"),("luiza","luh123@linda.com","luh123@@");
INSERT INTO tb_delegacao (pais, uniforme)VALUES("Brasil","uniforme_brasil"),("França","uniforme_franca"),("Jamaica","uniforme_jamaica"),("Alemanha","uniforme_alemanha");
INSERT INTO tb_equipe(nome,email, senha) VALUES ("wellinton", "Welli@12.com", "12325*"),("Thomas","thomas@43.com","23@6709"),("Ana","ana@banana.com","*9843210"),("luis","luis@vks.com","tr4523*");
INSERT INTO tb_votos(id_delegacao, quantidade_votos) VALUES (1,3),(2,0),(3,1),(4,0);
INSERT INTO tb_competicao(regulamentos, dt, hora, local_competicao) VALUES ("Não pode haver atrasos, sempre chegue meia hora antes dos jogos começarem. Nada de coisa emcima da hora","2023-08-01","09:30","Arena of valor, Austrália" );
INSERT INTO  tb_competidores(nome, id_delegacao, id_competicao) VALUES ("Bárbara", 1, 1),("Kenza Dali", 2, 1),("Rebecca Spencer", 3, 1),("Jule Brand", 4, 1);
INSERT INTO tb_alimentacao(nome, preco, descricao) VALUES ("Coxinha", 6 ,"coxinha de frango com catupiry"),("Coca-cola", 3,"Coca cola em lata"),("Bolo", 4 ,"Bolo de chocolate recheado"),("Água", 2 , "Sem gás");
INSERT INTO tb_pagamento(dt, hora, preco, id_alimento) VALUES ("2023-08-01", "09:30", 12, 1),("2023-08-01", "09:30", 12, 2),("2023-08-01", "09:30", 12, 3);
INSERT INTO tb_ingresso(setor, meia_entrada, inteira ) VALUES("setor A", 100 , 200),("setor B", 125 , 250),("setor C", 400 , 800);
INSERT INTO tb_pagamento_ingresso(dt, hora, preco, id_ingresso) VALUES("2023-08-01","09:50", 200, 1);
INSERT INTO tb_cartao(dt_validade, cod_seguranca,  nome_pessoa, bandeira, id_pagamento) VALUES (2024, 506,  "jose da silva", "masterCard", 1); # é a mesma pessoa comprando no mesmo cartão, so que em áreas diferentes
INSERT INTO tb_cartao_ingresso(dt_validade, cod_seguranca, nome_pessoa, bandeira, id_pagamento_ingresso) VALUES (2024, 506,  "jose da silva", "masterCard", 1);# aqui é para o ingresso, e logo acima para a alimentação
INSERT INTO tb_pix(qr_code, chave_pix, id_pagamento) VALUES("qr_code","chave@pix",2); 



SELECT * FROM tb_equipe; # a equipe de markenting cadastrada
SELECT * FROM tb_competicao; # esse select esta mostrando a competicao que esta sendo organizada
SELECT * FROM tb_competidores; # mostra competidores de uma determinada delegação
SELECT * FROM tb_pessoas; # pessoas que foram cadastradas para votar
SELECT nome, preco FROM tb_alimentacao; # mostra a opção de alimento para comprar e preço
SELECT nome_pessoa, bandeira, dt_validade FROM tb_cartao; # mostrando os dados do cartao de uma pessoa cadastrada na área de alimentação
SELECT nome_pessoa, bandeira, dt_validade FROM tb_cartao; # mostrando os dados do cartao de uma pessoa cadastrada na área dos ingressos
SELECT qr_code FROM tb_pix; # mostra a consulta ao qr_code do pix para a alimentação
SELECT * FROM tb_delegacao; # mostrando a delegacao 
SELECT * FROM tb_votos ORDER BY quantidade_votos DESC; # Esse select mostra o ranking dos votos



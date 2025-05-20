CREATE DATABASE desafio;

USE desafio;


CREATE TABLE cliente (
  idCliente INT AUTO_INCREMENT PRIMARY KEY,
  nomeCliente VARCHAR(100) NOT NULL
);


CREATE TABLE veiculo (
  idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
  placa INT NOT NULL,
  tipo ENUM('carro', 'moto') NOT NULL
);


CREATE TABLE vaga (
  idVaga INT AUTO_INCREMENT PRIMARY KEY,
  numeroVaga INT NOT NULL,
  tipoVaga ENUM('normal', 'deficiente', 'idoso', 'gestante') NOT NULL
);



CREATE TABLE cliente_veiculo (
  fkCliente INT NOT NULL,
  fkVeiculo INT NOT NULL,
  PRIMARY KEY (fkCliente, fkVeiculo),
  FOREIGN KEY (fkCliente) REFERENCES cliente(idCliente),
  FOREIGN KEY (fkVeiculo) REFERENCES veiculo(idVeiculo)
  
);

-- Criando Tabela cliente_vagas
CREATE TABLE  veiculo_vagas (
idVeiculo_vaga INT AUTO_INCREMENT PRIMARY KEY,
fkVeiculo INT(11),
fkVaga INT(11),
data_hora_entrada DATETIME NOT NULL,
data_hora_saida DATETIME NOT NULL,
FOREIGN KEY (fkVeiculo) REFERENCES veiculo(idVeiculo),
FOREIGN KEY (fkVaga) REFERENCES vaga(idVaga);

ALTER TABLE veiculo_vagas
MODIFY COLUMN data_hora_saida DATETIME;

-- Altere a tabela veiculo para modificar a coluna placa de INT para VARCHAR(8), pois as placas brasileiras -
-- seguem o padrão Mercosul que tem 8 caracteres (exemplo: ABC1D23). 

ALTER TABLE veiculo
MODIFY COLUMN placa VARCHAR(8);

--  Adicione a coluna email do tipo VARCHAR(150) na tabela cliente
ALTER TABLE cliente
ADD COLUMN email VARCHAR(150);

SELECT * FROM veiculo;

 -- Insira um novo cliente:
-- Nome: Eduarda Ferreira
-- email: eduarda@email.com E o respectivo veículo:
-- Tipo: moto
-- Placa: EFX9D55

INSERT INTO cliente (nomeCliente, email)
VALUES ('Eduarda Ferreira', 'eduarda@email.com');
INSERT INTO cliente (nomeCliente, email) VALUES ('Eduarda Ferreira', 'eduardaFerreira@empresa');
-- Buscar o id do cliente inserido (exemplo):
SELECT idCliente FROM cliente WHERE nomeCliente = 'Eduarda Ferreira' AND email = 'eduardaFerreira@empresa';

INSERT INTO veiculo (placa, tipo)
VALUES ('EFX9D55', 'MOTO');

INSERT INTO cliente_veiculo (fkCliente, fkVeiculo) VALUES (41, 59);


-- Questão 2 — Cadastrar entrada do veículo
-- Buscar idVeiculo pela placa
SELECT idVeiculo FROM veiculo WHERE placa = 'EFX9D55';
-- Suponha idVeiculo = 59
INSERT INTO veiculo_vagas (fkVeiculo, fkVaga, data_hora_entrada) 
VALUES (59, 5, '2025-05-19 18:00:00');

-- Questão 3 — Atualizar saída do veículo
-- Buscar idVeiculo pela placa
SELECT idVeiculo FROM veiculo WHERE placa = 'EFX9D55';
-- Suponha idVeiculo = 33
UPDATE veiculo_vagas
SET data_hora_saida = '2025-05-19 20:20:00'
WHERE fkVeiculo = 59 AND data_hora_saida IS NULL;

-- Questão 4 — Atualizar email para três clientes
select idCliente
from cliente
WHERE nomeCliente = 'Bruna Freitas'
   or nomeCliente = 'Igor Aragão'
   OR nomeCliente = 'Pietra Lima';
   
   
UPDATE cliente
SET email = 'empresa@empresa.com'
WHERE idCliente = 6
   OR idCliente = 13
   OR idCliente = 20;
   
-- Quantos veículos estão cadastrados no sistema?
SELECT COUNT(*) AS total_veiculos
FROM veiculo;

-- Quantos veículos já utilizaram cada tipo de vaga?
-- Consulta  veiculo_vaga
SELECT v.tipoVaga, COUNT(DISTINCT vv.fkVeiculo) as total_veiculos
FROM veiculo_vagas vv
JOIN vaga v ON vv.fkVaga = v.idVaga
GROUP BY v.tipoVaga;

-- Mostre em ordem alfabética os nomes e emails dos clientes que possuem motos.
SELECT c.nomeCliente, c.email
FROM cliente c
JOIN cliente_veiculo cv ON c.idCliente = cv.fkCliente
JOIN veiculo v ON fkVeiculo = v.idVeiculo
WHERE v.tipo = 'moto'
ORDER BY c.nomeCliente;

-- Considerando um valor fixo por tipo de veículo (moto: R$8, carro: R$15), calcule o valor total faturado com todos os estacionamentos.

-- Questão 5 (10 pts) — Quantos veículos de cada tipo estacionaram na vaga 8?
SELECT v.tipo, COUNT(*) AS total_veiculos
FROM veiculo_vagas vv
JOIN vaga va ON vv.fkVaga = va.idVaga
JOIN veiculo V on 
WHERE va.numVaga = 8
ORDER BY v.tipoVaga;



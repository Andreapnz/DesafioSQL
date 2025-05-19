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
FOREIGN KEY (fkVaga) REFERENCES vaga(idVaga));

-- Altere a tabela veiculo para modificar a coluna placa de INT para VARCHAR(8), pois as placas brasileiras -
-- seguem o padrão Mercosul que tem 8 caracteres (exemplo: ABC1D23). 

ALTER TABLE veiculo
MODIFY COLUMN placa VARCHAR(8);

--  Adicione a coluna email do tipo VARCHAR(150) na tabela cliente
ALTER TABLE cliente
ADD COLUMN email VARCHAR(150);

SELECT * FROM veiculo_vagas;

 -- Insira um novo cliente:
-- Nome: Eduarda Ferreira
-- email: eduarda@email.com E o respectivo veículo:
-- Tipo: moto
-- Placa: EFX9D55

INSERT INTO cliente (nomeCliente, email)
VALUES ('Eduarda Ferreira', 'eduarda@email.com');

INSERT INTO veiculo (placa, tipo)
VALUES ('EFX9D55', 'MOTO');

-- Cadastre a entrada do veículo de placa EFX9D55 no estacionamento hoje às 18h na vaga 5

INSERT INTO veiculo_vagas (fkVaga, data_hora_entrada)
VALUES (SELECT idVaga FROM placa WHERE 


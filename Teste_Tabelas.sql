CREATE DATABASE IF NOT EXISTS centro_formacao;

USE centro_formacao;

CREATE TABLE Turma (
	ID_Turma INT AUTO_INCREMENT PRIMARY KEY,
    Designacao_Turma INT NOT NULL,
    Data_Criacao DATE NOT NULL
);

CREATE TABLE Formando (
	ID_Formando INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    N_Identificacao INT NOT NULL,
    Data_Nascimento DATE NOT NULL,
    
    ID_Turma INT NOT NULL,
	FOREIGN KEY (ID_Turma)
	REFERENCES Turma(ID_Turma)
);

CREATE TABLE Curso (
	ID_Curso INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Carga_Horaria INt NOT NULL,
    
    ID_Turma INT NOT NULL,
	FOREIGN KEY (ID_Turma)
	REFERENCES Turma(ID_Turma)
);





CREATE DATABASE IF NOT EXISTS gestao_torneios;

USE gestao_torneios;

-- Tabela Equipas

CREATE TABLE Equipas (
	ID_Equipa INT AUTO_INCREMENT PRIMARY KEY,
	Nome_Equipa VARCHAR(100) NOT NULL,
	Data_Criacao DATE NOT NULL
);
-- Tabela Jogadores

CREATE TABLE Jogadores (
	ID_Jogador INT AUTO_INCREMENT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	Nickname VARCHAR(50) NOT NULL,
	Data_Nascimento DATE NOT NULL,
    
	ID_Equipa INT NOT NULL,
	FOREIGN KEY (ID_Equipa)
	REFERENCES Equipas(ID_Equipa)
);
-- Tabela Torneios

CREATE TABLE Torneios (
	ID_Torneio INT AUTO_INCREMENT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	Data_Inicio DATE NOT NULL,
    
	Premio_Monetario DECIMAL(10,2) NOT NULL,
	CHECK (Premio_Monetario >= 0)
);
-- Tabela Participacoes

CREATE TABLE Participacoes (
	ID_Equipa INT NOT NULL,
	ID_Torneio INT NOT NULL,

	PRIMARY KEY (ID_Equipa, ID_Torneio),
	FOREIGN KEY (ID_Equipa)
	REFERENCES Equipas(ID_Equipa),
	FOREIGN KEY (ID_Torneio)
	REFERENCES Torneios(ID_Torneio)
);

INSERT INTO Equipas (Nome_Equipa, Data_Criacao) VALUES 
("Batatas FC","20081212"),
("Cebolas FC","20090804");

INSERT INTO Jogadores (Nome, Nickname, Data_Nascimento, ID_Equipa) VALUES 
("Martim Oliveira","Ermo","20081004", 1),
("Tiago Fonseca","Tiagotas","20080806", 2);

INSERT INTO Torneios (Nome, Data_Inicio, Premio_Monetario) VALUES 
("Corrida a pés juntos","20250910",200),
("Levantamento de peso","20240322",150);

INSERT INTO Participacoes (ID_Equipa, ID_Torneio) VALUES 
(1,1), (1,2), (2,1), (2,2);



SELECT * FROM Jogadores ORDER BY Nome;

SELECT Jogadores.Nome,Equipas.ID_Equipa FROM Jogadores JOIN Equipas ON Jogadores.ID_Equipa = Equipas.ID_Equipa;

SELECT * FROM Participacoes WHERE ID_Torneio = 1;

SELECT COUNT(ID_Equipa) FROM Jogadores WHERE ID_Equipa = 1 HAVING COUNT(ID_Equipa) > 1;

SELECT Equipas.Nome_Equipa, COUNT(Jogadores.ID_Equipa) AS NJogadores FROM Equipas LEFT JOIN Jogadores ON Jogadores.ID_Equipa = Equipas.ID_Equipa GROUP BY Equipas.ID_Equipa ORDER BY COUNT(Jogadores.ID_Equipa) DESC;

SELECT Torneios.Nome, Torneios.Premio_Monetario, COUNT(Participacoes.ID_Equipa) AS NEquipas FROM Torneios JOIN Participacoes ON Torneios.ID_Torneio = Participacoes.ID_Torneio GROUP BY Torneios.ID_Torneio HAVING COUNT(Participacoes.ID_Equipa) > 1;
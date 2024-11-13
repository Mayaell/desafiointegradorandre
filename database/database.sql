-- Criação do banco de dados
CREATE DATABASE memorial_faculdade;

-- Seleciona o banco de dados
USE memorial_faculdade;

-- Tabela para armazenar os dados dos alunos
CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT NOT NULL,
    quantidade_trabalhos INT NOT NULL
);

-- Tabela para armazenar os dados dos professores
CREATE TABLE professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_trabalhos INT NOT NULL
);

-- Criar tabela de trabalhos
CREATE TABLE trabalhos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  aluno_id INT,
  professor_id INT,
  FOREIGN KEY (aluno_id) REFERENCES alunos(id),
  FOREIGN KEY (professor_id) REFERENCES professores(id)
);


ALTER TABLE alunos
ADD COLUMN curso VARCHAR(255);

ALTER TABLE professores
ADD COLUMN curso VARCHAR(255);
SELECT * FROM alunos;
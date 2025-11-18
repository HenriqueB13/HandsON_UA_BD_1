-- arquivo: sistema_academico.sql
-- Charset e collation para suportar acentuação
CREATE DATABASE IF NOT EXISTS sistema_academico
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE sistema_academico;

-- ---------------------------------------------------------
-- Tabela: alunos
-- ---------------------------------------------------------
DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS cursos;

CREATE TABLE alunos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero_matricula VARCHAR(20) NOT NULL UNIQUE,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  data_nascimento DATE NOT NULL,
  data_ingresso DATE NOT NULL,
  status ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Tabela: cursos
-- ---------------------------------------------------------
CREATE TABLE cursos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL,
  descricao TEXT,
  creditos TINYINT NOT NULL DEFAULT 3,
  capacidade SMALLINT NOT NULL DEFAULT 100,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Tabela: matriculas (relaciona alunos <-> cursos)
-- ---------------------------------------------------------
CREATE TABLE matriculas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aluno_id INT NOT NULL,
  curso_id INT NOT NULL,
  data_matricula DATE NOT NULL,
  status ENUM('matriculado','cancelado','concluido') NOT NULL DEFAULT 'matriculado',
  nota DECIMAL(4,2) NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_matriculas_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_matriculas_curso FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT uq_aluno_curso UNIQUE (aluno_id, curso_id)
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Inserir 20 alunos
-- ---------------------------------------------------------
INSERT INTO alunos (numero_matricula, nome, email, data_nascimento, data_ingresso, status) VALUES
('20230001','Ana Silva','ana.silva@example.com','2001-05-14','2023-03-01','ativo'),
('20230002','Bruno Oliveira','bruno.oliveira@example.com','2000-11-20','2023-03-01','ativo'),
('20230003','Carla Pereira','carla.pereira@example.com','1999-07-05','2022-08-15','ativo'),
('20230004','Diego Costa','diego.costa@example.com','2002-02-28','2024-02-10','ativo'),
('20230005','Érica Santos','erica.santos@example.com','1998-09-09','2021-01-20','ativo'),
('20230006','Fábio Rodrigues','fabio.rodrigues@example.com','2003-12-12','2024-09-01','ativo'),
('20230007','Gabriela Lima','gabriela.lima@example.com','2001-03-30','2022-03-05','ativo'),
('20230008','Henrique Alves','henrique.alves@example.com','1997-10-02','2020-02-01','inativo'),
('20230009','Isabela Moreira','isabela.moreira@example.com','2002-06-17','2023-09-01','ativo'),
('20230010','João Martins','joao.martins@example.com','1999-01-22','2022-09-01','ativo'),
('20230011','Kátia Fernandes','katia.fernandes@example.com','2000-04-04','2023-03-01','ativo'),
('20230012','Lucas Silva','lucas.silva@example.com','2004-08-21','2024-02-15','ativo'),
('20230013','Mariana Rocha','mariana.rocha@example.com','1998-12-02','2021-09-01','ativo'),
('20230014','Nicolas Freitas','nicolas.freitas@example.com','2001-11-11','2022-01-10','ativo'),
('20230015','Olivia Castro','olivia.castro@example.com','2003-05-25','2024-03-01','ativo'),
('20230016','Paulo Gomes','paulo.gomes@example.com','1996-07-19','2019-08-01','inativo'),
('20230017','Quésia Pinto','quesia.pinto@example.com','2002-09-30','2023-03-01','ativo'),
('20230018','Rafael Duarte','rafael.duarte@example.com','1999-02-14','2020-03-01','ativo'),
('20230019','Sofia Nunes','sofia.nunes@example.com','2004-01-03','2024-02-01','ativo'),
('20230020','Tiago Barros','tiago.barros@example.com','2000-06-06','2022-09-15','ativo');

-- ---------------------------------------------------------
-- Inserir 20 cursos
-- ---------------------------------------------------------
INSERT INTO cursos (codigo, nome, descricao, creditos, capacidade) VALUES
('MAT101','Matemática Básica','Fundamentos de álgebra e aritmética',4,60),
('MAT201','Cálculo I','Derivadas e integrais básicas',4,50),
('FIS101','Física Geral','Cinemática, dinâmica e termodinâmica',4,45),
('BIO101','Biologia Geral','Conceitos fundamentais de biologia',3,40),
('QUI101','Química Geral','Estrutura atômica e ligações químicas',3,40),
('PROG101','Introdução à Programação','Lógica de programação e algoritmos',4,80),
('BD101','Banco de Dados','Modelagem relacional e SQL',4,50),
('ENG101','Inglês I','Inglês instrumental e leitura',2,120),
('HIS101','História Geral','História antiga e moderna',3,60),
('ECO101','Economia Básica','Princípios de economia',3,70),
('MAT301','Álgebra Linear','Vetores, matrizes e sistemas lineares',4,45),
('EST101','Estatística','Probabilidade e estatística descritiva',4,55),
('SIS101','Sistemas de Informação','Introdução a sistemas e requisitos',3,60),
('WEB101','Desenvolvimento Web','HTML, CSS, JavaScript básicos',3,80),
('RED101','Redes de Computadores','Camadas de rede e protocolos',4,50),
('IA101','Introdução à IA','Conceitos básicos e aplicações de IA',3,40),
('SE101','Engenharia de Software','Processos e metodologias',4,50),
('UX101','Design de UX','Princípios de interface e usabilidade',2,40),
('EMP101','Empreendedorismo','Noções de criação de startups',2,80),
('PROJ101','Gestão de Projetos','Planejamento e controle de projetos',3,60);

-- ---------------------------------------------------------
-- Inserir 20 matrículas (cada uma refere a aluno_id e curso_id válidos)
-- ---------------------------------------------------------
-- Vamos distribuir matrículas entre os 20 alunos e cursos.
INSERT INTO matriculas (aluno_id, curso_id, data_matricula, status, nota) VALUES
(1, 6, '2024-03-01','matriculado', NULL),
(1, 7, '2024-03-02','matriculado', NULL),
(2, 2, '2023-03-05','concluido', 8.75),
(2, 6, '2023-08-10','concluido', 9.10),
(3, 1, '2022-08-20','concluido', 7.50),
(4, 3, '2024-02-12','matriculado', NULL),
(5, 11, '2021-02-01','concluido', 8.00),
(6, 6, '2024-09-01','matriculado', NULL),
(7, 12, '2022-03-10','concluido', 7.80),
(8, 9, '2020-02-05','concluido', 6.90),
(9, 14, '2023-09-03','matriculado', NULL),
(10, 7, '2022-09-05','concluido', 8.40),
(11, 6, '2023-03-02','concluido', 7.20),
(12, 6, '2024-02-20','matriculado', NULL),
(13, 2, '2021-09-10','concluido', 9.00),
(14, 1, '2022-01-12','concluido', 6.50),
(15, 20, '2024-03-02','matriculado', NULL),
(16, 10, '2019-08-05','inativo', NULL),
(17, 19, '2023-03-05','matriculado', NULL),
(18, 4, '2020-03-02','concluido', 7.00);

-- Observação: se quiser mais matrículas por aluno, basta inserir novas linhas respeitando o UNIQUE (aluno_id, curso_id)

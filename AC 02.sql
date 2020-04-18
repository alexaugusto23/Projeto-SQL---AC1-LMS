CREATE TABLE TB_SUBCATEGORIA
(
ID_SUBCATEGORIA TINYINT PRIMARY KEY IDENTITY,
NM_SUBCATEGORIA VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE TB_IDIOMA
(
ID_IDIOMA TINYINT PRIMARY KEY,
NM_IDIOMA VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE TB_LIVRO
(
ISBN INT PRIMARY KEY,
NM_TITULO VARCHAR(100),
NM_AUTOR VARCHAR(100),
VL_LIVRO DECIMAL (10,2),
QT_PAGINAS SMALLINT,
PESO_GRAMAS SMALLINT,
NM_EDITORA VARCHAR(50),
NM_CATEGORIA VARCHAR(50),
ID_SUBCATEGORIA TINYINT,
ID_IDIOMA TINYINT,
CONSTRAINT FK_LIVRO_SUBCATEGORIA FOREIGN KEY (ID_SUBCATEGORIA) REFERENCES TB_SUBCATEGORIA(ID_SUBCATEGORIA),
CONSTRAINT FK_LIVRO_IDIOMA FOREIGN KEY (ID_IDIOMA) REFERENCES TB_IDIOMA(ID_IDIOMA)
);

-----------------------------

SELECT * FROM TB_SUBCATEGORIA ORDER BY ID_SUBCATEGORIA ASC;
SELECT * FROM TB_IDIOMA ORDER BY ID_IDIOMA ASC;
SELECT * FROM TB_LIVRO ORDER BY ISBN ASC;

--DROP TABLE TB_SUBCATEGORIA;
--DROP TABLE TB_IDIOMA;
--DROP TABLE TB_LIVRO;

-----------------------------

INSERT INTO TB_SUBCATEGORIA
(NM_SUBCATEGORIA)
VALUES
('Finanças'),
('Finanças Pessoais'),
('Gestão e Liderança'),
('Gráficos da Web'),
('Programação'),
('Futebol'),
('Doenças'),
('Ciências Sociais'),
('Arquitetura');


INSERT INTO TB_IDIOMA
(ID_IDIOMA,NM_IDIOMA)
VALUES
(1,'Português'),
(2,'Inglês'),
(3,'Espanhol'),
(4,'Alemão'),
(5,'Italiano'),
(6,'Japonês'),
(7,'Russo'),
(8,'Francês'),
(9,'Árabe');

INSERT INTO TB_LIVRO
(ISBN,
NM_TITULO ,
NM_AUTOR,
VL_LIVRO,
QT_PAGINAS,
PESO_GRAMAS,
NM_EDITORA,
NM_CATEGORIA,
ID_SUBCATEGORIA,
ID_IDIOMA)
VALUES
(857542239,'Os segredos da mente milionária','T. Harv Eker',27.61,176,204,'Sextante','Administração, Negócios e Economia',3,1),
(111900225,'Storytelling with Data','Cole Nussbaumer Knaflic',147.66,288,658,'John Wiley & Sons','Computação, Informática e Mídias Digitais',4,2),
(859508327,'Do Mil ao Milhão. Sem Cortar o Cafezinho.','Thiago Nigro',21.9,192,349,'HarperCollins','Administração, Negócios e Economia',2,1),
(321348109,'The Brand Gap: Revised Edition','Marty Neumeier, Neumeier',111.76,208,295,'New Riders Publishing','Computação, Informática e Mídias Digitais',NULL,2),
(850111652,'Factfulness: O hábito libertador de só ter opiniões baseadas em fat','Hsans Rosling, Ola Rosling',44.92,360,499,'Record','Política, Filosofia e Ciências Sociais',8,1); 

UPDATE TB_LIVRO
SET VL_LIVRO = VL_LIVRO + 10.00
WHERE ISBN = 859508327

BEGIN TRANSACTION
DELETE TB_LIVRO WHERE QT_PAGINAS IN (360,176)
COMMIT
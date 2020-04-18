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
('Finan�as'),
('Finan�as Pessoais'),
('Gest�o e Lideran�a'),
('Gr�ficos da Web'),
('Programa��o'),
('Futebol'),
('Doen�as'),
('Ci�ncias Sociais'),
('Arquitetura');


INSERT INTO TB_IDIOMA
(ID_IDIOMA,NM_IDIOMA)
VALUES
(1,'Portugu�s'),
(2,'Ingl�s'),
(3,'Espanhol'),
(4,'Alem�o'),
(5,'Italiano'),
(6,'Japon�s'),
(7,'Russo'),
(8,'Franc�s'),
(9,'�rabe');

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
(857542239,'Os segredos da mente milion�ria','T. Harv Eker',27.61,176,204,'Sextante','Administra��o, Neg�cios e Economia',3,1),
(111900225,'Storytelling with Data','Cole Nussbaumer Knaflic',147.66,288,658,'John Wiley & Sons','Computa��o, Inform�tica e M�dias Digitais',4,2),
(859508327,'Do Mil ao Milh�o. Sem Cortar o Cafezinho.','Thiago Nigro',21.9,192,349,'HarperCollins','Administra��o, Neg�cios e Economia',2,1),
(321348109,'The Brand Gap: Revised Edition','Marty Neumeier, Neumeier',111.76,208,295,'New Riders Publishing','Computa��o, Inform�tica e M�dias Digitais',NULL,2),
(850111652,'Factfulness: O h�bito libertador de s� ter opini�es baseadas em fat','Hsans Rosling, Ola Rosling',44.92,360,499,'Record','Pol�tica, Filosofia e Ci�ncias Sociais',8,1); 

UPDATE TB_LIVRO
SET VL_LIVRO = VL_LIVRO + 10.00
WHERE ISBN = 859508327

BEGIN TRANSACTION
DELETE TB_LIVRO WHERE QT_PAGINAS IN (360,176)
COMMIT
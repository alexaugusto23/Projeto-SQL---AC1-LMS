 
-- Equipe
-- Alexsandro Augusto Ignácio        RA 1901705
-- Priscila Cardoso Vieira de Melo   RA 1901864
-- Adriel Vicente                    RA 1901842 
-- Micaella Leal                     RA 1902427

create database Atividade1;

---------------------CRIAÇÃO DE TABELAS-------------------------
--Criando Table usuario
create table Usuario(
	id_usuario int identity primary key,
	login_usuario varchar (30) not null,
	senha_usuario char (8) not null ,
	dt_expiracao date);

--Criando Table Coordenador
Create table Coordenador(
	id_coodenador int identity primary key,
	id_usuario int,
	nome_coordenador varchar(30) not null,
	email_coordenador varchar(30),
	celular_coordenador char(9));
--Criando Table Aluno
create table Aluno(
	id_aluno int identity primary key,
	id_usuario int,
	nome_aluno varchar(30)not null,
	email_aluno varchar(30),
	celular_aluno char(9),
	ra char(9),
	foto varchar(50));
--Criando Table Professor
create table Professor(
	id_Professor int identity primary key,
	id_Usuario int,
	email_professor varchar(50),
	celular_professor char(9),
	apelido varchar(15) not null);
--Criando table disciplina
create table Disciplina(
	id_Disciplina int identity primary key,
	nome_Disciplina varchar(30) not null,
	data_disciplina datetime,
	status_disciplina char(9),
	planodeensino varchar(50),
	cargahoraria int,
	competencias varchar(30),
	habilidades varchar(30),
	ementa varchar(100),
	conteudopromagatico varchar(100),
	bibliografiabasica varchar(50),
	bibliografiacomplementar varchar(50),
	percentualpratico numeric(4,2),
	PercentualTeorico numeric(4,2),
	id_coordenador int );
--Criando table Disciplina Ofertada
create table DisciplinaOfertada(
	id_Disciplina_Ofertada int identity primary key,
	id_coordenador int,
	dtiniciomatricula datetime,
	dffimmatricula datetime,
	id_discipina int,
	id_curso int,
	ano int,
	semestre int,
	turma char(2),
	id_professor int,
	metodologia varchar(50),
	recursos varchar(30),
	criterioavaliacao varchar(30),
	planodealulas varchar(50));
-- Criando Table Curso
create table curso (
	id_curso int identity (1,1) primary key ,
	nome_curso varchar(60));
--Criando Table SolicitacaoMatricula
create table SolicitacaoMatricula(
	id_SolicitacaoMatricula int identity (1,1) primary key,
	idaluno int,
	idDisciplinaOfertada int,
	DtSolicitacao date,
	idcoordenador int,
	s_status varchar(20);
--Criando Table Atividade
create table Atividade(
	id_Atividade int identity (1,1) primary key not null,
	titulo_atividade varchar(20),
	descricao varchar(20),
	conteudo varchar(50),
	tipo varchar(20),
	extras varchar(20),
	id_professor int);
--Criando Table Atividade Vinculada
create table AtividadeVinculada(
	id_AtividadeVinculada int identity (1,1) primary key not null,		
	idAtividade int,
    idProfessor int,
	idDisciplinaOfertada int,
	Rotulo varchar (20),
	status varchar (20),
	DtinicioRespostas date,
	DtFImRespostas date);
--Criando Table Entrega
create table Entrega(
	id_Entrega int identity (1,1) primary key not null,		
	id_aluno int,
    idAtividadeVinculada int,
	titulo_Entrega varchar(20),
	resposta_entrega varchar (20),
	dtentrega date, 
	tbe_status varchar (20),
	idProfessor int,
	nota int,
	dtavaliacao date,
	obs varchar (30));		
--Criando Table Mensagem
create table Mensagem(
	id_mensagem int identity (1,1) primary key not null,		
	id_aluno_msg int,
	idProfessor_msg int,
	assunto varchar (20),
	referencia varchar (20),
	conteudo varchar (20),
	status_msg varchar (20),
	dtenvio date,
	dtresposta date,
	resposta_mensagem varchar (20));	

----------------------CRIANDO CONSTRAINT-----------------------------
--Criando constraint table usuario
alter table usuario add
	constraint uq_login_usuario unique(login_usuario),
	constraint df_data_expiracao default('1900/01/01') for dt_expiracao;

--Criando constraint table coordenador
alter table coordenador add
	constraint fk_id_usuario foreign key(id_usuario) references Usuario (id_usuario),
	constraint uq_email_coordenador unique (email_coordenador),
	constraint uq_celular unique(celular_coordenador);

--Criando constraint table aluno
alter table aluno add
	constraint fk_id_usuario foreign key(id_usuario) references usuario(id_usuario),
	constraint uq_email_aluno unique(email_aluno),
	constraint uq_celular_aluno unique(celular_aluno);

--Criando constraint table professor
alter table professor add
	constraint fk_id_usuario foreign key(id_usuario) references usuario(id_usuario),
	constraint uq_email_professor unique(email_professor),
	constraint uq_celular_professor unique(celular_professor);

--Criando constraint table disciplina
alter table disciplina add
	constraint uq_nome_disciplina unique(nome_disciplina),
	constraint df_data_disciplina default (getdate())for data_disciplina,
	constraint ck_status_disciplina check (status='Aberta' or status='Fechada'),
	constraint df_status_disciplina default('Aberta') for status_disciplina,
	constraint ck_carga_horaria_disciplina check(cargahoraria='40' or cargahoraria='80'),
	constraint ck_percentual_pratico_disciplina check(percentualpratico='00' or percentualpratico='100'),
	constraint ck_percentual_teorico_disciplina check(percentualteorico='00' or percentualteorico='100'),
	constraint fk_id_coordenador_disciplina foreign key(id_coordenador) references coordenador(id_coordenador);

--Criando constraint table Disciplina Ofertada
alter table DisciplinaOfertada add
    constraint fk_id_coordenador foreign key(id_coordenador) references usuario(id_usuario), 
    constraint fk_id_discipina foreign key(id_discipina) references usuario(id_usuario),
    constraint fk_id_curso foreign key(id_curso) references usuario(id_usuario),
    constraint ck_ano check (ano= 1990 or ano= 2100),
    constraint ck_semestre check (semestre= 1 or semestre= 2),
    constraint ck_turma check if turma = 'a'or'A','b'or'B','c'or'C','d'or'D','e'or'E','f'or'F','g'or'G','h'or'H','i'or'I','j'or'J','l'or'L','m'or'M','n'or'N','o'or'O','p'or'P','q'or'Q','r'or'R','s'or'S','t'or'T','u'or'U','v'or'V','x'or'X','z'or'Z','k'or'K','w'or'W','y'or'Y',
    constraint fk_id_professor foreign key(id_professor) references usuario(id_usuario);

--Criando constraint table Curso
alter table curso add
    constraint uq_nome_curso unique(nome_curso);

--Criando constraint table Solicitacao Matricula
alter table curso add
    constraint fk_idaluno foreign key(idaluno) references usuario(id_usuario),
    constraint fk_idDisciplinaOfertada foreign key(idDisciplinaOfertada) references usuario(id_usuario),
    constraint df_DtSolicitacao default (getdate())for DtSolicitacao,
    constraint fk_idcoordenador foreign key(idcoordenador) references usuario(id_usuario),
    constraint df_s_status default ('Solicitada') for s_status,
    constraint ck_s_status check (status='Solicitada' or status='Aprovada'), ;

--Criando constraint table Atividade
alter table Atividade add
    constraint uq_titulo_atividade unique(titulo_atividade),
    constraint ck_tipo check (status='Aberta' or status='Teste'),
    constraint fk_id_professor foreign key(id_professor) references usuario(id_usuario);

--Criando constraint table Atividade Vinculada
alter table AtividadeVinculada add
    constraint fk_idAtividade foreign key(idAtividade) references usuario(id_usuario),
    constraint fk_idProfessor foreign key(idProfessor) references usuario(id_usuario),
    constraint fk_idDisciplinaOfertada foreign key(idDisciplinaOfertada) references usuario(id_usuario);


--Criando constraint table Entrega
alter table Entrega add
    constraint fk_id_aluno foreign key(id_aluno) references usuario(id_usuario),
    constraint fk_idAtividadeVinculada foreign key(idAtividadeVinculada) references usuario(id_usuario),    
    constraint df_dtentrega default (getdate())for dtentrega,
    constraint df_tbe_status default ('Entregue') for tbe_status,
    constraint ck_tbe_status check (status='Entregue' or status='Corrigido'),
    constraint fk_idProfessor foreign key(idProfessor) references usuario(id_usuario),
    constraint ck_nota check ((nota >= 0.00) and nota (<=10.00));
 
--Criando constraint table Mensagem
alter table Mensagem add
    constraint fk_id_aluno_msg foreign key(id_aluno_msg) references usuario(id_usuario),
    constraint fk_idProfessor_ms foreign key(idProfessor_ms) references usuario(id_usuario),
    constraint df_status_msg default ('Lido') for status_msg,
    constraint ck_status_msg check (status='Enviado' or status='Lido' or status'Respondido'),
    constraint df_dtresposta default (getdate())for dtresposta;






    

    



    




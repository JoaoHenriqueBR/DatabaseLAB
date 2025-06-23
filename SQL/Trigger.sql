USE DbFilme;
GO

-- Criar tabela auditoria
create table auditoria(
	idAuditoria int not null primary key identity(1,1),
	usuario varchar(20) not null,
	acao varchar(20) not null,
	data datetime not null,
	tabela varchar(15) not null,
	codigo int not null
);
GO

-- Criar Trigger AuditoriaViewInsert
create trigger tr_AuditoriaViewInsert on review for insert as
insert into auditoria(usuario, acao, data, tabela, codigo)
select USER_NAME(), 'cadastrou', GETDATE(), 'dbo.review', review_id from inserted
GO

-- Inserir um registro na tabela review
INSERT INTO review (movie_id, quote, score, publication_date, author, publication_name, review_type)
VALUES (2000550083, 'Excelente filme, roteiro envolvente e atuações impecáveis.', 9, '2024-06-01', 'João Silva', 'CineNews', 'Crítica Positiva');
GO

-- Visualizar registros da tabela auditoria
SELECT * FROM auditoria;
GO
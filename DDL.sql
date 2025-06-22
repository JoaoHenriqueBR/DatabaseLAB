-- Deleta database sem dá erro de timeout
/*
ALTER DATABASE DbFilme
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE DbFilme;
*/

-- CRIA DATABASE
/*
CREATE DATABASE DbFilme;
GO 

USE DbFilme;
GO
*/

/* Comando para mostrar tabelas existentes
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;
GO
*/

/* Comando para deletar todos os registros de uma tabela
DELETE FROM movies;
GO
*/

/*
SELECT * FROM genres
ORDER BY genres_id;
GO 
*/

-- DDL
CREATE TABLE genres (
    genres_id INT PRIMARY KEY IDENTITY(1,1),
    genre_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE movies (
    movie_id BIGINT PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    release_date DATE,
    rating NVARCHAR(20),
    description NVARCHAR(MAX),
    duration INT,
    tagline NVARCHAR(MAX),
    metascore INT,
    metascore_count INT,
    metascore_sentiment VARCHAR(100),
    userscore INT,
    userscore_count INT,
    userscore_sentiment VARCHAR(100),
    production_companies NVARCHAR(MAX),
    director VARCHAR(500),
    writer VARCHAR(500),
    top_cast NVARCHAR(MAX)
);

CREATE TABLE movie_genres (
    movie_id BIGINT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genres_id)
);

CREATE TABLE review (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    movie_id BIGINT,
    quote VARCHAR(5000),
    score INT,
    publication_date DATE,
    author VARCHAR(500),
    publication_name VARCHAR(500),
    review_type VARCHAR(500),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);
GO

-- Mostrando os registros de cada tabela
SELECT * FROM genres;
GO

SELECT * FROM movies;
GO

SELECT * FROM movie_genres;
GO

SELECT * FROM review;
GO

-- Deletando os registros de todas as tabelas
DELETE FROM genres;
GO

DELETE FROM movies;
GO

DELETE FROM movie_genres;
GO

DELETE FROM review;
GO

-- Procedure para descobrir filmes por gênero
CREATE PROCEDURE sp_MostraFilmePorGenero @genre_name NVARCHAR(100) AS
BEGIN
    SELECT movies.movie_id AS 'ID do Filme',
           movies.title AS 'Título',
           movies.release_date AS 'Data de Lançamento',
           genres.genre_name AS 'Gênero',
           movies.rating AS 'Classificação',
           movies.description AS 'Descrição',
           movies.duration AS 'Duração (minutos)',
           movies.tagline AS 'Tagline',
           movies.metascore AS 'Metascore',
           movies.metascore_count AS 'Contagem de Metascore',
           movies.metascore_sentiment AS 'Sentimento do Metascore',
           movies.userscore AS 'Userscore',
           movies.userscore_count AS 'Contagem de Userscore',
           movies.userscore_sentiment AS 'Sentimento do Userscore',
           movies.production_companies AS 'Empresas de Produção',
           movies.director AS 'Diretor',
           movies.writer AS 'Roteirista',
           movies.top_cast AS 'Elenco Principal'
    FROM movies
    INNER JOIN movie_genres ON movies.movie_id = movie_genres.movie_id
    INNER JOIN genres ON movie_genres.genre_id = genres.genres_id
    WHERE genres.genre_name = @genre_name
    ORDER BY movies.movie_id;
END;
GO

/*
DROP PROCEDURE sp_MostraFilmePorGenero;
GO
*/

EXEC sp_MostraFilmePorGenero 'Drama';
GO

-- Procedure para mostrar as reviews de um filme
CREATE PROCEDURE sp_MostraReviewsPorFilme @movie_id BIGINT AS
BEGIN
    SELECT movies.movie_id AS 'ID do Filme',
           movies.title AS 'Título',
           review.quote AS 'Citação da Resenha',
           review.score AS 'Pontuação da Resenha',
           review.publication_date AS 'Data de Publicação',
           review.author AS 'Autor da Resenha',
           review.publication_name AS 'Nome da Publicação',
           review.review_type AS 'Tipo de Resenha'
    FROM movies
    INNER JOIN review ON movies.movie_id = review.movie_id
    WHERE movies.movie_id = @movie_id
    ORDER BY review.publication_date DESC;
END;
GO
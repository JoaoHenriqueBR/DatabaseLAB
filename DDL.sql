/* Criar banco de dados
CREATE DATABASE DbFilme;
GO 
*/

/* Comando para mostrar tabelas existentes
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;
GO
*/

USE DbFilme;
GO

-- Criar tabela Genres
CREATE TABLE genres (
    genres_id INT PRIMARY KEY IDENTITY(1,1),
    genre_name VARCHAR(100) NOT NULL UNIQUE
);
GO

-- Criar tabela Movies
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
GO

-- Criar tabela Movie_Genres
CREATE TABLE movie_genres (
    movie_id BIGINT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genres_id)
);
GO

-- Criar tabela Review
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
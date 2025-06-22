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
SELECT * FROM movies;
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

SELECT movies.movie_id AS 'Id', title AS 'Titulo', release_date AS 'Data de Lançamento', description AS 'Descrição', duration AS 'Duração (minutos)', metascore AS 'Metascore', metascore_count AS 'Contagem de Metascore', genre_name AS 'Gênero'
FROM movies INNER JOIN movie_genres ON movies.movie_id = movie_genres.movie_id
INNER JOIN genres ON movie_genres.genre_id = genres.genres_id
WHERE genres.genre_name = 'Drama';
GO

/* ----------------------------------------------------------------------- */

-- Populando tabelas base (sem dependências)

INSERT INTO rating VALUES
(1, 'G'), (2, 'PG'), (3, 'PG-13'), (4, 'R'), (5, 'NC-17'),
(6, 'Not Rated'), (7, 'TV-G'), (8, 'TV-PG'), (9, 'TV-14'), (10, 'TV-MA');

INSERT INTO genres VALUES
(1, 'Action'), (2, 'Comedy'), (3, 'Drama'), (4, 'Fantasy'), (5, 'Horror'),
(6, 'Romance'), (7, 'Sci-Fi'), (8, 'Thriller'), (9, 'Animation'), (10, 'Documentary');

INSERT INTO metascore_sentiment VALUES
(1, 'Excellent'), (2, 'Good'), (3, 'Average'), (4, 'Poor'), (5, 'Terrible'),
(6, 'Mixed'), (7, 'Above Average'), (8, 'Below Average'), (9, 'Critical'), (10, 'Outstanding');

INSERT INTO userscore_sentiment VALUES
(1, 'Positive'), (2, 'Negative'), (3, 'Mixed'), (4, 'Neutral'), (5, 'Polarized'),
(6, 'Enthusiastic'), (7, 'Disappointed'), (8, 'Surprised'), (9, 'Satisfied'), (10, 'Angry');

INSERT INTO production_companies VALUES
(1, 'Universal Pictures'), (2, 'Warner Bros'), (3, 'Paramount Pictures'), (4, 'Sony Pictures'),
(5, 'Netflix'), (6, 'Amazon Studios'), (7, '20th Century Fox'), (8, 'Marvel Studios'),
(9, 'Disney'), (10, 'HBO Films');

INSERT INTO director VALUES
(1, 'Steven Spielberg'), (2, 'Christopher Nolan'), (3, 'Quentin Tarantino'), (4, 'Martin Scorsese'),
(5, 'Greta Gerwig'), (6, 'Jordan Peele'), (7, 'James Cameron'), (8, 'Chloé Zhao'),
(9, 'Taika Waititi'), (10, 'Patty Jenkins');

INSERT INTO writer VALUES
(1, 'Aaron Sorkin'), (2, 'Charlie Kaufman'), (3, 'Nora Ephron'), (4, 'Jordan Peele'),
(5, 'Quentin Tarantino'), (6, 'Jane Campion'), (7, 'Diablo Cody'), (8, 'James Gunn'),
(9, 'Sofia Coppola'), (10, 'Greta Gerwig');

INSERT INTO top_cast VALUES
(1, 'Tom Hanks'), (2, 'Meryl Streep'), (3, 'Denzel Washington'), (4, 'Scarlett Johansson'),
(5, 'Brad Pitt'), (6, 'Viola Davis'), (7, 'Robert Downey Jr'), (8, 'Zendaya'),
(9, 'Leonardo DiCaprio'), (10, 'Emma Stone');

-- Inserindo filmes com FK válidas

INSERT INTO movies VALUES
(1, 'Movie One', '2020-01-01', 1, 'Description 1', 120, 'Tagline 1', 85, 150, 1, 8, 200, 1),
(2, 'Movie Two', '2020-02-01', 2, 'Description 2', 95, 'Tagline 2', 72, 100, 2, 6, 120, 2),
(3, 'Movie Three', '2020-03-01', 3, 'Description 3', 110, 'Tagline 3', 65, 90, 3, 7, 110, 3),
(4, 'Movie Four', '2020-04-01', 4, 'Description 4', 130, 'Tagline 4', 90, 130, 4, 9, 220, 4),
(5, 'Movie Five', '2020-05-01', 5, 'Description 5', 100, 'Tagline 5', 50, 60, 5, 5, 100, 5),
(6, 'Movie Six', '2020-06-01', 6, 'Description 6', 140, 'Tagline 6', 77, 110, 6, 4, 80, 6),
(7, 'Movie Seven', '2020-07-01', 7, 'Description 7', 105, 'Tagline 7', 88, 140, 7, 9, 150, 7),
(8, 'Movie Eight', '2020-08-01', 8, 'Description 8', 90, 'Tagline 8', 81, 200, 8, 6, 180, 8),
(9, 'Movie Nine', '2020-09-01', 9, 'Description 9', 115, 'Tagline 9', 66, 100, 9, 3, 130, 9),
(10,'Movie Ten', '2020-10-01', 10, 'Description 10', 125, 'Tagline 10', 79, 115, 10, 2, 160, 10);

-- Ligando os filmes às outras entidades (1 para 1)

INSERT INTO movie_genres VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO movie_companies VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO movie_director VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO movie_writer VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

INSERT INTO movie_cast VALUES
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

-- Populando tabelas de review

INSERT INTO review_type VALUES
(1, 'Fresh'), (2, 'Rotten'), (3, 'Mixed'), (4, 'Positive'), (5, 'Negative'),
(6, 'Excellent'), (7, 'Average'), (8, 'Poor'), (9, 'Great'), (10, 'Awful');

INSERT INTO publication_name VALUES
(1, 'New York Times'), (2, 'The Guardian'), (3, 'Variety'), (4, 'Hollywood Reporter'),
(5, 'IndieWire'), (6, 'Empire'), (7, 'Rolling Stone'), (8, 'Collider'), (9, 'IGN'), (10, 'ScreenRant');

INSERT INTO author VALUES
(1, 'John Doe'), (2, 'Jane Smith'), (3, 'Alice Lee'), (4, 'Bob Brown'),
(5, 'Clara Black'), (6, 'Derek White'), (7, 'Eva Green'), (8, 'Frank Blue'),
(9, 'Grace Gold'), (10, 'Hank Red');

-- Ligando reviews aos filmes (1 review por filme)

INSERT INTO review VALUES
(1, 1, 'Amazing movie.', '2020-01-05', 1, 1, 1),
(2, 2, 'Pretty good overall.', '2020-02-06', 2, 2, 2),
(3, 3, 'Mixed feelings about it.', '2020-03-07', 3, 3, 3),
(4, 4, 'Excellent performances.', '2020-04-08', 4, 4, 4),
(5, 5, 'Too slow for my taste.', '2020-05-09', 5, 5, 5),
(6, 6, 'Visually stunning.', '2020-06-10', 6, 6, 6),
(7, 7, 'Well written and acted.', '2020-07-11', 7, 7, 7),
(8, 8, 'Could have been better.', '2020-08-12', 8, 8, 8),
(9, 9, 'Did not enjoy it.', '2020-09-13', 9, 9, 9),
(10,10, 'One of the best this year!', '2020-10-14', 10, 10, 10);

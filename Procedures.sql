USE DbFilme;
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

-- Exemplo de uso
EXEC sp_MostraFilmePorGenero 'Crime';
GO

-- Procedure para mostrar filme por ID
CREATE PROCEDURE sp_MostraFilmePorId @movie_id BIGINT AS
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
    WHERE movies.movie_id = @movie_id
    ORDER BY movies.movie_id;
END;
GO

-- Exemplo de uso
EXEC sp_MostraFilmePorId 2000550083;
GO


-- Procedure para mostrar as reviews de um filme por ID
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
    WHERE movies.movie_id = @movie_id;
END;
GO

-- Exemplo de uso
EXEC sp_MostraReviewsPorFilme 2000550083;
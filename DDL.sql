/*
CREATE DATABASE DbFilme;
use DbFilme;
*/

CREATE TABLE rating(
	rating_id INT PRIMARY KEY, 
    rating VARCHAR(20)
);

CREATE TABLE genres (
  genres_id INT PRIMARY KEY,
  genre_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE metascore_sentiment (
  mt_score_id INT PRIMARY KEY,
  mt_score VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE userscore_sentiment (
  us_score_id INT PRIMARY KEY,
  us_score VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE production_companies (
  pc_id INT PRIMARY KEY,
  pc_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE director (
  director_id INT PRIMARY KEY,
  director_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE writer (
  writer_id INT PRIMARY KEY,
  writer_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE top_cast (
  cast_id INT PRIMARY KEY,
  cast_name VARCHAR(255) NOT NULL UNIQUE
);

ALTER TABLE movies
ALTER COLUMN userscore INT;
GO

CREATE TABLE movies (
  movie_id BIGINT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  release_date DATE,
  rating_id INT,
  description TEXT,
  duration INT,
  tagline TEXT,
  metascore INT,
  metascore_count INT,
  mt_score_id INT,
  userscore INT,
  userscore_count INT,
  us_score_id INT,
  FOREIGN KEY (rating_id) REFERENCES rating(rating_id),
  FOREIGN KEY (mt_score_id) REFERENCES metascore_sentiment (mt_score_id),
  FOREIGN KEY (us_score_id) REFERENCES userscore_sentiment (us_score_id)
);
 
CREATE TABLE movie_genres (
  movie_id BIGINT,
  genre_id INT,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN KEY (genre_id) REFERENCES genres(genres_id)
);

CREATE TABLE movie_companies (
  movie_id BIGINT,
  company_id INT,
  PRIMARY KEY (movie_id, company_id),
  FOREIGN KEY (movie_id)   REFERENCES movies(movie_id),
  FOREIGN KEY (company_id) REFERENCES production_companies(pc_id)
);

CREATE TABLE movie_director (
  movie_id BIGINT,
  director_id INT,
  PRIMARY KEY (movie_id, director_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN KEY (director_id) REFERENCES director(director_id)
);

CREATE TABLE movie_writer (
  movie_id BIGINT,
  writer_id INT,
  PRIMARY KEY (movie_id, writer_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN KEY (writer_id) REFERENCES writer(writer_id)
);

CREATE TABLE movie_cast (
  movie_id BIGINT,
  cast_id INT,
  PRIMARY KEY (movie_id, cast_id),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
  FOREIGN KEY (cast_id) REFERENCES top_cast(cast_id)
);

-- TABELAS REVIEW

CREATE TABLE review_type(
	rw_type_id INT PRIMARY KEY,
    rw_type VARCHAR(20)
);

CREATE TABLE publication_name(
	publication_name_id INT PRIMARY KEY,
    publication_name VARCHAR(100)
);

CREATE TABLE author(
	author_id INT PRIMARY KEY,
    author_name VARCHAR(20)
);

CREATE TABLE review(
	review_id INT PRIMARY KEY,
    movie_id BIGINT,
    quote VARCHAR(2000),
    publication_date DATE,
    author_id INT,
    publication_name_id INT,
    rw_type_id INT,
	FOREIGN KEY (author_id)  REFERENCES author(author_id),
    FOREIGN KEY (publication_name_id)  REFERENCES publication_name(publication_name_id),
    FOREIGN KEY (rw_type_id)  REFERENCES review_type(rw_type_id),
    FOREIGN KEY (movie_id)  REFERENCES movies(movie_id)
);




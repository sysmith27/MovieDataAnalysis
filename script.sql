
USE DATABASE MOVIEDATA;

CREATE TABLE movies (
    poster_link VARCHAR,          -- Link of the poster
    series_title VARCHAR,         -- Name of the movie
    released_year INT,            -- Year at which that movie was released
    certificate VARCHAR,          -- Certificate earned by that movie
    runtime VARCHAR,              -- Total runtime of the movie
    genre VARCHAR,                -- Genre of the movie
    imdb_rating FLOAT,            -- Rating of the movie on IMDB
    overview TEXT,                -- Mini story/summary
    meta_score INT,               -- Score earned by the movie
    director VARCHAR,             -- Name of the director
    star1 VARCHAR,                -- Name of the first star
    star2 VARCHAR,                -- Name of the second star
    star3 VARCHAR,                -- Name of the third star
    star4 VARCHAR,                -- Name of the fourth star
    no_of_votes INT,              -- Total number of votes
    gross FLOAT                   -- Money earned by the movie
);

CREATE IF NOT EXISTS SCHEMA movie_schema;

CREATE SEQUENCE movie_schema.movie_seq START 1 INCREMENT 1;
CREATE TABLE movie_schema.movies_fact (
    movie_id INT DEFAULT movie_schema.movie_seq.NEXTVAL PRIMARY KEY, -- Unique movie identifier
    poster_link VARCHAR,                     -- Link to the movie poster
    series_title VARCHAR,                    -- Name of the movie
    released_year INT,                       -- Year of release
    runtime VARCHAR,                         -- Runtime of the movie
    certificate VARCHAR,                     -- Certificate of the movie
    genre_id INT,                            -- Foreign key to genres_dim
    director_id INT,                         -- Foreign key to directors_dim
    star1_id INT,                            -- Foreign key to stars_dim
    star2_id INT,                            -- Foreign key to stars_dim
    star3_id INT,                            -- Foreign key to stars_dim
    star4_id INT,                            -- Foreign key to stars_dim
    imdb_rating FLOAT,                       -- IMDB rating
    overview TEXT,                           -- Movie summary
    meta_score INT,                          -- Meta score
    no_of_votes INT,                         -- Total number of votes
    gross FLOAT                              -- Gross revenue
);

CREATE SEQUENCE movie_schema.genre_seq START 1 INCREMENT 1;
CREATE TABLE movie_schema.genres_dim (
    genre_id INT DEFAULT movie_schema.genre_seq.NEXTVAL PRIMARY KEY, -- Unique genre identifier
    genre_name VARCHAR UNIQUE                -- Genre name
);

CREATE SEQUENCE movie_schema.director_seq START 1 INCREMENT 1;
CREATE TABLE movie_schema.directors_dim (
    director_id INT DEFAULT movie_schema.director_seq.NEXTVAL PRIMARY KEY, -- Unique director identifier
    director_name VARCHAR UNIQUE                -- Director name
);

CREATE SEQUENCE movie_schema.star_seq START 1 INCREMENT 1;
CREATE TABLE movie_schema.stars_dim (
    star_id INT DEFAULT movie_schema.star_seq.NEXTVAL PRIMARY KEY, -- Unique star identifier
    star_name VARCHAR UNIQUE                -- Star name (actor/actress)
);

--Populate
INSERT INTO movie_schema.genres_dim (genre_name)
SELECT DISTINCT "Genre"
FROM public.movies;

INSERT INTO movie_schema.directors_dim (director_name)
SELECT DISTINCT "Director"
FROM public.movies;

INSERT INTO movie_schema.stars_dim (star_name)
SELECT DISTINCT "Star1"
FROM public.movies;

INSERT INTO movie_schema.stars_dim (star_name)
SELECT DISTINCT "Star2"
FROM public.movies;

INSERT INTO movie_schema.stars_dim (star_name)
SELECT DISTINCT "Star3"
FROM public.movies;

INSERT INTO movie_schema.stars_dim (star_name)
SELECT DISTINCT "Star4"
FROM public.movies;

INSERT INTO movie_schema.movies_fact (
    poster_link, series_title, released_year, runtime, certificate,
    genre_id, director_id, star1_id, star2_id, star3_id, star4_id,
    imdb_rating, overview, meta_score, no_of_votes, gross
)
SELECT
    m."Poster_Link",       -- Correct case-sensitive reference
    m."Series_Title",
    m."Released_Year",
    m."Runtime",
    m."Certificate",
    gd.genre_id,           -- Map genre to genre_id
    dd.director_id,        -- Map director to director_id
    s1.star_id AS star1_id, -- Map Star1 to star_id
    s2.star_id AS star2_id, -- Map Star2 to star_id
    s3.star_id AS star3_id, -- Map Star3 to star_id
    s4.star_id AS star4_id, -- Map Star4 to star_id
    m."IMDB_Rating",
    m."Overview",
    m."Meta_score",
    m."No_of_Votes",
    m."Gross"
FROM
    public.movies m -- Alias for the movies table
LEFT JOIN
    movie_schema.genres_dim gd ON m."Genre" = gd.genre_name
LEFT JOIN
    movie_schema.directors_dim dd ON m."Director" = dd.director_name
LEFT JOIN
    movie_schema.stars_dim s1 ON m."Star1" = s1.star_name
LEFT JOIN
    movie_schema.stars_dim s2 ON m."Star2" = s2.star_name
LEFT JOIN
    movie_schema.stars_dim s3 ON m."Star3" = s3.star_name
LEFT JOIN
    movie_schema.stars_dim s4 ON m."Star4" = s4.star_name;
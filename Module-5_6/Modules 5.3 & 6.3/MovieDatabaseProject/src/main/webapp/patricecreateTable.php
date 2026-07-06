-- Patrice Moracchini
-- CSD-430
-- Modules 5.2 and 6.2
-- Movie database SQL script

CREATE DATABASE IF NOT EXISTS CSD430;

USE CSD430;

CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';

GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';

FLUSH PRIVILEGES;

DROP TABLE IF EXISTS patricemoviesdata;

CREATE TABLE patricemoviesdata (
    movie_id INT NOT NULL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    director VARCHAR(100) NOT NULL,
    runtime INT NOT NULL
);

INSERT INTO patricemoviesdata
(movie_id, title, release_year, genre, director, runtime)
VALUES
(1, 'Clue', 1985, 'Comedy Mystery', 'Jonathan Lynn', 94),
(2, 'Tron Ares', 2025, 'Science Fiction', 'Joachim Ronning', 119),
(3, 'Innerspace', 1987, 'Science Fiction Comedy', 'Joe Dante', 120),
(4, 'Parasite', 2019, 'Thriller', 'Bong Joon-ho', 132),
(5, 'The Mummy', 1999, 'Adventure', 'Stephen Sommers', 124),
(6, 'Back to the Future', 1985, 'Science Fiction', 'Robert Zemeckis', 116),
(7, 'Jumpin'' Jack Flash', 1986, 'Comedy', 'Penny Marshall', 105),
(8, 'The Matrix', 1999, 'Science Fiction', 'The Wachowskis', 136),
(9, 'Ghostbusters', 1984, 'Comedy', 'Ivan Reitman', 105),
(10, 'Jaws', 1975, 'Thriller', 'Steven Spielberg', 124);

SELECT * FROM patricemoviesdata;
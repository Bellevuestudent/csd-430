<?php
/*
 * Patrice Moracchini
 * CSD-430
 * Modules 5.2 and 6.2
 *
 * This file inserts movie records into the patricemoviesdata table.
 */

include "db_config.php";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO patricemoviesdata
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
(10, 'Jaws', 1975, 'Thriller', 'Steven Spielberg', 124)";

if ($conn->query($sql) === TRUE) {
    echo "Movie records inserted successfully.";
} else {
    echo "Error inserting records: " . $conn->error;
}

$conn->close();
?>
<?php
/*
 * Patrice Moracchini
 * CSD-430
 * Modules 5.2 and 6.2
 *
 * This file drops the patricemoviesdata table.
 */

include "db_config.php";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "DROP TABLE IF EXISTS patricemoviesdata";

if ($conn->query($sql) === TRUE) {
    echo "Table patricemoviesdata dropped successfully.";
} else {
    echo "Error dropping table: " . $conn->error;
}

$conn->close();
?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="beans.MovieDatabaseReader, beans.MovieBean, java.util.ArrayList" %>
<%--
    The import statement allows this JSP page to use the MovieDatabaseReader class,
    the MovieBean class, and the ArrayList class.
--%>

<%--

    Patrice Moracchini

    CSD-430

    Assignment 4.2

    This JSP page displays movie records retrieved from a MySQL database.

    The database connection and Read method are handled by the MovieDatabaseReader class.

--%>

<%-- This scriptlet creates the reader object and stores the movie records in an ArrayList. --%>
<%
    MovieDatabaseReader movieReader = new MovieDatabaseReader();
    ArrayList<MovieBean> movies = movieReader.getAllMovies();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assignment Module 4.2 Movie JavaBean Display</title>
</head>
<body>
    <h1>My Favorite Movies</h1>

    <p>
        This page displays my favorite movies taken from a MySQL database.
        The movie records are retrieved using a Java class instead of connecting to
        the database directly from the JSP page. Each record is stored in a JavaBean
        and then displayed in an HTML table.
    </p>

    <h2>Field Descriptions</h2>

    <p>
        <strong>Movie ID:</strong> The unique identification number for each movie record.<br>
        <strong>Title:</strong> The name of the movie.<br>
        <strong>Release Year:</strong> The year the movie was released.<br>
        <strong>Genre:</strong> The category or type of movie.<br>
        <strong>Director:</strong> The person who directed the movie.<br>
        <strong>Runtime:</strong> The length of the movie in minutes.
    </p>

    <h2>Record Description</h2>

    <p>
        Each row in the table represents one movie record retrieved from the database.
        The records include the movie title, release year, genre, director, and runtime.
    </p>

    <!-- This table displays the movie records retrieved from the database. -->
    <table border="1">
        <thead>
            <tr>
                <th>Movie ID</th>
                <th>Title</th>
                <th>Release Year</th>
                <th>Genre</th>
                <th>Director</th>
                <th>Runtime</th>
            </tr>
        </thead>

        <tbody>
            <%-- This loop goes through each MovieBean object in the movies list. --%>
            <% for (MovieBean movie : movies) { %>
                <tr>
                    <%-- The getter methods display each field from the current MovieBean object. --%>
                    <td><%= movie.getMovieId() %></td>
                    <td><%= movie.getTitle() %></td>
                    <td><%= movie.getReleaseYear() %></td>
                    <td><%= movie.getGenre() %></td>
                    <td><%= movie.getDirector() %></td>
                    <td><%= movie.getRuntime() %> minutes</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
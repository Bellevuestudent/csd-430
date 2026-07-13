<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<!--
    Patrice Moracchini
    CSD-430
    Module 7

    This JSP handles the CREATE part of the movie database project.
    The form gathers movie data from the user and uses DbBean to add
    the new record to the patricemoviesdata table.
-->
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Create Movie Record</title>
</head>
<body>

    <h1>Movie Database CREATE</h1>

    <p>
        This page allows the user to add a new movie record to the CSD430 database.
        After the form is submitted, all movie records are displayed in a table.
    </p>

    <jsp:useBean id="myDB" class="database.DbBean" />

    <br />
    <a href="index.jsp">Return to Index</a>
    <br /><br />

    <%-- First page load: display the create form. --%>
    <%
        if(request.getMethod().equals("GET")) {
            out.print(myDB.formGetCreate("CRUD_Create.jsp"));
        }
    %>

    <%-- After submit: create the record and display all records. --%>
    <%
        if(request.getMethod().equals("POST")) {
            int movieId = Integer.parseInt(request.getParameter("movie_id"));
            String title = request.getParameter("title");
            int releaseYear = Integer.parseInt(request.getParameter("release_year"));
            String genre = request.getParameter("genre");
            String director = request.getParameter("director");
            int runtime = Integer.parseInt(request.getParameter("runtime"));

            out.print(myDB.createRecord(movieId, title, releaseYear, genre, director, runtime));

            out.println("<br />");

            out.print(myDB.readAll());
        }
    %>

</body>
</html>
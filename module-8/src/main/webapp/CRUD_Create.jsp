<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%--
    Patrice Moracchini
    CSD-430
    Module 7

    This JSP gathers movie data, stores it in DbBean through setters,
    creates the database record, and displays all movie records.
--%>

<jsp:useBean id="myDB" class="database.DbBean" />

<%-- Processes the submitted CREATE form. --%>
<%
    // Determines whether the form was submitted and whether the input is valid.
    boolean formSubmitted = request.getMethod().equals("POST");
    boolean validInput = false;
    boolean createSuccessful = false;

    if(formSubmitted) {
        try {
            // Stores the submitted values in the JavaBean through setters.
            myDB.setMovieId(Integer.parseInt(request.getParameter("movie_id")));
            myDB.setTitle(request.getParameter("title"));
            myDB.setReleaseYear(
                    Integer.parseInt(request.getParameter("release_year")));
            myDB.setGenre(request.getParameter("genre"));
            myDB.setDirector(request.getParameter("director"));
            myDB.setRuntime(Integer.parseInt(request.getParameter("runtime")));

            // Checks that the required fields are not null.
            validInput = myDB.getTitle() != null
                    && myDB.getGenre() != null
                    && myDB.getDirector() != null;

            if(validInput) {
                // Requests the INSERT operation from the JavaBean.
                createSuccessful = myDB.createRecord();
            }
        }
        catch(NumberFormatException e) {
            // Rejects movie ID, release year, or runtime values that are not numbers.
            validInput = false;
        }
    }

    // Retrieves the current records for the table displayed below.
    ArrayList<String[]> records = myDB.getAllRecords();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Movie Record</title>

    <style>
        /* Provides the page background, default typeface, and spacing. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Centers the CREATE content inside a readable panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 1050px;
            padding: 32px;
        }

        h1,
        h2 {
            color: #173b63;
        }

        h1 {
            margin-top: 0;
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 14px;
        }

        input {
            box-sizing: border-box;
            margin-top: 5px;
            padding: 9px;
            width: 100%;
        }

        button {
            background-color: #173b63;
            border: 0;
            color: #ffffff;
            cursor: pointer;
            margin-top: 20px;
            padding: 10px 18px;
        }

        .success,
        .error {
            margin-top: 20px;
            padding: 12px;
        }

        .success {
            background-color: #dcfce7;
            color: #14532d;
        }

        .error {
            background-color: #fee2e2;
            color: #7f1d1d;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            border-collapse: collapse;
            margin-top: 20px;
            width: 100%;
        }

        th,
        td {
            border: 1px solid #cbd5e1;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #173b63;
            color: #ffffff;
        }

        .navigation {
            margin-top: 24px;
        }

        a {
            color: #173b63;
        }
    </style>
</head>
<body>

    <main>
        <h1>Movie Database CREATE</h1>

        <p>Enter the information for the new movie record.</p>

        <%-- Collects all six movie fields. --%>
        <form method="post" action="CRUD_Create.jsp">
            <label for="movie_id">Movie ID</label>
            <input type="number" id="movie_id" name="movie_id" required>

            <label for="title">Title</label>
            <input type="text" id="title" name="title" required>

            <label for="release_year">Release Year</label>
            <input type="number" id="release_year" name="release_year" required>

            <label for="genre">Genre</label>
            <input type="text" id="genre" name="genre" required>

            <label for="director">Director</label>
            <input type="text" id="director" name="director" required>

            <label for="runtime">Runtime</label>
            <input type="number" id="runtime" name="runtime" required>

            <button type="submit">Create Movie Record</button>
        </form>

        <%-- Displays the result of the CREATE attempt. --%>
        <%
            if(formSubmitted && createSuccessful) {
        %>

            <p class="success">The movie record was created successfully.</p>

        <%
            }
            else if(formSubmitted && !validInput) {
        %>

            <p class="error">The submitted movie values were invalid.</p>

        <%
            }
            else if(formSubmitted) {
        %>

            <p class="error">The movie record could not be created.</p>

        <%
            }
        %>

        <h2>Movie Records</h2>

        <%-- Displays every movie record returned by the JavaBean. --%>
        <div class="table-wrapper">
            <table>
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
                    <%
                        for(String[] record : records) {
                    %>

                        <tr>
                            <td><%= record[0] %></td>
                            <td><%= record[1] %></td>
                            <td><%= record[2] %></td>
                            <td><%= record[3] %></td>
                            <td><%= record[4] %></td>
                            <td><%= record[5] %></td>
                        </tr>

                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <%-- Returns the user to the main project page. --%>
        <p class="navigation">
            <a href="index.jsp">Return to the project index</a>
        </p>
    </main>

</body>
</html>

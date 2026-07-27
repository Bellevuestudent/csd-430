<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%--
    Patrice Moracchini
    CSD-430
    Module 9.2

    Displays all movie records and deletes the record selected by movie_id.
    The remaining records and keys are displayed after each deletion.
--%>

<jsp:useBean id="myDB" class="database.DbBean" />

<%
    // Process the selected movie ID when the form is submitted.
    boolean formSubmitted =
            "POST".equalsIgnoreCase(request.getMethod());

    boolean validSelection = false;
    boolean deleteSuccessful = false;
    int selectedMovieId = 0;

    if(formSubmitted) {
        try {
            selectedMovieId = Integer.parseInt(
                    request.getParameter("movie_id"));

            validSelection = true;
            deleteSuccessful =
                    myDB.deleteRecord(selectedMovieId);
        }
        catch(NumberFormatException e) {
            validSelection = false;
        }
    }

    // Retrieve the records and IDs remaining after deletion.
    ArrayList<String[]> remainingRecords =
            myDB.getAllRecords();

    ArrayList<Integer> remainingMovieIds =
            myDB.getMovieIds();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Delete Movie Records</title>

    <style>
        /* Page layout. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Main content panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 1050px;
            padding: 32px;
        }

        /* Heading colors. */
        h1,
        h2 {
            color: #173b63;
        }

        /* Main heading spacing. */
        h1 {
            margin-top: 0;
        }

        /* Paragraph spacing. */
        p {
            line-height: 1.6;
        }

        /* Allows table scrolling on small screens. */
        .table-wrapper {
            overflow-x: auto;
        }

        /* Movie table layout. */
        table {
            border-collapse: collapse;
            margin: 20px 0;
            width: 100%;
        }

        /* Table cell layout. */
        th,
        td {
            border: 1px solid #cbd5e1;
            padding: 10px;
            text-align: left;
        }

        /* Table header colors. */
        th {
            background-color: #173b63;
            color: #ffffff;
        }

        /* Form control spacing. */
        select,
        button {
            margin-top: 10px;
            padding: 9px;
        }

        /* Delete button style. */
        button {
            background-color: #b91c1c;
            border: 0;
            color: #ffffff;
            cursor: pointer;
        }

        /* Successful deletion message. */
        .success {
            background-color: #dcfce7;
            color: #14532d;
            padding: 12px;
        }

        /* Error message. */
        .error {
            background-color: #fee2e2;
            color: #7f1d1d;
            padding: 12px;
        }

        /* Navigation spacing. */
        .navigation {
            margin-top: 24px;
        }

        /* Link color. */
        a {
            color: #173b63;
        }
    </style>
</head>

<body>

    <main>
        <h1>Movie Database DELETE</h1>

        <p>
            This table displays the movie ID, title, release year, genre,
            director, and runtime for every movie record. Select a movie
            ID to delete its complete record.
        </p>

        <%-- Display the result of the delete request. --%>
        <%
            if(formSubmitted && validSelection && deleteSuccessful) {
        %>

            <p class="success">
                Movie ID <%= selectedMovieId %> was deleted successfully.
            </p>

        <%
            }
            else if(formSubmitted && !validSelection) {
        %>

            <p class="error">
                The submitted movie ID was invalid.
            </p>

        <%
            }
            else if(formSubmitted && !deleteSuccessful) {
        %>

            <p class="error">
                The selected movie could not be deleted.
            </p>

        <%
            }
        %>

        <h2>Remaining Movie Records</h2>

        <%-- Display all remaining records. The header stays if empty. --%>
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
                        for(String[] record : remainingRecords) {
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

        <%
            if(remainingRecords.isEmpty()) {
        %>

            <p>No movie records remain in the database.</p>

        <%
            }
        %>

        <h2>Delete a Movie Record</h2>

        <%-- Display the remaining movie IDs in the delete form. --%>
        <%
            if(!remainingMovieIds.isEmpty()) {
        %>

            <form method="post" action="CRUD_Delete.jsp">
                <label for="movie_id">Movie ID:</label>

                <select id="movie_id" name="movie_id" required>
                    <%
                        for(Integer movieId : remainingMovieIds) {
                    %>

                        <option value="<%= movieId %>">
                            <%= movieId %>
                        </option>

                    <%
                        }
                    %>
                </select>

                <button type="submit">Delete Movie</button>
            </form>

        <%
            }
            else {
        %>

            <label for="empty_movie_id">Movie ID:</label>

            <select id="empty_movie_id" disabled>
                <option>No records remaining</option>
            </select>

            <button type="button" disabled>Delete Movie</button>

        <%
            }
        %>

        <p class="navigation">
            <a href="index.jsp">Return to the project index</a>
        </p>
    </main>

</body>
</html>

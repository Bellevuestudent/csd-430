<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%--
    Patrice Moracchini
    CSD-430
    Modules 5.3 and 6.3

    This JSP displays the database key values in a dropdown and uses
    DbBean to load and display the selected movie record.
--%>

<jsp:useBean id="myDB" class="database.DbBean" />

<%-- Retrieves the keys and processes the selected movie ID. --%>
<%
    // Retrieves the movie IDs used by the dropdown menu.
    ArrayList<Integer> movieIds = myDB.getMovieIds();

    // Tracks whether the user submitted and loaded a valid movie record.
    boolean formSubmitted = request.getMethod().equals("POST");
    boolean validSelection = false;
    boolean recordLoaded = false;
    int selectedMovieId = 0;

    if(formSubmitted) {
        try {
            // Converts the selected key and asks the bean to load its record.
            selectedMovieId = Integer.parseInt(
                    request.getParameter("movie_id"));
            validSelection = true;
            recordLoaded = myDB.loadMovie(selectedMovieId);
        }
        catch(NumberFormatException e) {
            // Rejects a missing or nonnumeric movie ID.
            validSelection = false;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Movie Record</title>

    <style>
        /* Provides the page background, default typeface, and spacing. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Centers the READ content inside a readable panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 1050px;
            padding: 32px;
        }

        h1 {
            color: #173b63;
            margin-top: 0;
        }

        select,
        button {
            margin-top: 10px;
            padding: 9px;
        }

        button {
            background-color: #173b63;
            border: 0;
            color: #ffffff;
            cursor: pointer;
        }

        .error {
            background-color: #fee2e2;
            color: #7f1d1d;
            margin-top: 20px;
            padding: 12px;
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
        <h1>Movie Database READ</h1>

        <p>Select a movie ID to display its complete database record.</p>

        <%-- Displays the database key values returned by the bean. --%>
        <form method="post" action="SelectMovie.jsp">
            <label for="movie_id">Movie ID:</label>

            <select id="movie_id" name="movie_id">
                <%
                    for(Integer movieId : movieIds) {
                %>

                    <option value="<%= movieId %>"
                        <%= movieId == selectedMovieId ? "selected" : "" %>>
                        <%= movieId %>
                    </option>

                <%
                    }
                %>
            </select>

            <button type="submit">Display Movie</button>
        </form>

        <%-- Displays all six fields for the selected movie. --%>
        <%
            if(recordLoaded) {
        %>

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
                        <tr>
                            <td><%= myDB.getMovieId() %></td>
                            <td><%= myDB.getTitle() %></td>
                            <td><%= myDB.getReleaseYear() %></td>
                            <td><%= myDB.getGenre() %></td>
                            <td><%= myDB.getDirector() %></td>
                            <td><%= myDB.getRuntime() %></td>
                        </tr>
                    </tbody>
                </table>
            </div>

        <%
            }
            else if(formSubmitted && (!validSelection || !recordLoaded)) {
        %>

            <p class="error">The selected movie record could not be loaded.</p>

        <%
            }
        %>

        <%-- Returns the user to the main project page. --%>
        <p class="navigation">
            <a href="index.jsp">Return to the project index</a>
        </p>
    </main>

</body>
</html>

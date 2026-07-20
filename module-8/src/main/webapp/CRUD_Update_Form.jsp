<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
    Patrice Moracchini
    CSD-430
    Module 8.2

    This JSP receives a movie_id from CRUD_Update_Select.jsp, loads the
    selected database record through DbBean, and displays an update form.
    The primary key is displayed as text and cannot be edited by the user.
--%>

<%-- Creates the JavaBean for database operations. --%>
<jsp:useBean id="myDB" class="database.DbBean" />

<%--
    Validates the submitted movie_id before asking the JavaBean to retrieve
    the selected record. No HTML is created inside this scriptlet.
--%>
<%
    String movieIdParameter = request.getParameter("movie_id");
    boolean movieLoaded = false;

    if(movieIdParameter != null) {
        try {
            int selectedMovieId = Integer.parseInt(movieIdParameter);
            movieLoaded = myDB.loadMovie(selectedMovieId);
        }
        catch(NumberFormatException e) {
            movieLoaded = false;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Movie Record</title>

    <style>
        /* Provides the page background, default typeface, and spacing. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Centers the update form inside a readable panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 680px;
            padding: 32px;
        }

        /* Uses the project color for the main heading. */
        h1 {
            color: #173b63;
            margin-top: 0;
        }

        /* Groups each label with its corresponding input. */
        .form-group {
            margin-bottom: 18px;
        }

        /* Places form labels above their input controls. */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        /* Gives all editable inputs a consistent appearance. */
        input[type="text"],
        input[type="number"] {
            border: 1px solid #9ca3af;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1rem;
            padding: 10px;
            width: 100%;
        }

        /* Distinguishes the non-editable primary key from editable values. */
        .primary-key {
            background-color: #e5e7eb;
            border-left: 4px solid #173b63;
            margin-bottom: 22px;
            padding: 12px;
        }

        /* Styles the form-submission button. */
        button {
            background-color: #173b63;
            border: none;
            border-radius: 5px;
            color: #ffffff;
            cursor: pointer;
            font-size: 1rem;
            padding: 11px 18px;
        }

        button:hover {
            background-color: #285784;
        }

        /* Highlights an invalid or missing database selection. */
        .error {
            background-color: #fee2e2;
            border-left: 4px solid #b91c1c;
            color: #7f1d1d;
            padding: 12px;
        }

        /* Adds spacing above the page-navigation links. */
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
        <h1>Edit Movie Information</h1>

        <%
            if(movieLoaded) {
        %>

            <p>
                Update the editable data below. 
            </p>

            <%--
                The form submits the updated values to CRUD_Update_Result.jsp
                for processing. Movie ID is sent as a hidden field to identify the record to update.
            --%>
            <form method="post" action="CRUD_Update_Result.jsp">
                <div class="primary-key">
                    <strong>Movie ID:</strong>
                    <%= myDB.getMovieId() %>
                </div>

                <input type="hidden"
                       name="movie_id"
                       value="<%= myDB.getMovieId() %>">

                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text"
                           name="title"
                           id="title"
                           maxlength="100"
                           value="<%= myDB.getTitle() %>"
                           required>
                </div>

                <div class="form-group">
                    <label for="release_year">Release Year</label>
                    <input type="number"
                           name="release_year"
                           id="release_year"
                           value="<%= myDB.getReleaseYear() %>"
                           required>
                </div>

                <div class="form-group">
                    <label for="genre">Genre</label>
                    <input type="text"
                           name="genre"
                           id="genre"
                           maxlength="50"
                           value="<%= myDB.getGenre() %>"
                           required>
                </div>

                <div class="form-group">
                    <label for="director">Director</label>
                    <input type="text"
                           name="director"
                           id="director"
                           maxlength="100"
                           value="<%= myDB.getDirector() %>"
                           required>
                </div>

                <div class="form-group">
                    <label for="runtime">Runtime in Minutes</label>
                    <input type="number"
                           name="runtime"
                           id="runtime"
                           min="1"
                           value="<%= myDB.getRuntime() %>"
                           required>
                </div>

                <button type="submit">Update Movie</button>
            </form>

        <%
            }
            else {
        %>

            <%-- Displayed when the key is missing, invalid, or not found. --%>
            <p class="error">
                The selected movie could not be loaded. Please return to the
                selection page and choose a valid Movie ID.
            </p>

        <%
            }
        %>

        <%-- Provides navigation without changing the selected database record. --%>
        <p class="navigation">
            <a href="CRUD_Update_Select.jsp">Choose another movie</a>
            &nbsp;|&nbsp;
            <a href="index.jsp">Return to the project index</a>
        </p>
    </main>

</body>
</html>
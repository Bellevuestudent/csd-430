<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%--
    Patrice Moracchini
    CSD-430
    Module 8.2

    This JSP displays the primary keys from the movie table in an HTML
    dropdown. The selected key is submitted to CRUD_Update_Form.jsp.
--%>

<%-- Creates a JavaBean for retrieving movie IDs. --%>
<jsp:useBean id="myDB" class="database.DbBean" />

<%--
    Calls the JavaBean before the HTML page is displayed. 
    The JavaBean retrieves the primary keys from the database and
    stores them in an ArrayList.
--%>
<%
    ArrayList<Integer> movieIds = myDB.getMovieIds();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select a Movie to Update</title>

    <style>
        /* Provides the background, default text color, and page spacing. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Centers the page content inside a readable panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 620px;
            padding: 32px;
        }

        /* Styles the page heading. */
        h1 {
            color: #173b63;
            margin-top: 0;
        }

        /* Improves the readability of paragraph text. */
        p {
            line-height: 1.6;
        }

        /* Styles the labels for form controls. */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        /* Styles the dropdown menu for selecting a movie. */
        select {
            border: 1px solid #9ca3af;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1rem;
            padding: 10px;
            width: 100%;
        }

        /* Styles the button used to submit the selected primary key. */
        button {
            background-color: #173b63;
            border: none;
            border-radius: 5px;
            color: #ffffff;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 20px;
            padding: 11px 18px;
        }

        /* Styles the button when the user hovers over it. */
        button:hover {
            background-color: #285784;
        }

        /* Styles the error message container. */
        .error {
            background-color: #fee2e2;
            border-left: 4px solid #b91c1c;
            color: #7f1d1d;
            padding: 12px;
        }

        /* Styles the navigation links at the bottom of the page. */
        .navigation {
            margin-top: 24px;
        }

        /* Uses the project color for navigation links. */
        a {
            color: #173b63;
        }
    </style>
</head>
<body>

    <main>
        <h1>Update a Movie Record</h1>

        <p>
            Select the ID of the movie data you want to update.
        </p>

        <%-- Displays an error message instead of an empty form. --%>
        <%
            if(movieIds.isEmpty()) {
        %>

            <p class="error">
                No movie records were found. Confirm that the database table
                has been created and populated.
            </p>

        <%
            }
            else {
        %>

            <%--
                Creates the form for selecting a movie to update.
                The form submits the selected primary key to CRUD_Update_Form.jsp.
            --%>
            <form method="post" action="CRUD_Update_Form.jsp">
                <label for="movie_id">Movie ID</label>

                <select name="movie_id" id="movie_id" required>
                    <%-- Creates one HTML option for each database key. --%>
                    <%
                        for(Integer movieId : movieIds) {
                    %>

                        <option value="<%= movieId %>">
                            <%= movieId %>
                        </option>

                    <%
                        }
                    %>
                </select>

                <button type="submit">Display Movie</button>
            </form>

        <%
            }
        %>

        <%-- Returns the user to the main project menu. --%>
        <p class="navigation">
            <a href="index.jsp">Return to the project index</a>
        </p>
    </main>

</body>
</html>
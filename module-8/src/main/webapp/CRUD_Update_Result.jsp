<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
    Patrice Moracchini
    CSD-430
    Module 8

    This JSP receives the edited movie values, stores them in DbBean through
    setters, updates the selected database record, and displays the updated
    record in a table whose headers identify the database field types.
--%>

<%-- Creates a page-scoped JavaBean for the UPDATE operation. --%>
<jsp:useBean id="myDB" class="database.DbBean" />

<%--
    Reads and validates the submitted form values. When the values are valid,
    the scriptlet stores them in the bean and requests the database update.
--%>
<%
    boolean validInput = false;
    boolean updateSuccessful = false;
    boolean recordLoaded = false;

    try {
        int movieId = Integer.parseInt(request.getParameter("movie_id"));
        String title = request.getParameter("title");
        int releaseYear = Integer.parseInt(request.getParameter("release_year"));
        String genre = request.getParameter("genre");
        String director = request.getParameter("director");
        int runtime = Integer.parseInt(request.getParameter("runtime"));

        validInput = title != null
                && genre != null
                && director != null;

        if(validInput) {
            myDB.setMovieId(movieId);
            myDB.setTitle(title);
            myDB.setReleaseYear(releaseYear);
            myDB.setGenre(genre);
            myDB.setDirector(director);
            myDB.setRuntime(runtime);

            updateSuccessful = myDB.updateRecord();

            if(updateSuccessful) {
                recordLoaded = myDB.loadMovie(movieId);
            }
        }
    }
    catch(NumberFormatException e) {
        validInput = false;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Updated Movie Record</title>

    <style>
        /* Provides the page background, default typeface, and spacing. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Centers the result content inside a wide panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 1050px;
            padding: 32px;
        }

        /* Uses the project color for the page heading. */
        h1 {
            color: #173b63;
            margin-top: 0;
        }

        /* Allows the result table to remain usable on narrow screens. */
        .table-wrapper {
            overflow-x: auto;
        }

        /* Formats the updated database record. */
        table {
            border-collapse: collapse;
            margin-top: 20px;
            width: 100%;
        }

        th,
        td {
            border: 1px solid #cbd5e1;
            padding: 11px;
            text-align: left;
        }

        /* Distinguishes field names and SQL types from record values. */
        th {
            background-color: #173b63;
            color: #ffffff;
        }

        tbody tr:nth-child(even) {
            background-color: #f8fafc;
        }

        /* Highlights a successful database update. */
        .success {
            background-color: #dcfce7;
            border-left: 4px solid #15803d;
            color: #14532d;
            padding: 12px;
        }

        /* Highlights invalid input or a failed database operation. */
        .error {
            background-color: #fee2e2;
            border-left: 4px solid #b91c1c;
            color: #7f1d1d;
            padding: 12px;
        }

        /* Separates the navigation links from the result message. */
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
        <h1>Updated Movie Record</h1>

        <%
            if(validInput && updateSuccessful && recordLoaded) {
        %>

            <p class="success">
                The selected movie record was updated successfully.
            </p>

            <%--
                Displays all six fields. Each table header includes the
                corresponding SQL field type required by the assignment.
            --%>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Movie ID<br>(INT)</th>
                            <th>Title<br>(VARCHAR(100))</th>
                            <th>Release Year<br>(INT)</th>
                            <th>Genre<br>(VARCHAR(50))</th>
                            <th>Director<br>(VARCHAR(100))</th>
                            <th>Runtime<br>(INT)</th>
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
            else if(!validInput) {
        %>

            <p class="error">
                The submitted movie values were invalid. Please return to the
                selection page and try again.
            </p>

        <%
            }
            else {
        %>

            <p class="error">
                The movie record could not be updated or reloaded from the
                database. Please return to the selection page and try again.
            </p>

        <%
            }
        %>

        <%-- Provides navigation after the update attempt is complete. --%>
        <p class="navigation">
            <a href="CRUD_Update_Select.jsp">Update another movie</a>
            &nbsp;|&nbsp;
            <a href="index.jsp">Return to the project index</a>
        </p>
    </main>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
    Patrice Moracchini
    CSD-430
    Modules 5, 6, 7, 8, and 9

    This index page provides links to the movie database project files.
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CSD-430 Movie Project Index</title>

    <style>
        /* Provides the page background, default typeface, and spacing. */
        body {
            background-color: #eef2f7;
            color: #1f2937;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px 20px;
        }

        /* Centers the project links inside a readable panel. */
        main {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
            margin: 0 auto;
            max-width: 800px;
            padding: 32px;
        }

        h1,
        h2 {
            color: #173b63;
        }

        h1 {
            margin-top: 0;
        }

        li {
            margin-bottom: 10px;
        }

        a {
            color: #175d9c;
        }
    </style>
</head>
<body>

    <main>
        <h1>CSD-430 Movie Database Project</h1>

        <p>
            This project uses MySQL, JDBC, JSP scriptlets, and JavaBeans to
            create, populate, read, update and delete movie records.
        </p>

        <h2>Modules 5.2 and 6.2</h2>

        <ul>
            <li>
                <a href="patrice_movies_data.sql">
                    SQL File - Create and Populate Movie Table
                </a>
            </li>
            <li>
                <a href="patricecreateTable.php">PHP File - Create Table</a>
            </li>
            <li>
                <a href="patricepopulateTable.php">PHP File - Populate Table</a>
            </li>
            <li>
                <a href="patricedropTable.php">PHP File - Drop Table</a>
            </li>
        </ul>

        <h2>Modules 5.3 and 6.3</h2>

        <ul>
            <li>
                <a href="SelectMovie.jsp">Select and Read One Movie Record</a>
            </li>
        </ul>

        <h2>Module 7</h2>

        <ul>
            <li>
                <a href="CRUD_Create.jsp">Create a New Movie Record</a>
            </li>
        </ul>

        <h2>Module 8</h2>

        <ul>
            <li>
                <a href="CRUD_Update_Select.jsp">Update a Movie Record</a>
            </li>
        </ul>
        
        <h2>Module 9</h2>

		<ul>
    		<li>
        		<a href="CRUD_Delete.jsp">Delete a Movie Record</a>
    		</li>
		</ul>
    </main>

</body>
</html>

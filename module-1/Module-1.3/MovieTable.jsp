<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--

    Patrice Moracchini

    CSD 430

    Module 1.3 JSP program

    This JSP file creates a movie table using Java arrays and a loop. (based on resource example.) 

    The movie information is displayed in an HTML table.

-->
<!DOCTYPE html>
<html>
	<head>
		<!-- Character encoding for the web page -->
		<meta charset="UTF-8">
		<!-- Title of the web page in the browser tab-->
		<title>Movie Table Program</title>
	</head>
	<body>
		<!-- Title in the web page -->
		<h1>Movie Table</h1>
		
		<!-- Creation of the table with a border -->
		<table border="1">
		
			<!-- First table row containing the column headers -->
			<tr>
				<th>Movie Title</th>

                <th>Release Year</th>

                <th>Genre</th>

                <th>Director</th>

            </tr>
			 
			 <% 
			 	/* movie information in  Java arrays in a JSP scriplet */
			 	String[] titles = {

                    "Clue",

                    "Tron: Ares",

                    "Innerspace",

                    "Parasite",

                    "Lee Cronin's The Mummy"

                };

                int[] years = {

                    1985,

                    2025,

                    1987,

                    2019,

                    2026

                };

                String[] genres = {

                    "Comedy / Mystery",

                    "Science Fiction / Action",

                    "Science Fiction / Comedy",

                    "Thriller / Drama",

                    "Horror"

                };

                String[] directors = {

                    "Jonathan Lynn",

                    "Joachim Rønning",

                    "Joe Dante",

                    "Bong Joon Ho",

                    "Lee Cronin"

                };
                
                /* loop that creates a row for each movie */

                for(int i = 0; i < titles.length; i++){

                    out.println("<tr>");

                    out.println("<td>" + titles[i] + "</td>");

                    out.println("<td>" + years[i] + "</td>");

                    out.println("<td>" + genres[i] + "</td>");

                    out.println("<td>" + directors[i] + "</td>");

                    out.println("</tr>");

                }
                 /* end of JSP scriplet */
                %>
                
		</table>
		
	</body>
</html>
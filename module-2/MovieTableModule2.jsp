<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--
 Patrice Moracchini
 CSD 430 
 Assignment Module 2.2
 This program will create a dynamic HTML page using JSP Scriptlets 
 using Java arrays to create a movie table with categories.
 -->    
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Favorite Movies</title>
	
	<!-- CSS file link -->
	<link rel="stylesheet" href="style.css">
	
</head>
<body>

	<h1> Favorite Movies</h1>
	
	<p>
		This page will display a table containing the information about 
		my five favorite movies. They are grouped by topical categories:
		title, release year, genre, director and category.
	</p>
	
	<%
	/* movie information in arrays   */
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
    
   
     /* end of JSP scriplet */
    %>
	
	<h2>Field Description</h2>
	
	<ul>
		<li><strong>Movie Title:</strong> The name of the movie.</li>
        <li><strong>Release Year:</strong> The year the movie was released.</li>
        <li><strong>Genre:</strong> The topical category or style of the movie.</li>
        <li><strong>Director:</strong> The person who directed the movie.</li>
	</ul>
	<h2>Record Description</h2>

    <p>
        Each record in the table represents one movie. A record contains the
        movie title, release year, genre, and director.
    </p>

    <h2>Movie Table</h2>
    <!-- Create the table using HTML and populate it with data from the arrays using JSP scriptlets -->
    <table>
        <tr>
            <th>Movie Title</th>
            <th>Release Year</th>
            <th>Genre / Topical Category</th>
            <th>Director</th>
        </tr>
        
        <% // Loop to create the table 
        
        for (int i = 0; i < titles.length; i++) { %>
            <tr>
                <td><%= titles[i] %></td>
                <td><%= years[i] %></td>
                <td><%= genres[i] %></td>
                <td><%= directors[i] %></td>
            </tr>
        <% } %>
        
	</table>
        
</body>
</html>
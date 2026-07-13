<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<!--
    Patrice Moracchini
    CSD-430
    Modules 5.3 and 6.3

    This JSP displays a dropdown menu of movie IDs.
    It uses DbBean to retrieve and display the selected movie record. 
-->
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Select Movie Record</title>
</head>
<body>

    <h1>Movie Database READ</h1>

    <p>
        This page gathers data from the CSD430 database using a JavaBean.
        The dropdown menu displays the primary key values from the patricemoviesdata table.
    </p>

    <jsp:useBean id="myDB" class="database.DbBean" />

    <br />
    <a href="index.jsp">Return to Index</a>
    <br /><br />

    <%-- First page load: display only the dropdown form. --%>
    <%
        if(request.getMethod().equals("GET")) {
            out.print(myDB.formGetPK("SelectMovie.jsp"));
        }
    %>

    <%-- After submit: display the dropdown again and the selected movie record. --%>
    <%
        if(request.getMethod().equals("POST")) {
            String movieId = request.getParameter("movie_id");

            out.print(myDB.formGetPK("SelectMovie.jsp"));

            out.println("<br /><br />");

            out.print(myDB.read(Integer.parseInt(movieId)));
        }
    %>

</body>
</html>
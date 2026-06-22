<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 
    Patrice Moracchini
    CSD-430
    Assignment 3.2

    This JSP file receives the restaurant feedback form data
    from restaurantFeedback.jsp.

    Scriptlets are used to get the submitted form values
    using request.getParameter().
-->

<%
    String customerName = request.getParameter("customerName");
    String visitDate = request.getParameter("visitDate");
    String mealType = request.getParameter("mealType");
    String serviceRating = request.getParameter("serviceRating");
    String recommend = request.getParameter("recommend");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurant Feedback Results</title>
</head>
<body>

    <!-- Page title displayed to the user -->
    <h1>Restaurant Feedback Results</h1>

    <!-- Description of the displayed data -->
    <p>
        This page displays the restaurant feedback submitted by the customer.
    </p>

    <!-- Field descriptions explain what each submitted field represents -->
    <h2>Field Descriptions</h2>

    <table border="1">
        <tbody>
            <tr>
                <th>Field Name</th>
                <th>Description</th>
            </tr>

            <tr>
                <td>Customer Name</td>
                <td>The name of the customer submitting the restaurant feedback form.</td>
            </tr>

            <tr>
                <td>Visit Date</td>
                <td>The date when the customer visited the restaurant.</td>
            </tr>

            <tr>
                <td>Meal Type</td>
                <td>The type of meal entered by the customer.</td>
            </tr>

            <tr>
                <td>Service Rating</td>
                <td>The customer's rating of the restaurant service.</td>
            </tr>

            <tr>
                <td>Recommendation</td>
                <td>Shows whether the customer would recommend the restaurant.</td>
            </tr>
        </tbody>
    </table>

    <!-- Record description explains the submitted feedback entry -->
    <h2>Record Description</h2>

    <p>
        This record contains one restaurant feedback submission.
        Each data entry point from the form is displayed in the table below.
    </p>

    <!-- Table displays the data submitted from the form -->
    <h2>Submitted Feedback Data</h2>

    <table border="1">
        <tbody>
            <tr>
                <th>Data Entry Point</th>
                <th>Submitted Data</th>
            </tr>

            <tr>
                <td>Customer Name</td>
                <td><%= customerName %></td>
            </tr>

            <tr>
                <td>Visit Date</td>
                <td><%= visitDate %></td>
            </tr>

            <tr>
                <td>Meal Type</td>
                <td><%= mealType %></td>
            </tr>

            <tr>
                <td>Service Rating</td>
                <td><%= serviceRating %></td>
            </tr>

            <tr>
                <td>Recommendation</td>
                <td><%= recommend %></td>
            </tr>
        </tbody>
    </table>

</body>
</html>
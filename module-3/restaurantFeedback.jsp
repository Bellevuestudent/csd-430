<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Feedback Form</title>
</head>
<body>

	<!-- 
		Patrice Moracchini
		CSD-430
		Assignment 3.2
		
		This JSP file gets the data from customer feedback in a restaurant
		Then the form sends the data to displayFeedback.jsp.
	-->
	
	<!-- Page title displayed to the user -->
	<h1>Restaurant Feedback Form</h1>
	
	<!-- Description explaining the purpose of the form -->
	<p>
	Dear customer, We would appreciate it if you would leave feedback for our restaurant.
	Please leave a comment about the place, the meal, the service, and whether you would recommend this restaurant.
	Thank you for your time and your visit.
	</p>
	
	<!-- Form section -->
	<h2>Feedback Entry Form</h2>
	    
	 <!-- Form sends customer feedback data to the displayFeedback.jsp page -->
	 <form name="feedbackForm" action="displayFeedback.jsp" method="post">

		<!-- Table organizes the form labels and input fields -->
        <table border="1">

            <tbody>
				
				<!-- Text input for the customer name -->
                <tr>

                    <td>Customer Name:</td>

                    <td>

                        <input type="text" name="customerName" value="" size="50">

                    </td>

                </tr>
				
				<!-- Date input for the restaurant visit date -->
                <tr>

                    <td>Visit Date:</td>

                    <td>

                        <input type="date" name="visitDate">

                    </td>

                </tr>
				
				<!-- Text input for entering the meal type -->
                <tr>

    				<td>Meal Type:</td>

    				<td>

       					 <input type="text" name="mealType" value="" size="50">

    				</td>

				</tr>

                <!-- Number input for entering the customer's service rating -->
                <tr>

                    <td>Service Rating:</td>

                    <td>

                        <input type="number" name="serviceRating" min="1" max="10">

                    </td>

                </tr>

                <!-- Text input for entering whether the customer would recommend the restaurant -->
                <tr>

                    <td>Would you recommend this restaurant?</td>

                    <td>

                        <input type="text" name="recommend" value="" size="50">

                    </td>

                </tr>

            </tbody>

        </table>

        <!-- Reset button clears the form, and submit button sends the form data -->
		<input type="reset" value="Clear Form" id="clear">
		<input type="submit" value="Submit Feedback" id="submit">


    </form>
	

</body>
</html>
package database;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

/*
 * Patrice Moracchini
 * CSD-430
 * Modules 5.3 and 6.3
 *
 * This JavaBean handles the READ operation for the movie database project.
 * It connects to the CSD430 database, retrieves movie IDs for the dropdown menu,
 * and returns the selected movie record for display in the JSP page.
 */
public class DbBean implements java.io.Serializable {

    private static final long serialVersionUID = 111222333444L;

    private Connection connection;
    private Statement statement;

    // Constructor: loads the database settings and opens the MySQL connection.
    public DbBean() {
        // Load the database settings from db.properties and establish a connection to the MySQL database.
        try {
            Properties properties = new Properties();

            InputStream input = getClass()
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

            if (input == null) {
                throw new Exception("db.properties file was not found.");
            }
            // Load the properties from the input stream
            properties.load(input);

            String driver = properties.getProperty("db.driver");
            String url = properties.getProperty("db.url");
            String username = properties.getProperty("db.username");
            String password = properties.getProperty("db.password");

            Class.forName(driver);

            connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
        }
        // Catch exceptions related to the JDBC driver not being found or other database connection issues.
        catch(ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver was not found.");
            e.printStackTrace();
        }
        catch(Exception e) {
            System.out.println("Database configuration or connection error.");
            e.printStackTrace();
        }
    }

    // Builds the HTML form and fills the dropdown with movie_id values from the database.
    public String formGetPK(String requestURL) {
        // Initialize the ResultSet and StringBuilder for building the HTML form.
        ResultSet resultSet = null;
        StringBuilder dataStringBuilder = new StringBuilder();
        // Execute a query to retrieve all movie_id values from the patricemoviesdata table, ordered by movie_id.
        try {
            resultSet = statement.executeQuery(
                "SELECT movie_id FROM patricemoviesdata ORDER BY movie_id"
            );
        }
        // Catch exceptions related to executing the query and retrieving movie IDs.
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error retrieving movie IDs: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }
        // Build the HTML form with a dropdown menu for selecting a movie ID.
        dataStringBuilder.append("<form method='post' action='" + requestURL + "'>");
        dataStringBuilder.append("<label for='movie_id'>Select a Movie ID:</label>");
        dataStringBuilder.append("<br /><br />");
        dataStringBuilder.append("<select name='movie_id' id='movie_id'>");

        // Populate the dropdown menu with movie_id values retrieved from the database.
        try {
            while(resultSet != null && resultSet.next()) {
                dataStringBuilder.append("<option value='");
                dataStringBuilder.append(resultSet.getInt("movie_id"));
                dataStringBuilder.append("'>");
                dataStringBuilder.append(resultSet.getInt("movie_id"));
                dataStringBuilder.append("</option>");
            }
        }
        // Catch exceptions related to building the dropdown menu and appending movie IDs to the HTML form.
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error building dropdown: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }
        // Close the select element and add a submit button to the form.
        dataStringBuilder.append("</select>");
        dataStringBuilder.append("<br /><br />");
        dataStringBuilder.append("<input type='submit' value='Display Movie' />");
        dataStringBuilder.append("</form>");

        return dataStringBuilder.toString();
    }

    // Retrieves and displays one movie record based on the selected primary key.
    public String read(int movieId) {

        StringBuilder dataStringBuilder = new StringBuilder();
        ResultSet resultSet = null;
        // Execute a query to retrieve the movie record corresponding to the selected movie_id.
        try {
            resultSet = statement.executeQuery(
                "SELECT * FROM patricemoviesdata WHERE movie_id = " + movieId
            );
        }
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error reading selected movie: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }
        // Build the HTML table to display the selected movie record.
        try {
            dataStringBuilder.append("<h2>Selected Movie Record</h2>");

            dataStringBuilder.append("<p>");
            dataStringBuilder.append("This record was retrieved from the CSD430 database using a JavaBean and JDBC.");
            dataStringBuilder.append("</p>");

            dataStringBuilder.append("<h3>Field Descriptions</h3>");
            dataStringBuilder.append("<ul>");
            dataStringBuilder.append("<li><b>Movie ID:</b> Primary key for the movie record.</li>");
            dataStringBuilder.append("<li><b>Title:</b> The name of the movie.</li>");
            dataStringBuilder.append("<li><b>Release Year:</b> The year the movie was released.</li>");
            dataStringBuilder.append("<li><b>Genre:</b> The movie category.</li>");
            dataStringBuilder.append("<li><b>Director:</b> The movie director.</li>");
            dataStringBuilder.append("<li><b>Runtime:</b> The movie length in minutes.</li>");
            dataStringBuilder.append("</ul>");

            dataStringBuilder.append("<table border='1'>");

            dataStringBuilder.append("<thead>");
            dataStringBuilder.append("<tr>");
            dataStringBuilder.append("<th>Movie ID</th>");
            dataStringBuilder.append("<th>Title</th>");
            dataStringBuilder.append("<th>Release Year</th>");
            dataStringBuilder.append("<th>Genre</th>");
            dataStringBuilder.append("<th>Director</th>");
            dataStringBuilder.append("<th>Runtime</th>");
            dataStringBuilder.append("</tr>");
            dataStringBuilder.append("</thead>");

            dataStringBuilder.append("<tbody>");
            // Iterate through the ResultSet and append each movie record to the HTML table.
            while(resultSet != null && resultSet.next()) {
                dataStringBuilder.append("<tr>");
                dataStringBuilder.append("<td>" + resultSet.getInt("movie_id") + "</td>");
                dataStringBuilder.append("<td>" + resultSet.getString("title") + "</td>");
                dataStringBuilder.append("<td>" + resultSet.getInt("release_year") + "</td>");
                dataStringBuilder.append("<td>" + resultSet.getString("genre") + "</td>");
                dataStringBuilder.append("<td>" + resultSet.getString("director") + "</td>");
                dataStringBuilder.append("<td>" + resultSet.getInt("runtime") + "</td>");
                dataStringBuilder.append("</tr>");
            }

            dataStringBuilder.append("</tbody>");
            dataStringBuilder.append("</table>");
        }
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error displaying selected movie: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }

        return dataStringBuilder.toString();
    }
}
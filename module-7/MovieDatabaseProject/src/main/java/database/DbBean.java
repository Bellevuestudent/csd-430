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
 * Modules 5.3, 6.3, and 7
 *
 * This JavaBean handles the READ and CREATE operations for the movie database project.
 * It connects to the CSD430 database, retrieves movie records, and adds new movie
 * records to the patricemoviesdata table.
 */
public class DbBean implements java.io.Serializable {

    private static final long serialVersionUID = 111222333444L;

    private Connection connection;
    private Statement statement;

    // Constructor: loads the database settings and opens the MySQL connection.
    public DbBean() {

        try {
            Properties properties = new Properties();

            InputStream input = getClass()
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

            if (input == null) {
                throw new Exception("db.properties file was not found.");
            }

            properties.load(input);

            String driver = properties.getProperty("db.driver");
            String url = properties.getProperty("db.url");
            String username = properties.getProperty("db.username");
            String password = properties.getProperty("db.password");

            Class.forName(driver);

            connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
        }
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

        ResultSet resultSet = null;
        StringBuilder dataStringBuilder = new StringBuilder();

        if(statement == null) {
            dataStringBuilder.append("<p style='color:red;'>Database connection was not created.</p>");
            return dataStringBuilder.toString();
        }

        try {
            resultSet = statement.executeQuery(
                "SELECT movie_id FROM patricemoviesdata ORDER BY movie_id"
            );
        }
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error retrieving movie IDs: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }

        dataStringBuilder.append("<form method='post' action='" + requestURL + "'>");
        dataStringBuilder.append("<label for='movie_id'>Select a Movie ID:</label>");
        dataStringBuilder.append("<br /><br />");
        dataStringBuilder.append("<select name='movie_id' id='movie_id'>");

        try {
            while(resultSet != null && resultSet.next()) {
                dataStringBuilder.append("<option value='");
                dataStringBuilder.append(resultSet.getInt("movie_id"));
                dataStringBuilder.append("'>");
                dataStringBuilder.append(resultSet.getInt("movie_id"));
                dataStringBuilder.append("</option>");
            }
        }
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error building dropdown: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }

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
        
        // I added this to have a better understanding of the error 
        // from the past week and prevent the program from crashing.
        if(statement == null) {
            dataStringBuilder.append("<p style='color:red;'>Database connection was not created.</p>");
            return dataStringBuilder.toString();
        }

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

    // Creates one new movie record in the patricemoviesdata table.
    public String createRecord(int movieId, String title, int releaseYear,
                               String genre, String director, int runtime) {

        StringBuilder dataStringBuilder = new StringBuilder();

        if(statement == null) {
            dataStringBuilder.append("<p style='color:red;'>Database connection was not created.</p>");
            return dataStringBuilder.toString();
        }

        try {
            String sql = "INSERT INTO patricemoviesdata " +
                         "(movie_id, title, release_year, genre, director, runtime) " +
                         "VALUES (" + movieId + ", '" + title + "', " + releaseYear + ", '" +
                         genre + "', '" + director + "', " + runtime + ")";

            statement.executeUpdate(sql);

            dataStringBuilder.append("<p><b>Movie record added successfully.</b></p>");
        }
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error adding movie record: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }

        return dataStringBuilder.toString();
    }

    // Builds the HTML form used to add a new movie record.
    public String formGetCreate(String requestURL) {

        StringBuilder dataStringBuilder = new StringBuilder();

        dataStringBuilder.append("<form method='post' action='" + requestURL + "'>");

        dataStringBuilder.append("<label for='movie_id'>Movie ID:</label>");
        dataStringBuilder.append("<br />");
        dataStringBuilder.append("<input type='text' name='movie_id' id='movie_id' required>");
        dataStringBuilder.append("<br /><br />");

        dataStringBuilder.append("<label for='title'>Title:</label>");
        dataStringBuilder.append("<br />");
        dataStringBuilder.append("<input type='text' name='title' id='title' required>");
        dataStringBuilder.append("<br /><br />");

        dataStringBuilder.append("<label for='release_year'>Release Year:</label>");
        dataStringBuilder.append("<br />");
        dataStringBuilder.append("<input type='text' name='release_year' id='release_year' required>");
        dataStringBuilder.append("<br /><br />");

        dataStringBuilder.append("<label for='genre'>Genre:</label>");
        dataStringBuilder.append("<br />");
        dataStringBuilder.append("<input type='text' name='genre' id='genre' required>");
        dataStringBuilder.append("<br /><br />");

        dataStringBuilder.append("<label for='director'>Director:</label>");
        dataStringBuilder.append("<br />");
        dataStringBuilder.append("<input type='text' name='director' id='director' required>");
        dataStringBuilder.append("<br /><br />");

        dataStringBuilder.append("<label for='runtime'>Runtime:</label>");
        dataStringBuilder.append("<br />");
        dataStringBuilder.append("<input type='text' name='runtime' id='runtime' required>");
        dataStringBuilder.append("<br /><br />");

        dataStringBuilder.append("<input type='submit' value='Add Movie'>");

        dataStringBuilder.append("</form>");

        return dataStringBuilder.toString();
    }

    // Reads and displays all movie records after a new record is added.
    public String readAll() {

        StringBuilder dataStringBuilder = new StringBuilder();
        ResultSet resultSet = null;

        if(statement == null) {
            dataStringBuilder.append("<p style='color:red;'>Database connection was not created.</p>");
            return dataStringBuilder.toString();
        }

        try {
            resultSet = statement.executeQuery(
                "SELECT * FROM patricemoviesdata ORDER BY movie_id"
            );
        }
        catch(Exception e) {
            dataStringBuilder.append("<p style='color:red;'>Error reading movie records: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }

        try {
            dataStringBuilder.append("<h2>All Movie Records</h2>");

            dataStringBuilder.append("<p>");
            dataStringBuilder.append("This table displays all movie records currently stored in the CSD430 database.");
            dataStringBuilder.append("</p>");

            dataStringBuilder.append("<h3>Field Descriptions</h3>");
            dataStringBuilder.append("<ul>");
            dataStringBuilder.append("<li><b>Movie ID:</b> Primary key for each movie record.</li>");
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
            dataStringBuilder.append("<p style='color:red;'>Error displaying movie records: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</p>");
            e.printStackTrace();
        }

        return dataStringBuilder.toString();
    }
}
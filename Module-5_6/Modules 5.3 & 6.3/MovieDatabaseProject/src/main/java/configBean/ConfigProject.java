package configBean;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Properties;

/*
 * Patrice Moracchini
 * CSD-430
 * Modules 5.3 and 6.3
 *
 * This JavaBean is used for database setup tasks.
 * It can create, populate, and drop the patricemoviesdata table.
 * The database connection information is stored in db.properties.
 */
public class ConfigProject implements java.io.Serializable {

    private Connection connection;
    private Statement statement;

    // Constructor: loads the database settings and opens the MySQL connection.
    public ConfigProject() {

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

    // Creates the movie table. The old table is dropped first so the setup can be rerun.
    public String createTable() {
        StringBuilder dataStringBuilder = new StringBuilder();
        try {
            statement.executeUpdate("DROP TABLE IF EXISTS patricemoviesdata");
            statement.executeUpdate(
                "CREATE TABLE patricemoviesdata (" +
                "movie_id INT NOT NULL PRIMARY KEY, " +
                "title VARCHAR(100) NOT NULL, " +
                "release_year INT NOT NULL, " +
                "genre VARCHAR(50) NOT NULL, " +
                "director VARCHAR(100) NOT NULL, " +
                "runtime INT NOT NULL)"
            );
            dataStringBuilder.append("<b>Table patricemoviesdata created successfully.</b><br />");
        }
        // Handles SQL errors during table creation.
        catch(Exception e) {
            dataStringBuilder.append("<b>Error creating table: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</b><br />");
            e.printStackTrace();
        }

        return dataStringBuilder.toString();
    }

    // Inserts the 10 movie records required for the assignment.
    public String populateTable() {
        
        StringBuilder dataStringBuilder = new StringBuilder();
        try {
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(1, 'Clue', 1985, 'Comedy Mystery', 'Jonathan Lynn', 94)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(2, 'Tron Ares', 2025, 'Science Fiction', 'Joachim Ronning', 119)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(3, 'Innerspace', 1987, 'Science Fiction Comedy', 'Joe Dante', 120)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(4, 'Parasite', 2019, 'Thriller', 'Bong Joon-ho', 132)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(5, 'The Mummy', 1999, 'Adventure', 'Stephen Sommers', 124)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(6, 'Back to the Future', 1985, 'Science Fiction', 'Robert Zemeckis', 116)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(7, 'Jumpin'' Jack Flash', 1986, 'Comedy', 'Penny Marshall', 105)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(8, 'The Matrix', 1999, 'Science Fiction', 'The Wachowskis', 136)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(9, 'Ghostbusters', 1984, 'Comedy', 'Ivan Reitman', 105)");
            statement.executeUpdate("INSERT INTO patricemoviesdata VALUES(10, 'Jaws', 1975, 'Thriller', 'Steven Spielberg', 124)");

            dataStringBuilder.append("<b>Table patricemoviesdata populated successfully.</b><br />");
        }
        // Handles SQL errors during data insertion.
        catch(Exception e) {
            dataStringBuilder.append("<b>Error populating table: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</b><br />");
            e.printStackTrace();
        }

        return dataStringBuilder.toString();
    }

    // Drops the table. This is useful for resetting the project during testing.
    public String dropTable() {

        StringBuilder dataStringBuilder = new StringBuilder();
        try {
            statement.executeUpdate("DROP TABLE IF EXISTS patricemoviesdata");

            dataStringBuilder.append("<b>Table patricemoviesdata dropped successfully.</b><br />");
        }
        // Handles SQL errors during table dropping.
        catch(Exception e) {
            dataStringBuilder.append("<b>Error dropping table: ");
            dataStringBuilder.append(e.getMessage());
            dataStringBuilder.append("</b><br />");
            e.printStackTrace();
        }

        return dataStringBuilder.toString();
    }
}
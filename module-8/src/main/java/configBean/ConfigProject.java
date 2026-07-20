package configBean;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Properties;

/*
 * Patrice Moracchini
 * CSD-430
 * Modules 5, 6, 7, and 8
 *
 * This JavaBean performs the database setup operations. It creates,
 * populates, and drops the patricemoviesdata table. Database connection
 * information is read from db.properties.
 */
public class ConfigProject implements Serializable {

    private static final long serialVersionUID = 555666777888L;

    // Public no-argument constructor.
    public ConfigProject() {
    }

    /*
     * Reads db.properties and returns a new database connection.
     * Each public database method closes its connection automatically.
     */
    private Connection openConnection() throws Exception {

        Properties properties = new Properties();

        try (InputStream input = getClass()
                .getClassLoader()
                .getResourceAsStream("db.properties")) {

            if(input == null) {
                throw new Exception("db.properties file was not found.");
            }

            properties.load(input);
        }

        String driver = properties.getProperty("db.driver");
        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");

        Class.forName(driver);

        return DriverManager.getConnection(url, username, password);
    }

    /*
     * Drops an existing movie table and creates a new empty table.
     * The connection and statement close automatically when finished.
     */
    public String createTable() {

        String dropSql = "DROP TABLE IF EXISTS patricemoviesdata";

        String createSql =
            "CREATE TABLE patricemoviesdata (" +
            "movie_id INT NOT NULL PRIMARY KEY, " +
            "title VARCHAR(100) NOT NULL, " +
            "release_year INT NOT NULL, " +
            "genre VARCHAR(50) NOT NULL, " +
            "director VARCHAR(100) NOT NULL, " +
            "runtime INT NOT NULL)";

        try (Connection connection = openConnection();
             Statement statement = connection.createStatement()) {

            statement.executeUpdate(dropSql);
            statement.executeUpdate(createSql);

            return "Table patricemoviesdata created successfully.";
        }
        catch(Exception e) {
            System.out.println("Error creating the movie table.");
            e.printStackTrace();
            return "The movie table could not be created.";
        }
    }

    /*
     * Inserts the ten original movie records into the database table.
     * The connection and statement close automatically when finished.
     */
    public String populateTable() {

        String sql =
            "INSERT INTO patricemoviesdata " +
            "(movie_id, title, release_year, genre, director, runtime) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = openConnection()) {

            // Treats all ten inserts as one database transaction.
            connection.setAutoCommit(false);

            try (PreparedStatement statement =
                    connection.prepareStatement(sql)) {

                statement.setInt(1, 1);
                statement.setString(2, "Clue");
                statement.setInt(3, 1985);
                statement.setString(4, "Comedy Mystery");
                statement.setString(5, "Jonathan Lynn");
                statement.setInt(6, 94);
                statement.addBatch();

                statement.setInt(1, 2);
                statement.setString(2, "Tron Ares");
                statement.setInt(3, 2025);
                statement.setString(4, "Science Fiction");
                statement.setString(5, "Joachim Ronning");
                statement.setInt(6, 119);
                statement.addBatch();

                statement.setInt(1, 3);
                statement.setString(2, "Innerspace");
                statement.setInt(3, 1987);
                statement.setString(4, "Science Fiction Comedy");
                statement.setString(5, "Joe Dante");
                statement.setInt(6, 120);
                statement.addBatch();

                statement.setInt(1, 4);
                statement.setString(2, "Parasite");
                statement.setInt(3, 2019);
                statement.setString(4, "Thriller");
                statement.setString(5, "Bong Joon-ho");
                statement.setInt(6, 132);
                statement.addBatch();

                statement.setInt(1, 5);
                statement.setString(2, "The Mummy");
                statement.setInt(3, 1999);
                statement.setString(4, "Adventure");
                statement.setString(5, "Stephen Sommers");
                statement.setInt(6, 124);
                statement.addBatch();

                statement.setInt(1, 6);
                statement.setString(2, "Back to the Future");
                statement.setInt(3, 1985);
                statement.setString(4, "Science Fiction");
                statement.setString(5, "Robert Zemeckis");
                statement.setInt(6, 116);
                statement.addBatch();

                statement.setInt(1, 7);
                statement.setString(2, "Jumpin' Jack Flash");
                statement.setInt(3, 1986);
                statement.setString(4, "Comedy");
                statement.setString(5, "Penny Marshall");
                statement.setInt(6, 105);
                statement.addBatch();

                statement.setInt(1, 8);
                statement.setString(2, "The Matrix");
                statement.setInt(3, 1999);
                statement.setString(4, "Science Fiction");
                statement.setString(5, "The Wachowskis");
                statement.setInt(6, 136);
                statement.addBatch();

                statement.setInt(1, 9);
                statement.setString(2, "Ghostbusters");
                statement.setInt(3, 1984);
                statement.setString(4, "Comedy");
                statement.setString(5, "Ivan Reitman");
                statement.setInt(6, 105);
                statement.addBatch();

                statement.setInt(1, 10);
                statement.setString(2, "Jaws");
                statement.setInt(3, 1975);
                statement.setString(4, "Thriller");
                statement.setString(5, "Steven Spielberg");
                statement.setInt(6, 124);
                statement.addBatch();

                // Executes every prepared INSERT and saves the transaction.
                statement.executeBatch();
                connection.commit();

                return "Table patricemoviesdata populated successfully.";
            }
            catch(Exception e) {
                // Cancels every insert if any record fails.
                connection.rollback();
                throw e;
            }
        }
        catch(Exception e) {
            System.out.println("Error populating the movie table.");
            e.printStackTrace();
            return "The movie table could not be populated.";
        }
    }

    /*
     * Drops the movie table when the project database needs to be reset.
     * The returned message contains no HTML formatting.
     */
    public String dropTable() {

        String sql = "DROP TABLE IF EXISTS patricemoviesdata";

        try (Connection connection = openConnection();
             Statement statement = connection.createStatement()) {

            statement.executeUpdate(sql);

            return "Table patricemoviesdata dropped successfully.";
        }
        catch(Exception e) {
            System.out.println("Error dropping the movie table.");
            e.printStackTrace();
            return "The movie table could not be dropped.";
        }
    }
}

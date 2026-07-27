package database;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;

/*
 * Patrice Moracchini
 * CSD-430
 * Modules 5.3, 6.3, 7, 8 and 9
 *
 * This JavaBean handles the READ, CREATE, UPDATE and DELETE database operations
 * for the movie database project.
 */
public class DbBean implements Serializable {

    private static final long serialVersionUID = 111222333444L;

    // Private JavaBean properties for one movie record.
    private int movieId;
    private String title;
    private int releaseYear;
    private String genre;
    private String director;
    private int runtime;

    // Public no-argument constructor required for a JavaBean.
    public DbBean() {
    }

    // Getter and setter for movieId.
    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    // Getter and setter for title.
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    // Getter and setter for releaseYear.
    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    // Getter and setter for genre.
    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    // Getter and setter for director.
    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    // Getter and setter for runtime.
    public int getRuntime() {
        return runtime;
    }

    public void setRuntime(int runtime) {
        this.runtime = runtime;
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

    // Retrieves the movie_id values used by the HTML dropdown in the JSP.
    public ArrayList<Integer> getMovieIds() {

        ArrayList<Integer> movieIds = new ArrayList<Integer>();

        String sql =
            "SELECT movie_id FROM patricemoviesdata ORDER BY movie_id";

        try (Connection connection = openConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while(resultSet.next()) {
                movieIds.add(resultSet.getInt("movie_id"));
            }
        }
        catch(Exception e) {
            System.out.println("Error retrieving movie IDs.");
            e.printStackTrace();
        }

        return movieIds;
    }

    // Loads one selected movie into the JavaBean properties.
    public boolean loadMovie(int selectedMovieId) {

        String sql =
            "SELECT movie_id, title, release_year, genre, director, runtime " +
            "FROM patricemoviesdata WHERE movie_id = ?";

        try (Connection connection = openConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, selectedMovieId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if(resultSet.next()) {
                    setMovieId(resultSet.getInt("movie_id"));
                    setTitle(resultSet.getString("title"));
                    setReleaseYear(resultSet.getInt("release_year"));
                    setGenre(resultSet.getString("genre"));
                    setDirector(resultSet.getString("director"));
                    setRuntime(resultSet.getInt("runtime"));
                    return true;
                }
            }
        }
        catch(Exception e) {
            System.out.println("Error loading the selected movie record.");
            e.printStackTrace();
        }

        return false;
    }

    // Creates one movie using the values stored in the JavaBean properties.
    public boolean createRecord() {

        String sql =
            "INSERT INTO patricemoviesdata " +
            "(movie_id, title, release_year, genre, director, runtime) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = openConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, getMovieId());
            preparedStatement.setString(2, getTitle());
            preparedStatement.setInt(3, getReleaseYear());
            preparedStatement.setString(4, getGenre());
            preparedStatement.setString(5, getDirector());
            preparedStatement.setInt(6, getRuntime());

            return preparedStatement.executeUpdate() == 1;
        }
        catch(Exception e) {
            System.out.println("Error creating the movie record.");
            e.printStackTrace();
        }

        return false;
    }


     //Retrieves all movie data for the JSP table. 
     // Returns an ArrayList of String arrays, where each String array represents a movie record.
    public ArrayList<String[]> getAllRecords() {

        ArrayList<String[]> records = new ArrayList<String[]>();

        String sql =
            "SELECT movie_id, title, release_year, genre, director, runtime " +
            "FROM patricemoviesdata ORDER BY movie_id";

        try (Connection connection = openConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while(resultSet.next()) {
                String[] record = {
                    Integer.toString(resultSet.getInt("movie_id")),
                    resultSet.getString("title"),
                    Integer.toString(resultSet.getInt("release_year")),
                    resultSet.getString("genre"),
                    resultSet.getString("director"),
                    Integer.toString(resultSet.getInt("runtime"))
                };

                records.add(record);
            }
        }
        catch(Exception e) {
            System.out.println("Error retrieving all movie records.");
            e.printStackTrace();
        }

        return records;
    }

    // Updates the selected movie using the JavaBean property values.
    public boolean updateRecord() {

        String sql =
            "UPDATE patricemoviesdata " +
            "SET title = ?, release_year = ?, genre = ?, director = ?, " +
            "runtime = ? WHERE movie_id = ?";

        try (Connection connection = openConnection();
             PreparedStatement preparedStatement =
                     connection.prepareStatement(sql)) {

            preparedStatement.setString(1, getTitle());
            preparedStatement.setInt(2, getReleaseYear());
            preparedStatement.setString(3, getGenre());
            preparedStatement.setString(4, getDirector());
            preparedStatement.setInt(5, getRuntime());
            preparedStatement.setInt(6, getMovieId());

            return preparedStatement.executeUpdate() == 1;
        }
        catch(Exception e) {
            System.out.println("Error updating the selected movie record.");
            e.printStackTrace();
        }

        return false;
    }
    // Delete the selected movie using the movie_id
    public boolean deleteRecord(int selectedMovie_Id) {
    	
    	String sql =
    			"DELETE FROM patricemoviesdata WHERE movie_id = ?";
    	
    	try (Connection connection = openConnection();
    			PreparedStatement preparedStatement =
    					connection.prepareStatement(sql)) {
    		
    		preparedStatement.setInt(1, selectedMovie_Id);
    		
    		return preparedStatement.executeUpdate() ==1;
    	}
    	catch(Exception e) {
    		System.out.println("Error when deleting the selected movie record.");
    		e.printStackTrace();
    		
    	}
    	
    	return false;	
    }
    
}

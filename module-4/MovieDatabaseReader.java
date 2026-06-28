package beans;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

/**
 * Patrice Moracchini
 * CSD-430
 * Assignment 4.2
 *
 * This class is responsible for reading movie records from the MySQL database.
 * The JSP page uses this class to keep the database connection code out of the JSP file.
 * This helps separate the display page from the database logic.
 */
public class MovieDatabaseReader {
	
	// This method reads the database connection information from db.properties.
	// It then uses that information to open a connection to the MySQL database.
	private Connection getConnection() throws Exception {
		Properties properties = new Properties();
		
		// This line looks for the db.properties file in the project resources.
		InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties");
		
		// This line loads the database settings from the properties file.
		properties.load(input);
		
		String url = properties.getProperty("db.url");
		String username = properties.getProperty("db.username");
		String password = properties.getProperty("db.password");
		
		// This line loads the MySQL driver so Java can communicate with MySQL.
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// This line opens and returns the database connection.
		return DriverManager.getConnection(url, username, password);
	}
	
	// This method is the Read part of CRUD.
	// It runs a SELECT statement and returns all movie records from the movies table.
	public ArrayList<MovieBean> getAllMovies() {
		// This ArrayList will hold all MovieBean objects retrieved from the database.
		ArrayList<MovieBean> movies = new ArrayList<>();
		
		// This SQL statement selects the movie fields needed for the web page table.
		String sql = "SELECT movie_id, title, release_year, genre, director, runtime FROM movies";
		
		try {
			Connection connection = getConnection();
			Statement statement = connection.createStatement();
			// This runs the SELECT statement and stores the results.
			ResultSet resultSet = statement.executeQuery(sql);
			
			// This loop reads one database row at a time.
			while (resultSet.next()) {
				MovieBean movie = new MovieBean();
				
				// Each database row is stored inside one MovieBean object.
				movie.setMovieId(resultSet.getInt("movie_id"));
				movie.setTitle(resultSet.getString("title"));
				movie.setReleaseYear(resultSet.getInt("release_year"));
				movie.setGenre(resultSet.getString("genre"));
				movie.setDirector(resultSet.getString("director"));
				movie.setRuntime(resultSet.getInt("runtime"));
				
				// Adds the completed movie object to the list.
				movies.add(movie);
			}
			
			// Close the database resources after the data has been read.
			resultSet.close();
			statement.close();
			connection.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Returns the completed list of movie records to the JSP page.
		return movies;
	}
}

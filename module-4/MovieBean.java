package beans;

import java.io.Serializable;

/**
 * Patrice Moracchini
 * CSD-430
 * Assignment 4.2
 *
 * This JavaBean stores one movie record retrieved from the database.
 * Each field represents one column from the movies table.
 */
public class MovieBean implements Serializable {
	
	// These fields store the movie record categories retrieved from the database.
	private int movieId;
	private String title;
	private int releaseYear;
	private String genre;
	private String director;
	private int runtime;
	
	// Default constructor required for a JavaBean.
	public MovieBean() {
	}
	
	// This constructor creates a movie object with all field values.
	public MovieBean(int movieId, String title, int releaseYear, String genre, String director, int runtime) {
		this.movieId = movieId;
		this.title = title;
		this.releaseYear = releaseYear;
		this.genre = genre;
		this.director = director;
		this.runtime = runtime;
	}
	
	// This is one getter method. It returns the movie ID value.
	public int getMovieId() {
		// Return sends the stored value back to the code that requested it.
		return movieId;
	}
	
	// This is one setter method. It changes the movie ID value.
	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public int getReleaseYear() {
		return releaseYear;
	}
	
	public void setReleaseYear(int releaseYear) {
		this.releaseYear = releaseYear;
	}
	
	public String getGenre() {
		return genre;
	}
	
	public void setGenre(String genre) {
		this.genre = genre;
	}
	
	public String getDirector() {
		return director;
	}
	
	public void setDirector(String director) {
		this.director = director;
	}
	
	public int getRuntime() {
		return runtime;
	}
	
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
}

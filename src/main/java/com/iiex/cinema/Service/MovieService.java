package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Movie;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MovieService {
    List<Movie> finAllMovies();

    Movie finMovieByID(Long ID);

    Movie  saveMovie(Movie movie);

    List<Movie> findAllIsOnGoing();
    List<Movie> findAllUpcoming();
    List<Movie> getMovieTrailer();


    void delete(Long ID);
}

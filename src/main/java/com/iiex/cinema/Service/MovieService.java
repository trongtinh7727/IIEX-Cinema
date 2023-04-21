package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Movie;
import org.springframework.stereotype.Service;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.List;

@Service
public interface MovieService {
    List<Movie> finAllMovies();

    Movie finMovieByID(Long ID);

    Movie  saveMovie(Movie movie);

    List<Movie> findAllIsOnGoing();
    void delete(Long ID);
}

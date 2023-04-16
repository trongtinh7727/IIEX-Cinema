package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Movie;

import java.util.List;

public interface MovieService {
    List<Movie> finAllMovies();

    Movie finMovieByID(Long ID);

    Movie  saveMovie(Movie movie);
}

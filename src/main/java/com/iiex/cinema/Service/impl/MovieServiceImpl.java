package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Repository.MovieRepository;
import com.iiex.cinema.Service.MovieService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovieServiceImpl implements MovieService {

    private MovieRepository movieRepository;
    @Override
    public List<Movie> finAllMovies() {
        return movieRepository.findAll();
    }

    @Override
    public Movie finMovieByID(Long ID) {
        return  movieRepository.findById(ID).get();
    }

    @Override
    public Movie saveMovie(Movie movie) {
        movieRepository.save(movie);
        return  movie;
    }
}

package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Repository.MovieRepository;
import com.iiex.cinema.Service.MovieService;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Service;

@Service
public class MovieServiceImpl implements MovieService {

  @Autowired
  private MovieRepository movieRepository;

  @Override
  public List<Movie> finAllMovies() {
    return movieRepository.findAll();
  }

  @Override
  public Movie finMovieByID(Long ID) {
    return movieRepository.findById(ID).get();
  }

  @Override
  public Movie saveMovie(Movie movie) {
    movieRepository.save(movie);
    return movie;
  }

  @Override
  public List<Movie> findAllIsOnGoing() {
    return  movieRepository.findCurrentlyShowingMovies();
  }

  @Override
  public List<Movie> findAllUpcoming() {
    return movieRepository.findUpcomingMovies();
  }

  @Override
  public List<Movie> getMovieTrailer() {
    return movieRepository.getMovieTrailer();
  }

  @Override
  public void delete(Long ID) {
    movieRepository.deleteById(ID);
  }
}

package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/movies")
public class MovieController {
    @Autowired
    MovieService movieService;

    MovieController(MovieService movieService){
        this.movieService = movieService;
    }

    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<Movie> movies = movieService.finAllMovies();
        CustomResponse<Movie> response = new CustomResponse(true, movies);
        return ResponseEntity.ok(response);
    }
    @GetMapping("/ongoing")
    ResponseEntity<CustomResponse> allOngoing() {
        List<Movie> movies = movieService.findAllIsOnGoing();
        CustomResponse<Movie> response = new CustomResponse(true, movies);
        return ResponseEntity.ok(response);
    }
    @GetMapping("/upcoming")
    ResponseEntity<CustomResponse> allUpcoming() {
        List<Movie> movies = movieService.findAllUpcoming();
        CustomResponse<Movie> response = new CustomResponse(true, movies);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> newMovie(@RequestBody Movie newMovie) {
        movieService.saveMovie(newMovie);
        CustomResponse<Movie> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    Movie one(@PathVariable Long id) {
        return movieService.finMovieByID(id);
    }

    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> replaceEmployee(@RequestBody Movie newMovie, @PathVariable Long id) {
        Movie movie = movieService.finMovieByID(id);
        movie.setActors(newMovie.getActors());
        movie.setDirector(newMovie.getDirector());
        movie.setGenre(newMovie.getGenre());
        movie.setDuration(newMovie.getDuration());
        movie.setPoster(newMovie.getPoster());
        movie.setStory(newMovie.getStory());
        movie.setTitle(newMovie.getTitle());
        movie.setTrailer(newMovie.getTrailer());
        movie.setOpening_day(newMovie.getOpening_day());
        movie.setClosing_day(newMovie.getClosing_day());
        movie.setRating(newMovie.getRating());
        movieService.saveMovie(movie);
        CustomResponse<Movie> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        movieService.delete(id);
        CustomResponse<Movie> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }

}

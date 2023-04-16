package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("")
    Movie newMovie(@RequestBody Movie newMovie) {
        return movieService.saveMovie(newMovie);
    }

    @GetMapping("/employees/{id}")
    Movie one(@PathVariable Long id) {
        return movieService.finMovieByID(id);
    }
}

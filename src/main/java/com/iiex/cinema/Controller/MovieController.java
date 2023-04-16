package com.iiex.cinema.Controller;

import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
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
    List<Movie> all() {
        return movieService.finAllMovies();
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

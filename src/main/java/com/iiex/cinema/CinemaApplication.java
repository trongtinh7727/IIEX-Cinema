package com.iiex.cinema;

import com.iiex.cinema.Service.MovieService;
import com.iiex.cinema.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class CinemaApplication implements CommandLineRunner {
    @Autowired
    private MovieService movieService;

    @Autowired
    private ProductService productService;

    public static void main(String[] args) {
        SpringApplication.run(CinemaApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        movieService.finAllMovies().forEach(p-> System.out.println(p.getId()));
        System.out.println(productService.findAllProduct().size());
    }
}

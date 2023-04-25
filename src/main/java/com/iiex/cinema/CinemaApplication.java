package com.iiex.cinema;

import com.iiex.cinema.Service.MovieService;
import com.iiex.cinema.Service.ScheduleService;
import com.iiex.cinema.Service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class CinemaApplication implements CommandLineRunner {
    @Autowired
    private MovieService movieService;

    @Autowired
    private ScheduleService scheduleService;
    @Autowired
    private TheaterService theaterService;
    public static void main(String[] args) {
        SpringApplication.run(CinemaApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
//        movieService.finAllMovies().forEach(p -> System.out.println(p.getClosing_day()));
//        scheduleService.findAllScheduleByTheater(theaterService.findTheaterByID(Long.valueOf(2))).forEach(p-> System.out.println(p.getTitle()));
    }
}

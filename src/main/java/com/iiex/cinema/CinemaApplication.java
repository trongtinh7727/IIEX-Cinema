package com.iiex.cinema;

import com.iiex.cinema.Model.Role;
import com.iiex.cinema.Repository.RoleRepository;
import com.iiex.cinema.Repository.UserRepository;
import com.iiex.cinema.Service.MovieService;
import com.iiex.cinema.Service.ScheduleService;
import com.iiex.cinema.Service.TheaterService;
import com.iiex.cinema.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class CinemaApplication implements CommandLineRunner {
    @Autowired
    private MovieService movieService;
    @Autowired
    private UserService userService;
    @Autowired
    private ScheduleService scheduleService;
    @Autowired
    private TheaterService theaterService;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private UserRepository userRepository;

    public static void main(String[] args) {
        SpringApplication.run(CinemaApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
//        movieService.finAllMovies().forEach(p -> System.out.println(p.getClosing_day()));
//        scheduleService.findAllScheduleByTheater(theaterService.findTheaterByID(Long.valueOf(2))).forEach(p-> System.out.println(p.getTitle()));
//        System.out.println(userService.findById(1l/));
//        userService.findAllUsers()

//        userService.findAllUsers().forEach(p->System.out.println(p.getEmail()));
        userRepository.findAll().forEach(p-> System.out.println(p.getRoles().size()));
    }

}

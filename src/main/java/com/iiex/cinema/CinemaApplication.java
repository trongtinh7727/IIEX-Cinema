package com.iiex.cinema;

import com.iiex.cinema.Repository.RoleRepository;
import com.iiex.cinema.Repository.UserRepository;
import com.iiex.cinema.Service.MovieService;
import com.iiex.cinema.Service.ScheduleService;
import com.iiex.cinema.Service.ShowroomService;
import com.iiex.cinema.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class CinemaApplication implements CommandLineRunner {


    public static void main(String[] args) {
        SpringApplication.run(CinemaApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {

    }

}

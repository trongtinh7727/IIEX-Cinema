package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Model.Theater;
import com.iiex.cinema.Repository.TheaterRepository;
import com.iiex.cinema.Service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TheaterServiceImpl implements TheaterService {
    @Autowired
    private TheaterRepository theaterRepository;

    @Override
    public List<Theater> findAllTheater() {
        return theaterRepository.findAll();
    }

    @Override
    public Theater findTheaterByID(Long ID) {
        return  theaterRepository.findById(ID).get();
    }

    @Override
    public Theater saveTheater(Theater movie) {
        theaterRepository.save(movie);
        return  movie;
    }
    @Override
    public void delete(Long ID) {
        theaterRepository.deleteById(ID);
    }
}

package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;
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
    public List<ShowRoom> findAllTheater() {
        return theaterRepository.findAll();
    }

    @Override
    public ShowRoom findTheaterByID(Long ID) {
        return  theaterRepository.findById(ID).get();
    }

    @Override
    public ShowRoom saveTheater(ShowRoom movie) {
        theaterRepository.save(movie);
        return  movie;
    }
    @Override
    public void delete(Long ID) {
        theaterRepository.deleteById(ID);
    }

    @Override
    public List<ShowRoom> findAllByCinema(Cinema cinema) {
        return theaterRepository.findAllByCinema(cinema);
    }
}

package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Repository.CinemaRepository;
import com.iiex.cinema.Service.CinemaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CinemaServiceImpl implements CinemaService {
    @Autowired
    private CinemaRepository cinemaRepository;

    @Override
    public List<Cinema> findAll() {
        return cinemaRepository.findAll();
    }

    @Override
    public Cinema findCinemaByID(Long ID) {
        return cinemaRepository.findCinemaById(ID);
    }

    @Override
    public Cinema saveCinema(Cinema cinema) {
        return cinemaRepository.save(cinema);
    }

    @Override
    public void delete(Long id) {
        cinemaRepository.deleteById(id);
    }
}

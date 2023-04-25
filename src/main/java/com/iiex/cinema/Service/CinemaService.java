package com.iiex.cinema.Service;


import com.iiex.cinema.Model.Cinema;

import java.util.List;

public interface CinemaService {
    List<Cinema> findAll();
    Cinema findCinemaByID(Long ID);
    Cinema  saveCinema(Cinema movie);
    void delete(Long id);

}

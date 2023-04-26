package com.iiex.cinema.Service;


import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;

import java.util.List;

public interface TheaterService {
    List<ShowRoom> findAllTheater();

    ShowRoom findTheaterByID(Long ID);

    ShowRoom saveTheater(ShowRoom movie);

    void delete(Long id);

    List<ShowRoom> findAllByCinema(Cinema cinema);
}

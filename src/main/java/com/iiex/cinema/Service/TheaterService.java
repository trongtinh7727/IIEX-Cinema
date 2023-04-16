package com.iiex.cinema.Service;


import com.iiex.cinema.Model.Product;
import com.iiex.cinema.Model.Theater;

import java.util.List;

public interface TheaterService {
    List<Theater> findAllTheater();

    Theater findTheaterByID(Long ID);

    Theater  saveTheater(Theater movie);

    void delete(Long id);
}

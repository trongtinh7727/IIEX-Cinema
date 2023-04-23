package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Seat;
import com.iiex.cinema.Model.Theater;

import java.util.List;

public interface SeatService {
    List<Seat> getByTheater(Theater theater);
}

package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Seat;
import com.iiex.cinema.Model.ShowRoom;

import java.util.Collection;
import java.util.List;

public interface SeatService {
    List<Seat> getByShowRoom(ShowRoom showRoom);

    List<Seat> generateSeat(ShowRoom showRoom);
}

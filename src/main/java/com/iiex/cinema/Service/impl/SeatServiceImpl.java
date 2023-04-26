package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Seat;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Repository.SeatRepository;
import com.iiex.cinema.Service.SeatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Service
public class SeatServiceImpl implements SeatService {
    @Autowired
    private SeatRepository seatRepository;
    @Override
    public List<Seat> getByShowRoom(ShowRoom showRoom) {
        return  showRoom.getSeats();
    }

}

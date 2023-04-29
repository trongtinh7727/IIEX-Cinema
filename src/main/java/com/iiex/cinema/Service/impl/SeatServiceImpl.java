package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Seat;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Repository.SeatRepository;
import com.iiex.cinema.Service.SeatService;
import com.iiex.cinema.Service.ShowroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class SeatServiceImpl implements SeatService {
    @Autowired
    private SeatRepository seatRepository;
    @Autowired
    private ShowroomService showroomService;
    @Override
    public List<Seat> getByShowRoom(ShowRoom showRoom) {
        return  showRoom.getSeats();
    }

    @Override
    public Seat getByShowRoomAndSeatNumber(ShowRoom showRoom, String seatNumber) {

        return seatRepository.findBySeatNumberAndAndShowRoom(seatNumber,showRoom);
    }

    @Override
    public List<Seat> generateSeat(ShowRoom showRoom) {
        List<Seat> seats = new ArrayList<>();
        for (char j = 'A'; j <= 'H'; j++) {
            for (int i = 1; i <= 10; i++) {
                Seat seat = new Seat(0,j+(String.valueOf(i)),"Standard",showRoom,null);
                seatRepository.save(seat);
                seats.add(seat);
            }
        }
        for (char j = 'I'; j <= 'J'; j++) {
            for (int i = 1; i <= 5; i++) {
                Seat seat = new Seat(0,j+(String.valueOf(i)),"Couple",showRoom,null);
                seatRepository.save(seat);
                seats.add(seat);
            }
        }
        return  seats;
    }


}

package com.iiex.cinema.Service;


import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;

import java.util.List;

public interface  ShowroomService {
    List<ShowRoom> findAllTheater();
    ShowRoom findShowroomByID(Long ID);
    ShowRoom saveShowroom(ShowRoom showRoom);
    void delete(Long id);
    List<ShowRoom> findAllByCinema(Long id);
}

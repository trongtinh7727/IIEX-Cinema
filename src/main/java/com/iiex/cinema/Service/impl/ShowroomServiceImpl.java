package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Repository.CinemaRepository;
import com.iiex.cinema.Repository.ShowroomRepository;
import com.iiex.cinema.Service.ShowroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShowroomServiceImpl implements ShowroomService {
    @Autowired
    private ShowroomRepository showroomRepository;
    @Autowired
    private CinemaRepository cinemaRepository;

    @Override
    public List<ShowRoom> findAllTheater() {
        return showroomRepository.findAll();
    }

    @Override
    public ShowRoom findShowroomByID(Long ID) {
        return showroomRepository.findById(ID).get();
    }

    @Override
    public ShowRoom saveShowroom(ShowRoom showRoom) {

        return showroomRepository.save(showRoom);
    }


    @Override
    public void delete(Long id) {
        showroomRepository.deleteById(id);
    }


    @Override
    public List<ShowRoom> findAllByCinema(Long id) {
        return showroomRepository.findAllByCinema(cinemaRepository.findCinemaById(id));
    }
}

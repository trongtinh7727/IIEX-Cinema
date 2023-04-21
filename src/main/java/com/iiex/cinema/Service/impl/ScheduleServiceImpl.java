package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.Theater;
import com.iiex.cinema.Repository.ProductRepository;
import com.iiex.cinema.Repository.ScheduleRepository;
import com.iiex.cinema.Service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;
    @Override
    public List<Schedule> findAllSchedule() {
        return scheduleRepository.findAll();
    }
    @Override
    public Schedule findScheduleByID(Long ID) {
        return scheduleRepository.findById(ID).get();
    }

    @Override
    public Schedule saveSchedule(Schedule schedule) {
        return scheduleRepository.save(schedule);
    }
    @Override
    public void delete(Long id) {
        scheduleRepository.deleteById(id);
    }

    @Override
    public List<Schedule> findAllScheduleByTheater(Theater theater) {
        return scheduleRepository.findAllByTheater(theater);
    }
}

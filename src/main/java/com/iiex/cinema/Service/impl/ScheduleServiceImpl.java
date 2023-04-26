package com.iiex.cinema.Service.impl;

import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Repository.ScheduleRepository;
import com.iiex.cinema.Service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;
    @Override
    public List<ScheduleDTO> findAllSchedule() {
        List<ScheduleDTO> scheduleDTOS = new ArrayList<>();
        List<Schedule> schedules =  scheduleRepository.findAll();
        for (Schedule schedule:schedules) {
            Movie movie = schedule.getMovie();
            ShowRoom showRoom = schedule.getShowRoom();
            scheduleDTOS.add(new ScheduleDTO(schedule.getId(),movie.getTitle(),movie.getDuration(),schedule.getStartTime(), schedule.getEndTime()));
        }
        return scheduleDTOS;
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
    public List<ScheduleDTO> findAllScheduleByTheater(ShowRoom showRoom) {
//        return scheduleRepository.findAllByTheater(showRoom);
        return  null;
    }
}

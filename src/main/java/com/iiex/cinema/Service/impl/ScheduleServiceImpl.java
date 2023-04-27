package com.iiex.cinema.Service.impl;

import com.iiex.cinema.DTO.ScheduleByShowroomDTO;
import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.*;
import com.iiex.cinema.Repository.ScheduleRepository;
import com.iiex.cinema.Repository.TicketRepository;
import com.iiex.cinema.Service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private TicketRepository ticketRepository;

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
        System.out.println("----------------------------------");
        System.out.println(id);
        scheduleRepository.deleteById(id);
    }

//    admin schedule
    @Override
    public List<ScheduleByShowroomDTO> findAllScheduleByShowRom(Long id) {
        List<ScheduleByShowroomDTO> scheduleByShowroomDTOS = new ArrayList<>();
        List<Schedule> schedules = scheduleRepository.findAllByShowRoom_Id(id);
        for (Schedule schedule :
                schedules ) {
            Movie movie = schedule.getMovie();
            ShowRoom showRoom = schedule.getShowRoom();
            List<Seat> seats = showRoom.getSeats();
            int emptySeat = ticketRepository.countAllByBookingIsNullAndSchedule_Id(schedule.getId());
            scheduleByShowroomDTOS.add(
                    new ScheduleByShowroomDTO( movie.getTitle(),movie.getDuration(),schedule.getId(),
                            movie.getId(), showRoom.getId(), schedule.getStartTime(), schedule.getEndTime(),showRoom.getSeat_count(), emptySeat)
            );
        }
        return  scheduleByShowroomDTOS;
    }
}

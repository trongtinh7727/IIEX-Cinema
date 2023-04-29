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
    public ScheduleDTO findScheduleByID(Long ID) {
        Schedule schedule =  scheduleRepository.findById(ID).get();
        ScheduleDTO scheduleDTO = new ScheduleDTO(schedule.getId(), schedule.getMovie().getTitle(), schedule.getMovie().getDuration(), schedule.getStartTime(), schedule.getEndTime(),
                schedule.getPrice(), schedule.getMovie().getId(), schedule.getShowRoom().getId());
        return scheduleDTO;
    }

    @Override
    public Schedule finSchedule(Long ID) {
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
    public List<String> getBookedSeat(long id) {
        List<String> seats = new ArrayList<>();
        Schedule schedule = scheduleRepository.findById(id).get();
        List<Ticket> tickets = (List<Ticket>) schedule.getTickets();
        for (Ticket ticket :
                tickets) {
            if (ticket.getBooking() != null) {
                seats.add(ticket.getSeat().getSeatNumber());
            }
        }
        return seats;
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
                            movie.getId(), showRoom.getId(), schedule.getStartTime(), schedule.getEndTime(),showRoom.getSeat_count(), emptySeat, schedule.getPrice())
            );
        }
        return  scheduleByShowroomDTOS;
    }

    @Override
    public List<ScheduleByShowroomDTO> findAllScheduleByShowRomAndMovie(Long showroomID, Long movieID) {
        List<ScheduleByShowroomDTO> scheduleByShowroomDTOS = new ArrayList<>();
        List<Schedule> schedules = scheduleRepository.findAllByShowRoom_Id(showroomID);
        for (Schedule schedule :
                schedules ) {
            Movie movie = schedule.getMovie();
            if (movie.getId() != movieID) {
                continue;
            }else {
                ShowRoom showRoom = schedule.getShowRoom();
                List<Seat> seats = showRoom.getSeats();
                int emptySeat = ticketRepository.countAllByBookingIsNullAndSchedule_Id(schedule.getId());
                scheduleByShowroomDTOS.add(
                        new ScheduleByShowroomDTO( movie.getTitle(),movie.getDuration(),schedule.getId(),
                                movie.getId(), showRoom.getId(), schedule.getStartTime(), schedule.getEndTime(),showRoom.getSeat_count(), emptySeat, schedule.getPrice())
                );
            }
        }
        return  scheduleByShowroomDTOS;
    }
}

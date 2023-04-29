package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.Seat;
import com.iiex.cinema.Model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    int countAllByBookingIsNullAndSchedule_Id(Long ID);

    Ticket findByScheduleAndSeat(Schedule schedule, Seat seat);


}

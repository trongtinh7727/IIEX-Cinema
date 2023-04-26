package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.Ticket;

import java.util.List;

public interface TicketService {
    List<Ticket> generateTicket(Schedule schedule, float price);
}

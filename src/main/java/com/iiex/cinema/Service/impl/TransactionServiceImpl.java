package com.iiex.cinema.Service.impl;

import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.TransactionDTO;
import com.iiex.cinema.Model.*;
import com.iiex.cinema.Repository.TransactionRepository;
import com.iiex.cinema.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    @Override
    public List<TransactionDTO> getAllTransaction() {
        List<TransactionDTO> transactionDTOS = new ArrayList<>();
        List<Booking> bookings =  transactionRepository.findAll();
        for (Booking booking :
                bookings) {
            List<Ticket> tickets = (List<Ticket>) booking.getTickets();
            String seats = "";
            for (Ticket ticket :
                    tickets) {
                seats += ticket.getSeat().getSeatNumber() + ", ";
            }
            Schedule schedule = booking.getTickets().iterator().next().getSchedule();
            Movie movie =schedule.getMovie();
            User user = booking.getUser();
            Cinema cinema = schedule.getShowRoom().getCinema();

            TransactionDTO transactionDTO = new TransactionDTO(booking.getId(), cinema.getName(), user.getEmail(), user.getName(), movie.getTitle(),
                    schedule.getStartTime(), booking.getCreated_at(),seats,booking.getTicket_price(), booking.getFood_price(), booking.getFood_price()+booking.getTicket_price());
            transactionDTOS.add(transactionDTO);
        }
        return transactionDTOS;
    }

    @Override
    public TransactionDTO getTransaction(Long id) {
        return null;
    }

    @Override
    public RevenueMonth getRevenueOfMonth(Date mouth) {
        return null;
    }
}

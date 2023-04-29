package com.iiex.cinema.Service;

import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.TransactionDTO;
import com.iiex.cinema.Model.Booking;

import java.util.Date;
import java.util.List;

public interface TransactionService {
    List<TransactionDTO> getAllTransaction();
    TransactionDTO getTransaction(Long id);

    Booking save(Booking
                 booking);

    RevenueMonth getRevenueOfMonth(Date month);
}

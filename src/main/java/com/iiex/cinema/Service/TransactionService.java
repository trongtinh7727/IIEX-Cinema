package com.iiex.cinema.Service;

import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.TransactionDTO;
import com.iiex.cinema.Model.Booking;
import com.iiex.cinema.Model.User;

import java.util.Date;
import java.util.List;

public interface TransactionService {
    List<TransactionDTO> getAllTransaction();

    List<TransactionDTO> getAllTransactionByUser(User user);
    TransactionDTO getTransaction(Long id);

    Booking save(Booking
                 booking);

    RevenueMonth getRevenueOfMonth(Date month);
}

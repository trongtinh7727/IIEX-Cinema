package com.iiex.cinema.Service;

import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.TransactionDTO;

import java.util.Date;
import java.util.List;

public interface TransactionService {
    List<TransactionDTO> getAllTransaction();
    TransactionDTO getTransaction(Long id);

    RevenueMonth getRevenueOfMonth(Date mouth);
}

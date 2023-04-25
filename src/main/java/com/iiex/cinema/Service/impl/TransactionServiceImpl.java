//package com.iiex.cinema.Service.impl;
//
//import com.iiex.cinema.DTO.RevenueMonth;
//import com.iiex.cinema.DTO.TransactionDTO;
//import com.iiex.cinema.Repository.TransactionRepository;
//import com.iiex.cinema.Service.TransactionService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.Date;
//import java.util.List;
//
//@Service
//public class TransactionServiceImpl implements TransactionService {
//    @Autowired
//    private TransactionRepository transactionRepository;
//
//
//    @Override
//    public List<TransactionDTO> getAllTransaction() {
//        return transactionRepository.getTransactions();
//    }
//
//    @Override
//    public TransactionDTO getTransaction(Long id) {
//        return transactionRepository.getTransactionById(id);
//    }
//
//    @Override
//    public RevenueMonth getRevenueOfMonth(Date mouth) {
//        return transactionRepository.getRevenueOfMonth(mouth);
//    }
//}

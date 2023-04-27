package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.TransactionDTO;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Service.ComboFoodService;
import com.iiex.cinema.Service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("api/transactions")
public class TransactionController {
    @Autowired
    private TransactionService transactionService;
    TransactionController(TransactionService transactionService){
        this.transactionService = transactionService;
    }

    @GetMapping("")
    ResponseEntity<CustomResponse> getAll(){
        List<TransactionDTO> transactionDTOS = transactionService.getAllTransaction();
        CustomResponse<TransactionDTO> response = new CustomResponse(true, transactionDTOS);
        return ResponseEntity.ok(response);
    }
    @GetMapping("/getrevenue")
    RevenueMonth getRevenue(@PathVariable Date month){
        RevenueMonth transactionDTOS = transactionService.getRevenueOfMonth(month);
        return transactionDTOS;
    }

    @GetMapping("/getbyid/{id}")
    TransactionDTO getById(@PathVariable Long id) {
        TransactionDTO transactionDTOS = transactionService.getTransaction(id);
        return transactionDTOS;
    }
}

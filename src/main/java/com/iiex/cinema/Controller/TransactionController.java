package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.DTO.FoodDTO;
import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.TransactionDTO;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Service.ComboFoodService;
import com.iiex.cinema.Service.TransactionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

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

    @GetMapping("/getbyid/{id}")
    TransactionDTO getById(@PathVariable Long id) {
        TransactionDTO transactionDTOS = transactionService.getTransaction(id);
        return transactionDTOS;
    }

    @PostMapping("/ticketbooking")
    public String processBooking(@RequestBody Map<String, Object> payload, HttpSession session) {
        int totalRegular = (int) payload.get("total_regular");
        int totalCouple = (int) payload.get("total_couple");
        int quantityRegular = (int) payload.get("quantity_regular");
        int quantityCouple = (int) payload.get("quantity_couple");

        session.setAttribute("quantity_regular", quantityRegular);
        session.setAttribute("quantity_couple", quantityCouple);
        session.setAttribute("total_regular", totalRegular);
        session.setAttribute("total_couple", totalCouple);
        return "OKe";
    }

    @PostMapping("/seatbooking")
    public String seatbooking(@RequestBody Map<String, Object> payload, HttpSession session) {
        List<String> seats = (List<String>) payload.get("data");
        session.setAttribute("seats", seats);
        return "OKe";
    }

    @PostMapping("/combobooking")
    public String comboBooking(@RequestBody Map<String, Object> payload, HttpSession session) {
        List<String> foods = (List<String>) payload.get("data");
        session.setAttribute("foods", foods);
        return "OKe";
    }
}

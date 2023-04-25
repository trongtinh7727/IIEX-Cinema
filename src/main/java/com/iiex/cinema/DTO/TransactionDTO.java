package com.iiex.cinema.DTO;

import jakarta.persistence.Entity;
import jakarta.persistence.NamedStoredProcedureQuery;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TransactionDTO {
    private int id;
    private String cinemaName;
    private String clientUsername;
    private String clientFirstName;
    private String clientLastName;
    private String clientPhone;
    private String clientAddress;
    private String movieTitle;
    private Date startTime;
    private Date createdAt;
    private String seats;
    private double ticketPrice;
    private double foodPrice;
    private double totalPrice;
}

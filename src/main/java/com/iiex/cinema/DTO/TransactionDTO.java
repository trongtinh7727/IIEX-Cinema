package com.iiex.cinema.DTO;

import jakarta.persistence.Entity;
import jakarta.persistence.NamedStoredProcedureQuery;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TransactionDTO {

  private Long id;
  private String cinema;
  private String address;
  private int showRoom;
  private String username;
  private String name;
  private String title;
  private Date startime;
  private Date created_at;
  private String seats;
  private double ticketPrice;
  private double foodPrice;
  private double totalPrice;
}

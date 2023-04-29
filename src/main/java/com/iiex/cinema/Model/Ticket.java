package com.iiex.cinema.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ticket")

public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;

    private float price;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "booking_id")
    private Booking booking;


    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "schedule_id")
    private  Schedule schedule;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "seat_id")
    private Seat seat;

}

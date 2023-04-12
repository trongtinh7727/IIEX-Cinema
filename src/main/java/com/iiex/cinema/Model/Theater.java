package com.iiex.cinema.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "theater")
public class Theater {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;
    private int theaterNumber;
    private int seatCount;
    private int isShowing;

    @ManyToOne
    @JoinColumn(name = "CINEMA_ID")
    private Cinema cinema;

    @OneToMany(mappedBy = "theater",cascade = CascadeType.ALL)
    private Collection<Seat> seats;

}

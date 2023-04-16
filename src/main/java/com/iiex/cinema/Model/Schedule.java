package com.iiex.cinema.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "schedule")

public class Schedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "startTime")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date startTime;

    @Column(name = "endTime")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date endTime;

    @ManyToOne
    @JoinColumn(name = "movie_id")
    private Movie movie;

    @ManyToOne
    @JoinColumn(name = "theater_id")
    private Theater theater;

    @OneToMany(mappedBy = "schedule")
    private  Collection<Ticket> tickets;

}
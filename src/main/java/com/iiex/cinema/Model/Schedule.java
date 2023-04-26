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

    @Column(name = "start_time")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date startTime;

    @Column(name = "end_time")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date endTime;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "movie_id")
    private Movie movie;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "showroom_id")
    private ShowRoom showRoom;

    @OneToMany(mappedBy = "schedule")
    @JsonIgnore
    private  Collection<Ticket> tickets;

}
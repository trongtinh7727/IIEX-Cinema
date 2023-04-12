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
@Table(name = "movie")
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;
    private String genre;

    private int duration;

    private float rating;

    private String story;
    private  String poster;

    @Column(name = "OPENING_DAY")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date opening_day;

    @Column(name = "CLOSING_DAY")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date closing_day;


    @OneToMany(mappedBy = "movie",cascade = CascadeType.ALL)
    private Collection<Schedule> schedules;


}

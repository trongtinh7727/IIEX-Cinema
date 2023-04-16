package com.iiex.cinema.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.util.Collection;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
  private String director;
  private String actors;

  private int duration;

  private float rating;

  private String story;
  private String poster;

  @Column(name = "OPENING_DAY")
  @Temporal(TemporalType.TIMESTAMP)
  private java.util.Date opening_day;

  @Column(name = "CLOSING_DAY")
  @Temporal(TemporalType.TIMESTAMP)
  private java.util.Date closing_day;

  @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
  @JsonIgnore
  private Collection<Schedule> schedules;
}

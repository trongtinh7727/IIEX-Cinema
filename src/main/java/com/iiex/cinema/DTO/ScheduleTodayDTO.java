package com.iiex.cinema.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleTodayDTO {
    private Long id;
    private Long movieId;
    private String movieTitle;
    private String moviePoster;
    private String movieStory;
    private List<Date> startTimes;
    private Date day;
}

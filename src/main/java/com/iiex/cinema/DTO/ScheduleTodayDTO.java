package com.iiex.cinema.DTO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class ScheduleTodayDTO {
    private Long id;
    private Long movieId;
    private String movieTitle;
    private String moviePoster;
    private String movieStory;
    private List<LocalTime> startTimes;
    private LocalDate day;
}

package com.iiex.cinema.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleByShowroomDTO {
    private String title;
    private int duration;
    private long id;
    private long movId;
    private long showroomId;
    private Date startTime;
    private int seatCount;
    private int emptySeat;

}

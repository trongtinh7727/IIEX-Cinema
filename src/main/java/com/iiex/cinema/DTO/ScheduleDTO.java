package com.iiex.cinema.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleDTO  {
    private long ID;
    private String Title;
    private int Duration;
    private java.util.Date startTime;
    private java.util.Date endTime;

//    private int status;
}

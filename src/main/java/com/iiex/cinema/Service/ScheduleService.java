package com.iiex.cinema.Service;


import com.iiex.cinema.DTO.ScheduleByShowroomDTO;
import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.ShowRoom;

import java.util.List;


public interface ScheduleService {
    Schedule findScheduleByID(Long ID);

    Schedule  saveSchedule(Schedule schedule);

    void delete(Long id);

    List<ScheduleByShowroomDTO> findAllScheduleByShowRom(Long id);
}

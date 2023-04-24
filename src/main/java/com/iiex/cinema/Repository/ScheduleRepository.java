package com.iiex.cinema.Repository;

import com.iiex.cinema.DTO.RevenueMonth;
import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.DTO.ScheduleInfoDTO;
import com.iiex.cinema.DTO.ScheduleTodayDTO;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.Theater;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface ScheduleRepository extends JpaRepository<Schedule,Long> {

    @Query("SELECT new com.iiex.cinema.DTO.ScheduleDTO(s.id, m.title,m.duration,s.startTime,s.endTime) FROM Schedule s JOIN s.movie m JOIN s.theater t WHERE t = :theater")
//    List<ScheduleTitle> findScheduleTitlesByTheater(@Param("theater") Theater theater);
    List<ScheduleDTO> findAllByTheater(@Param("theater") Theater theater);


    @Procedure(name = "get_schedule_today")
    ScheduleTodayDTO getScheduleToday();

    @Procedure(name = "get_schedule_by_id")
    ScheduleInfoDTO getScheduleInformation(Long id);

    @Procedure(name = "get_schedule_by_showroom")
    List<ScheduleByShowroom> getScheduleByShowroom(@Param("SHOWROOM_id") int showroomId);
}

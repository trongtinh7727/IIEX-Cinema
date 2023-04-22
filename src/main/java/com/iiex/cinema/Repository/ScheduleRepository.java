package com.iiex.cinema.Repository;

import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.Theater;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ScheduleRepository extends JpaRepository<Schedule,Long> {

    @Query("SELECT new com.iiex.cinema.DTO.ScheduleDTO(s.id, m.title,m.duration,s.startTime,s.endTime) FROM Schedule s JOIN s.movie m JOIN s.theater t WHERE t = :theater")
//    List<ScheduleTitle> findScheduleTitlesByTheater(@Param("theater") Theater theater);
    List<ScheduleDTO> findAllByTheater(@Param("theater") Theater theater);
}

package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


import java.util.Date;
import java.util.List;
@Repository
public interface ScheduleRepository extends JpaRepository<Schedule,Long> {

    List<Schedule> findAllByShowRoom_Id(Long id);

    @Query(value = "SELECT s FROM Schedule s JOIN FETCH s.movie WHERE DATE(s.startTime) = :day")
    List<Schedule> findScheduleByDay(@Param("day") Date day);

}

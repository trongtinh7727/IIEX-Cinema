package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.Theater;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ScheduleRepository extends JpaRepository<Schedule,Long> {
    List<Schedule> findAllByTheater(Theater theater);


}

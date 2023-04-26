package com.iiex.cinema.Repository;

import com.iiex.cinema.DTO.*;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.ShowRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ScheduleRepository extends JpaRepository<Schedule,Long> {


}

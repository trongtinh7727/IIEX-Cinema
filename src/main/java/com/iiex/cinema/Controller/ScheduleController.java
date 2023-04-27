package com.iiex.cinema.Controller;


import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.DTO.ScheduleByShowroomDTO;
import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Service.MovieService;
import com.iiex.cinema.Service.ScheduleService;
import com.iiex.cinema.Service.ShowroomService;
import com.iiex.cinema.Service.TicketService;
import com.iiex.cinema.Service.impl.TicketServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {
    @Autowired
    ScheduleService scheduleService;

    @Autowired
    private MovieService movieService;

    @Autowired
    ShowroomService showroomService;

    @Autowired
    TicketService ticketService;

    ScheduleController(ScheduleService scheduleService){
        this.scheduleService = scheduleService;
    }

    //    schedule manager
    @GetMapping("getByShowroom/{id}")
    ResponseEntity<CustomResponse> getByShowroom(@PathVariable Long id) {
        List<ScheduleByShowroomDTO> schedules = scheduleService.findAllScheduleByShowRom(id);
        CustomResponse<ScheduleByShowroomDTO> response = new CustomResponse(true, schedules);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody ScheduleDTO newSchedule) {
        Movie movie = movieService.finMovieByID(newSchedule.getMovie_Id());
        ShowRoom showRoom = showroomService.findShowroomByID(newSchedule.getShowRoom_Id());
        Schedule schedule = new Schedule(0,newSchedule.getPrice(),newSchedule.getStartTime(),
                newSchedule.getEndTime(),movie,showRoom,null);
        schedule =  scheduleService.saveSchedule(schedule);
        ticketService.generateTicket(schedule);
        CustomResponse<Schedule> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    ScheduleDTO one(@PathVariable Long id) {
        return scheduleService.findScheduleByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        scheduleService.delete(id);
        CustomResponse<Schedule> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> replaceEmployee(@RequestBody ScheduleDTO newSchedule, @PathVariable Long id) {
        Movie movie = movieService.finMovieByID(newSchedule.getMovie_Id());
        ShowRoom showRoom = showroomService.findShowroomByID(newSchedule.getShowRoom_Id());
        Schedule schedule = scheduleService.finSchedule(id);
        schedule.setMovie(movie);
        schedule.setStartTime(newSchedule.getStartTime());
        schedule.setEndTime(newSchedule.getEndTime());
        schedule.setPrice(newSchedule.getPrice());
        scheduleService.saveSchedule(schedule);
        CustomResponse<Schedule> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }


}

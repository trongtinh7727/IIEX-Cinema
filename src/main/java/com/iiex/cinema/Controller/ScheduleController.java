package com.iiex.cinema.Controller;


import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Service.ScheduleService;
import com.iiex.cinema.Service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {
    @Autowired
    ScheduleService scheduleService;

    @Autowired
    TheaterService theaterService;
    ScheduleController(ScheduleService scheduleService){
        this.scheduleService = scheduleService;
    }
    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<Schedule> schedules = scheduleService.findAllSchedule();
        CustomResponse<Schedule> response = new CustomResponse(true, schedules);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody Schedule newSchedule) {
        System.out.println(newSchedule.toString());
            scheduleService.saveSchedule(newSchedule);
        CustomResponse<Schedule> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    Schedule one(@PathVariable Long id) {
        return scheduleService.findScheduleByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        scheduleService.delete(id);
        CustomResponse<Schedule> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> replaceEmployee(@RequestBody Schedule newschedule, @PathVariable Long id) {
        Schedule schedule = scheduleService.findScheduleByID(id);
        schedule.setEndTime(newschedule.getEndTime());
        schedule.setMovie(newschedule.getMovie());
        schedule.setStartTime(newschedule.getStartTime());
        schedule.setTickets(newschedule.getTickets());
        schedule.setTheater(newschedule.getTheater());
        scheduleService.saveSchedule(schedule);
        CustomResponse<Schedule> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/getByTheater/{id}")
    ResponseEntity<CustomResponse> getAllByTheater(@PathVariable Long id) {
        List<ScheduleDTO> schedules = scheduleService.findAllScheduleByTheater(theaterService.findTheaterByID(id));
        CustomResponse<ScheduleDTO> response = new CustomResponse(true, schedules);
        return ResponseEntity.ok(response);
    }

}

package com.iiex.cinema.Controller;


import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.DTO.ScheduleByShowroomDTO;
import com.iiex.cinema.DTO.ScheduleDTO;
import com.iiex.cinema.Model.Schedule;
import com.iiex.cinema.Service.ScheduleService;
import com.iiex.cinema.Service.ShowroomService;
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
    ShowroomService showroomService;
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
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody Map<String, Object> request) {
//        Schedule newSchedule = new Schedule(0,request.get("STARTTIME"),request.get("ENDTIME"), );
//        System.out.println(newSchedule.toString());
//        scheduleService.saveSchedule(newSchedule);
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
        schedule.setShowRoom(newschedule.getShowRoom());
        scheduleService.saveSchedule(schedule);
        CustomResponse<Schedule> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }


}

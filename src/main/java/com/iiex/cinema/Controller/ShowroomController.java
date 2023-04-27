package com.iiex.cinema.Controller;


import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Service.CinemaService;
import com.iiex.cinema.Service.SeatService;
import com.iiex.cinema.Service.ShowroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("api/showrooms")
public class ShowroomController {
    @Autowired
    ShowroomService showroomService;
    @Autowired
    CinemaService cinemaService;
    @Autowired
    SeatService seatService;
    ShowroomController(ShowroomService showroomService){
        this.showroomService = showroomService;
    }
    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<ShowRoom> showRooms = showroomService.findAllTheater();
        CustomResponse<ShowRoom> response = new CustomResponse(true, showRooms);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody Map<String, Object> request) {
        int showroomNumber = Integer.parseInt(request.get("showroom_number").toString());
        int  cinemaId =Integer.parseInt(request.get("cinema_id").toString());
        Cinema cinema = cinemaService.findCinemaByID((long)cinemaId);
        boolean check =  cinema.getShowRooms().stream().anyMatch(p->p.getShowroom_number()==showroomNumber);
        if (check){
            CustomResponse<ShowRoom> response = new CustomResponse(true,"Đã tồn tại phòng trong rạp");
            return  ResponseEntity.ok(response);
        }
        ShowRoom showRoom = new ShowRoom(-1,showroomNumber,90,null,null,cinema);
        showRoom  = showroomService.saveShowroom(showRoom);
        seatService.generateSeat(showRoom);
        CustomResponse<ShowRoom> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    ShowRoom one(@PathVariable Long id) {
        return showroomService.findShowroomByID(id);
    }
    @GetMapping("getByCinema/{id}")
    ResponseEntity<CustomResponse> allByCinema(@PathVariable Long id) {
        List<ShowRoom> showRooms = showroomService.findAllByCinema(id);
        CustomResponse<ShowRoom> response = new CustomResponse(true, showRooms);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        showroomService.delete(id);
        CustomResponse<ShowRoom> response = new CustomResponse(true,"Đã xóa thành công!");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> update(@RequestBody ShowRoom newShowRoom, @PathVariable Long id){
        ShowRoom showRoom = showroomService.findShowroomByID(id);
        Cinema cinema = showRoom.getCinema();
        boolean check =  cinema.getShowRooms().stream().anyMatch(p->p.getShowroom_number()==newShowRoom.getShowroom_number());
        if (check){
            CustomResponse<ShowRoom> response = new CustomResponse(true,"Đã tồn tại phòng trong rạp");
            return  ResponseEntity.ok(response);
        }
        showRoom.setShowroom_number(newShowRoom.getShowroom_number());
        showroomService.saveShowroom(showRoom);
        CustomResponse<ShowRoom> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
}

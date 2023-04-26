package com.iiex.cinema.Controller;


import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.ShowRoom;
import com.iiex.cinema.Service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/theaters")
public class TheaterController {
    @Autowired
    TheaterService theaterService;

    TheaterController(TheaterService theaterService){
        this.theaterService = theaterService;
    }
    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<ShowRoom> showRooms = theaterService.findAllTheater();
        CustomResponse<ShowRoom> response = new CustomResponse(true, showRooms);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody ShowRoom newShowRoom) {
        theaterService.saveTheater(newShowRoom);
        CustomResponse<ShowRoom> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    ShowRoom one(@PathVariable Long id) {
        return theaterService.findTheaterByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        theaterService.delete(id);
        CustomResponse<ShowRoom> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> update(@RequestBody ShowRoom newShowRoom, @PathVariable Long id){
        ShowRoom showRoom = theaterService.findTheaterByID(id);
        showRoom.setTheaterNumber(newShowRoom.getTheaterNumber());
        theaterService.saveTheater(showRoom);
        CustomResponse<ShowRoom> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
}

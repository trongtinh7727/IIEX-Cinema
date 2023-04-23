package com.iiex.cinema.Controller;


import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Theater;
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
        List<Theater> theaters = theaterService.findAllTheater();
        CustomResponse<Theater> response = new CustomResponse(true, theaters);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody Theater newTheater) {
        theaterService.saveTheater(newTheater);
        CustomResponse<Theater> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    Theater one(@PathVariable Long id) {
        return theaterService.findTheaterByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        theaterService.delete(id);
        CustomResponse<Theater> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> update(@RequestBody Theater newTheater, @PathVariable Long id){
        Theater theater = theaterService.findTheaterByID(id);
        theater.setTheaterNumber(newTheater.getTheaterNumber());
        theaterService.saveTheater(theater);
        CustomResponse<Theater> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
}

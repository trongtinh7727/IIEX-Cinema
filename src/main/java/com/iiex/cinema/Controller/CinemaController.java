package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Service.CinemaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/cinemas")
public class CinemaController {
    @Autowired
    CinemaService cinemaService;

    CinemaController(CinemaService cinemaService){
        this.cinemaService = cinemaService;
    }
    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<Cinema> theaters = cinemaService.findAll();
        CustomResponse<Cinema> response = new CustomResponse(true, theaters);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody Cinema cinema) {
        cinemaService.saveCinema(cinema);
        CustomResponse<Cinema> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    Cinema one(@PathVariable Long id) {
        return cinemaService.findCinemaByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        cinemaService.delete(id);
        CustomResponse<Cinema> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> update(@RequestBody Cinema newCinema, @PathVariable Long id){
        Cinema cinema = cinemaService.findCinemaByID(id);
        cinema.setAddress(newCinema.getAddress());
        cinema.setName(newCinema.getName());
        cinema.setPhone(newCinema.getPhone());
        cinema.setTheaters(newCinema.getTheaters());
        cinemaService.saveCinema(cinema);
        CustomResponse<Cinema> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
}

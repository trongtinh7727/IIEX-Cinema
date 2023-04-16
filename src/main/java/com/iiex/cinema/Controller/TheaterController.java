package com.iiex.cinema.Controller;


import com.iiex.cinema.Model.Product;
import com.iiex.cinema.Model.Theater;
import com.iiex.cinema.Service.ProductService;
import com.iiex.cinema.Service.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
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
    List<Theater> all() {
        return theaterService.findAllTheater();
    }
    @PostMapping("")
    Theater newMovie(@RequestBody Theater newProduct) {
        return theaterService.saveTheater(newProduct);
    }
    @GetMapping("/{id}")
    Theater one(@PathVariable Long id) {
        return theaterService.findTheaterByID(id);
    }
    @DeleteMapping("/{id}")
    void delete(@PathVariable Long id){ theaterService.delete(id);}

    @PutMapping("/{id}")
    Theater update(@PathVariable Theater theater){
        Theater oldProduct = theaterService.findTheaterByID(theater.getId());
        return theaterService.saveTheater(oldProduct);
    }
}

package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.ComboFood;
import com.iiex.cinema.Service.ComboFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/api/combofoods")
@RestController
public class  ComboFoodController {
    @Autowired
    private ComboFoodService comboFoodService;
    ComboFoodController(ComboFoodService comboFoodService){
        this.comboFoodService = comboFoodService;
    }
    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<ComboFood> comboFoods = comboFoodService.findAllComboFood();
        CustomResponse<ComboFood> response = new CustomResponse(true, comboFoods);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody ComboFood comboFood) {
        comboFoodService.saveComboFood(comboFood);
        CustomResponse<ComboFood> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    ComboFood one(@PathVariable Long id) {
        return comboFoodService.findComboFoodByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        comboFoodService.delete(id);
        CustomResponse<ComboFood> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> update(@RequestBody ComboFood newComboFood, @PathVariable Long id){
        ComboFood comboFood = comboFoodService.findComboFoodByID(id);
        comboFood.setName(newComboFood.getName());
        comboFood.setImages(newComboFood.getImages());
        comboFood.setPrice(newComboFood.getPrice());
        comboFoodService.saveComboFood(comboFood);
        CustomResponse<ComboFood> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
}

package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.ComboFood;
import com.iiex.cinema.Service.ComboFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

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
    ResponseEntity<CustomResponse> getNewProduct(@RequestParam("name") String name,
                                                 @RequestParam("price") float price,
                                                 @RequestParam("images") MultipartFile imageFile) {
        String folderName = "images/foodcombos";
        File folder = new File(folderName);
        if (!folder.exists()) {
            folder.mkdirs();
        }


        try {
            ComboFood comboFood = new ComboFood();
            comboFood.setName(name);
            comboFood.setPrice(price);

            // Save the image file to the server
            String imageName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
            Path imagePath = Paths.get("src/main/resources/static/assets/images/foodcombos", imageName);
            System.out.println(imagePath.toString());
            Files.copy(imageFile.getInputStream(), imagePath);
            comboFood.setImages(imageName);
            comboFoodService.saveComboFood(comboFood);
            CustomResponse<ComboFood> response = new CustomResponse(true,"Thêm thành công!");
            Thread.sleep(1000);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            CustomResponse<ComboFood> response = new CustomResponse(false,"Thêm thất bại: " +e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
    @GetMapping("/{id}")
    ComboFood one(@PathVariable Long id) {
        return comboFoodService.findComboFoodByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        try {
            comboFoodService.delete(id);
            CustomResponse<ComboFood> response = new CustomResponse(true,"Xóa thành công");
            return ResponseEntity.ok(response);
        }catch (Exception e) {
            CustomResponse<ComboFood> response = new CustomResponse(false, "Xóa thất bại: đồ ăn đã tồn tại lịch sử giao dịch");
            return ResponseEntity.ok(response);
        }
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

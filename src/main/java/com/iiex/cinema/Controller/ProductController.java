package com.iiex.cinema.Controller;
import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Model.Product;
import com.iiex.cinema.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {
    @Autowired
    ProductService productService;

    ProductController(ProductService productService){
        this.productService = productService;
    }
    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<Product> products = productService.findAllProduct();
        CustomResponse<Product> response = new CustomResponse(true, products);
        return ResponseEntity.ok(response);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> getNewProduct(@RequestBody Product newProduct) {
        productService.saveProduct(newProduct);
        CustomResponse<Product> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    Product one(@PathVariable Long id) {
        return productService.findProductByID(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){ 
        productService.delete(id);
        CustomResponse<Product> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> replaceEmployee(@RequestBody Product newProduct, @PathVariable Long id) {
        Product product = productService.findProductByID(id);
        product.setName(newProduct.getName());
        product.setPrice(newProduct.getPrice());
        product.setQuantity(newProduct.getQuantity());
        product.setComboFoods(newProduct.getComboFoods());
        product.setExpiry_date(newProduct.getExpiry_date());
        product.setType(newProduct.getType());
        productService.saveProduct(product);
        CustomResponse<Product> response = new CustomResponse(true,"Sửa thành công");
        return ResponseEntity.ok(response);
    }
}
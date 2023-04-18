package com.iiex.cinema.Controller;
import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Model.Product;
import com.iiex.cinema.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
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
    List<Product> all() {
        return productService.findAllProduct();
    }
    @PostMapping("")
    Product getNewProduct(@RequestBody Product newProduct) {
        return productService.saveProduct(newProduct);
    }
    @GetMapping("/{id}")
    Product one(@PathVariable Long id) {
        return productService.findProductByID(id);
    }
    @DeleteMapping("/{id}")
    void delete(@PathVariable Long id){ productService.delete(id);}

    @PutMapping("/{id}")
    Product update(@PathVariable Product product){
        Product oldProduct = productService.findProductByID(product.getId());
        return productService.saveProduct(oldProduct);
    }
}
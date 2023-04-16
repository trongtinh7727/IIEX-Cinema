package com.iiex.cinema.Service;

import com.iiex.cinema.Model.Movie;
import com.iiex.cinema.Model.Product;

import java.util.List;


public interface ProductService {


    List<Product> findAllProduct();

    Product findProductByID(Long ID);

    Product  saveProduct(Product movie);

    void delete(Long id);

}

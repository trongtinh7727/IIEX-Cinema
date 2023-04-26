package com.iiex.cinema.Service;

import com.iiex.cinema.Model.ComboFood;

import java.util.List;

public interface ComboFoodService {
    List<ComboFood> findAllComboFood();

    ComboFood findComboFoodByID(Long ID);

    ComboFood  saveComboFood(ComboFood comboFood);

    void delete(Long id);

}

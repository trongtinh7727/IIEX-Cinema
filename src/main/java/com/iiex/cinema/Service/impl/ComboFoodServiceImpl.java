package com.iiex.cinema.Service.impl;

import com.iiex.cinema.Model.ComboFood;
import com.iiex.cinema.Repository.ComboFoodRepository;
import com.iiex.cinema.Service.ComboFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComboFoodServiceImpl implements ComboFoodService {
    @Autowired
    private ComboFoodRepository comboFoodRepository;
    @Override
    public List<ComboFood> findAllComboFood() {
        return comboFoodRepository.findAll();
    }

    @Override
    public ComboFood findComboFoodByID(Long ID) {
        return comboFoodRepository.findById(ID).get();
    }

    @Override
    public ComboFood saveComboFood(ComboFood comboFood) {
        return comboFoodRepository.save(comboFood);
    }

    @Override
    public void delete(Long id) {
        comboFoodRepository.deleteById(id);
    }
}

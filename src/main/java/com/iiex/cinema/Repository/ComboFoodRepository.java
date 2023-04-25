package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.ComboFood;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ComboFoodRepository extends JpaRepository<ComboFood,Long> {

}

package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Cinema;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CinemaRepository extends JpaRepository<Cinema,Long> {
    Cinema findCinemaById(Long id);
}

package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Theater;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TheaterRepository extends JpaRepository<Theater,Long> {
}

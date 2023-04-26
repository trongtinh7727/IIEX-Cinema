package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TheaterRepository extends JpaRepository<ShowRoom,Long> {
    List<ShowRoom> findAllByCinema(Cinema cinema);
}

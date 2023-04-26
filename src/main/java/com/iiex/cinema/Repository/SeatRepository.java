package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Seat;
import com.iiex.cinema.Model.ShowRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface SeatRepository extends JpaRepository<Seat,Long> {
}

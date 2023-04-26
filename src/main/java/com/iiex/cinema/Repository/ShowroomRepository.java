package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Cinema;
import com.iiex.cinema.Model.ShowRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShowroomRepository extends JpaRepository<ShowRoom,Long> {
    List<ShowRoom> findAllByCinema(Cinema cinema);

    ShowRoom findShowRoomById(long id);


}

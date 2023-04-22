package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {
    @Query("SELECT m FROM Movie m WHERE m.opening_day <= CURRENT_DATE AND m.closing_day >= CURRENT_DATE")
    List<Movie> findCurrentlyShowingMovies();
}

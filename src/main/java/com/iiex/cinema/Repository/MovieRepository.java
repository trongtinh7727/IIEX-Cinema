package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {
    @Query("SELECT m FROM Movie m WHERE m.opening_day <= CURRENT_DATE AND m.closing_day >= CURRENT_DATE")
    List<Movie> findCurrentlyShowingMovies();

    @Query("SELECT m FROM Movie m WHERE m.opening_day > CURRENT_DATE ORDER BY m.opening_day ASC LIMIT 10")
    List<Movie> findUpcomingMovies();

    @Query("SELECT m.id, m.trailer FROM Movie m WHERE LENGTH(m.trailer) > 1 ORDER BY m.id ASC")
    List<Movie> getMovieTrailer();
}

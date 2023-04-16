package com.iiex.cinema.Repository;

import com.iiex.cinema.Model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovieRepository extends JpaRepository<Movie, Long> {

}

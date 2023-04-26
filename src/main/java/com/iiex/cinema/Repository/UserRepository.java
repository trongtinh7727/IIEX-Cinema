package com.iiex.cinema.Repository;



import com.iiex.cinema.Model.Role;
import com.iiex.cinema.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User,Long> {
    User findByEmail(String email);

    @Override
    void delete(User entity);

    List<User> findAllByRoles(Role role);

}

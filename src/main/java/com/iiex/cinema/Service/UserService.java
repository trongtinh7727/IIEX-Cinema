package com.iiex.cinema.Service;





import com.iiex.cinema.DTO.UserDto;
import com.iiex.cinema.Model.User;

import java.util.List;

public interface UserService  {
    void saveUser(UserDto userDto);

    User findByEmail(String email);

    List<UserDto> findAllUsers();


    String getCurrentUsername();
}

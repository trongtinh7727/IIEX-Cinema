package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.Model.Product;
import com.iiex.cinema.Model.Role;
import com.iiex.cinema.Model.User;
import com.iiex.cinema.Repository.RoleRepository;
import com.iiex.cinema.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private RoleRepository roleRepository;

    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<User> users = userService.findAllUsers(roleRepository.findByName("USER"));
        CustomResponse<User> response = new CustomResponse(true, users);
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    User one(@PathVariable Long id) {
        return userService.findByEmail(id);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        userService.delete(id);
        CustomResponse<User> response = new CustomResponse(true,"Xóa thành công");
        return ResponseEntity.ok(response);
    }
    
}

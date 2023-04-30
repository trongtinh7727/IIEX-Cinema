package com.iiex.cinema.Controller;

import com.iiex.cinema.Api.CustomResponse;
import com.iiex.cinema.DTO.ChangePasswordRequest;
import com.iiex.cinema.DTO.UserDto;
import com.iiex.cinema.Model.User;
import com.iiex.cinema.Repository.RoleRepository;
import com.iiex.cinema.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private RoleRepository roleRepository;

    @GetMapping("")
    ResponseEntity<CustomResponse> all() {
        List<UserDto> users = userService.findAllUsers("USER");
        CustomResponse<UserDto> response = new CustomResponse(true, users);
        return ResponseEntity.ok(response);
    }
    @GetMapping("/{id}")
    User one(@PathVariable Long id) {
        return userService.findById(id);
    }
    @PostMapping("")
    ResponseEntity<CustomResponse> addNewUser(@RequestBody UserDto newUser) {
        User isvalid = userService.findByEmail(newUser.getEmail());
        if (isvalid != null) {
            CustomResponse<User> response = new CustomResponse(false,"Tên đăng nhập đã tồn tại!");
            return ResponseEntity.ok(response);
        }
        newUser.setPassword("Demo@123");
        userService.saveUser(newUser,"USER");
        CustomResponse<User> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    ResponseEntity<CustomResponse> userRegister(@RequestBody UserDto newUser) {
        User isvalid = userService.findByEmail(newUser.getEmail());
        if (isvalid != null) {
            CustomResponse<User> response = new CustomResponse(false,"Tên đăng nhập đã tồn tại!");
            return ResponseEntity.ok(response);
        }
        userService.saveUser(newUser,"USER");
        CustomResponse<User> response = new CustomResponse(true,"Thêm thành công");
        return ResponseEntity.ok(response);
    }
    @DeleteMapping("/{id}")
    ResponseEntity<CustomResponse> delete(@PathVariable Long id){
        userService.delete(id);
//        CustomResponse<User> response = new CustomResponse(false,"Tính năng không hỗ trợ");
        CustomResponse<User> response = new CustomResponse(true,"Deleted");
        return ResponseEntity.ok(response);
    }
    @PutMapping("/{id}")
    ResponseEntity<CustomResponse> update(@RequestBody User newUser) {
        List<User> list = new ArrayList<>();
        User userUpdated = userService.update(newUser);
        if (userUpdated == null) {
            CustomResponse<User> response = new CustomResponse(false,list,"Không tim thấy user");
            return ResponseEntity.ok(response);
        }
        list.add(userUpdated);
        CustomResponse<User> response = new CustomResponse(true,list,"Sửa thành công");
        return ResponseEntity.ok(response);
    }

    @PostMapping(value = "/change-password")
    public ResponseEntity<?> changePassword(@RequestBody ChangePasswordRequest changePasswordRequest) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        User user = userService.findByEmail(username);

        if (!userService.isPasswordValid(user, changePasswordRequest.getCurrentPassword())) {
            return ResponseEntity.badRequest().body("Current password is incorrect");
        }

        userService.changePassword(user, changePasswordRequest.getNewPassword());

        return ResponseEntity.ok("Password changed successfully");
    }
    
}

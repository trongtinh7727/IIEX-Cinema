package com.iiex.cinema.Service.impl;


import com.iiex.cinema.DTO.UserDto;
import com.iiex.cinema.Model.Role;
import com.iiex.cinema.Model.User;
import com.iiex.cinema.Repository.RoleRepository;
import com.iiex.cinema.Repository.UserRepository;
import com.iiex.cinema.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;


    public UserServiceImpl(UserRepository userRepository,
                           RoleRepository roleRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }
    @Override
    public void saveUser(UserDto userDto,String NameRole) {
        User user = new User();
        user.setName(userDto.getName());
        user.setEmail(userDto.getEmail());
        user.setAddress(userDto.getAddress());
        user.setCreated(new Date());
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        Role role = roleRepository.findByName(NameRole);
        if(role == null){
            role = checkRoleExist(NameRole);
        }
        user.setRoles(Arrays.asList(role));
        userRepository.save(user);
    }

    @Override
    public void saveAdmin(UserDto userDto) {

    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public List<UserDto> findAllUsers(String NameRole) {
        List<User> users = userRepository.findAllByRoles(roleRepository.findByName(NameRole));
        return users.stream().map((user) -> convertEntityToDto(user))
                .collect(Collectors.toList());
    }

    @Override
    public List<User> findAllUsers(Role role) {
        return userRepository.findAllByRoles(role);
    }
    @Override
    public String getCurrentUsername() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth.getName();
    }
    @Override
    public User findById(Long id) {
        return userRepository.findById(id).get();
    }
    @Override
    public User update(User user) {
        User Old_user = userRepository.findById(user.getId()).get();
        if (Old_user == null) {
            return null;
        }
        Old_user.setEmail(user.getEmail());
        Old_user.setName(user.getName());
        Old_user.setAddress(user.getAddress());
        return userRepository.save(Old_user);
    }
    @Override
    public void delete(Long id) {
        User user = userRepository.findById(id).get();
        userRepository.delete(user);
    }

    private UserDto convertEntityToDto(User user){
        UserDto userDto = new UserDto();
        userDto.setName(user.getName());
        userDto.setEmail(user.getEmail());
        return userDto;
    }

    private Role checkRoleExist(String NameRole) {
        Role role = new Role();
        role.setName(NameRole);
        return roleRepository.save(role);
    }
}
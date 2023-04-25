package com.iiex.cinema.DTO;


import jakarta.persistence.Column;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    private Long id;

    private String name;

    private String email;

    private String password;

    private String Address;

    @Column(name = "created")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date created;

}

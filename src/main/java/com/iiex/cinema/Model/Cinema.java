package com.iiex.cinema.Model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "cinema")
public class Cinema {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;

    private String Phone;

    private String Address;

    @OneToMany(fetch = FetchType.EAGER,
            mappedBy = "cinema",
            cascade = CascadeType.ALL)
    @JsonIgnore
    private Collection<Theater> theaters;
}

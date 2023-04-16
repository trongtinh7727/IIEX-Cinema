package com.iiex.cinema.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "booking")
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date created_at ;

    @OneToMany(mappedBy = "booking",cascade = CascadeType.ALL)
    @JsonIgnore
    private Collection<Ticket> tickets;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    @JsonIgnore
    @JoinTable(
            name = "food_booking",
            joinColumns = {
                    @JoinColumn(name = "food_id", referencedColumnName = "id"),
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "booking_id", referencedColumnName = "id"),
            }
    )
    private Collection<ComboFood> comboFoods;

}

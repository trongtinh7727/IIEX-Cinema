package com.iiex.cinema.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.Collection;
import java.util.List;

import lombok.*;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "user")
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int id;

  private String name;
  private String email;
  private String address;
  private String password;

  @Column(name = "created")
  @Temporal(TemporalType.TIMESTAMP)
  private java.util.Date created;

  @OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
  @JsonIgnore
  private List<Booking> bookings;

  @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @EqualsAndHashCode.Exclude
  @ToString.Exclude
  @JsonIgnore
  @JoinTable(
    name = "users_roles",
    joinColumns = {
      @JoinColumn(name = "user_id", referencedColumnName = "id"),
    },
    inverseJoinColumns = {
      @JoinColumn(name = "role_id", referencedColumnName = "id"),
    }
  )
  private Collection<Role> roles;
}

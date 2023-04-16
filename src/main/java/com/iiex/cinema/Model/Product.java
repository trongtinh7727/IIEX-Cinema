package com.iiex.cinema.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private  String name;
    private  String type;
    private double price;
    private int quantity;

    @Column(name = "Expiry_Date")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date expiry_date;


    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    @JsonIgnore
    @JoinTable(
            name = "product_fcb",
            joinColumns = {
                    @JoinColumn(name = "PRODUCT_ID", referencedColumnName = "id"),
            },
            inverseJoinColumns = {
                    @JoinColumn(name = "FCB_ID", referencedColumnName = "id"),
            }
    )
    private Collection<ComboFood> comboFoods;
}

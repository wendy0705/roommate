package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "non_rented_data")
public class NonRentedData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "region_ne_lat", nullable = false)
    private double regionNeLat;

    @Column(name = "region_ne_lng", nullable = false)
    private double regionNeLng;

    @Column(name = "region_sw_lat", nullable = false)
    private double regionSwLat;

    @Column(name = "region_sw_lng", nullable = false)
    private double regionSwLng;

    @Column(name = "rental_period", nullable = false)
    private Integer rentalPeriod;

}

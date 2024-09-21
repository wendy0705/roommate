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
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "region_ne_lat")
    private double regionNeLat;

    @Column(name = "region_ne_lng")
    private double regionNeLng;

    @Column(name = "region_sw_lat")
    private double regionSwLat;

    @Column(name = "region_sw_lng")
    private double regionSwLng;

    @Column(name = "rental_period")
    private Integer rentalPeriod;

}

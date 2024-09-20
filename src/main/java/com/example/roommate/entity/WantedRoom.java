package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "wanted_room")
public class WantedRoom {

    @Getter
    @Setter
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "low_price", nullable = false)
    private Integer lowPrice;

    @Column(name = "high_price", nullable = false)
    private Integer highPrice;

    @ManyToOne
    @JoinColumn(name = "data_id", nullable = false)
    private NonRentedData nonRentedData;

    @ManyToOne
    @JoinColumn(name = "room_id", nullable = false)
    private RentalRoom rentalRoom;

}

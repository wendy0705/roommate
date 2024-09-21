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

    @Column(name = "low_price")
    private Integer lowPrice;

    @Column(name = "high_price")
    private Integer highPrice;

    @ManyToOne
    @JoinColumn(name = "data_id")
    private NonRentedData nonRentedData;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private RentalRoom rentalRoom;

}

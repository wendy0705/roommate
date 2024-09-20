package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "available_room")
public class AvailableRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "data_id")
    private RentedHouseData rentedHouseData;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private RentalRoom rentalRoom;

    @Column(name = "price")
    private Integer price;

}

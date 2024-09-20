package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "occupied_room")
public class OccupiedRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "description", columnDefinition = "text")
    private String description;

    @ManyToOne
    @JoinColumn(name = "data_id")
    private RentedHouseData rentedHouseData;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private RentalRoom rentalRoom;

}

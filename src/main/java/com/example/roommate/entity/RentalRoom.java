package com.example.roommate.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "rental_room")
public class RentalRoom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonProperty("id")
    private Long id;

    @Column(name = "room_type")
    @JsonProperty("room_type")
    private String roomType;

    @OneToMany(mappedBy = "rentalRoom", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<AvailableRoom> availableRooms;

    @OneToMany(mappedBy = "rentalRoom", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<WantedRoom> wantedRooms;
}

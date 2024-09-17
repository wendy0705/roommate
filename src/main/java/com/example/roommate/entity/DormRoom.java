package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "dorm_room")
public class DormRoom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String roomType;
    @ManyToOne
    @JoinColumn(name = "dorm_id")
    private Dorm dorm;
}

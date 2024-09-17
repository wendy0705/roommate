package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "user_dorm_options")
public class UserDormOptions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "dorm_data_id")
    private DormData dormData;

    @ManyToOne
    @JoinColumn(name = "dorm_id")
    private Dorm dorm;

    @ManyToOne
    @JoinColumn(name = "dorm_room_id")
    private DormRoom dormRoom;

}

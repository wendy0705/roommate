package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "dorm_data")
public class DormData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "applied_dorm")
    private Boolean appliedDorm;

    @ManyToOne
    @JoinColumn(name = "school_id")
    private School school;

}

package com.example.roommate.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "user_match", uniqueConstraints = @UniqueConstraint(columnNames = {"user_id_1", "user_id_2"}))
public class UserMatch {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id_1")
    private Long userId1;

    @Column(name = "user_id_2")
    private Long userId2;

    @Column(name = "pet_same_or_not")
    private Integer petSameOrNot;

    @Column(name = "noise_percentage", precision = 8, scale = 2)
    private BigDecimal noisePercentage;

    @Column(name = "weather_percentage", precision = 8, scale = 2)
    private BigDecimal weatherPercentage;

    @Column(name = "interest_percentage", precision = 8, scale = 2)
    private BigDecimal interestPercentage;

    @Column(name = "humid_percentage", precision = 8, scale = 2)
    private BigDecimal humidPercentage;

    @Column(name = "schedule_percentage", precision = 8, scale = 2)
    private BigDecimal schedulePercentage;

    @Column(name = "dining_location_same_or_not")
    private Integer diningLocationSameOrNot;

    @Column(name = "cook_location_same_or_not")
    private Integer cookLocationSameOrNot;

    @Column(name = "dining_percentage", precision = 8, scale = 2)
    private BigDecimal diningPercentage;

    @Column(name = "shareroom_same_or_not")
    private Integer shareroomSameOrNot;

    @Column(name = "condition_percentage", precision = 8, scale = 2)
    private BigDecimal conditionPercentage;

    @Column(name = "light_percentage", precision = 8, scale = 2)
    private BigDecimal lightPercentage;

    @Column(name = "alarm_percentage", precision = 8, scale = 2)
    private BigDecimal alarmPercentage;

    @Column(name = "friend_percentage", precision = 8, scale = 2)
    private BigDecimal friendPercentage;

}


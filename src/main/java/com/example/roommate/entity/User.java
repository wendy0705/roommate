package com.example.roommate.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "user")
public class User {

    @Id
    private Long id;

    private String email;
    private String password;

    @JsonIgnore
    @OneToOne(mappedBy = "user")
    private DormData dormData;

    private Integer shareRoom;
    private Integer hauntedHouse;
    private Integer rooftopExtension;
    private Integer illegalBuilding;
    private Integer basement;
    private Integer windowless;

    private Integer mondayWakeup;
    private Integer mondaySleep;
    private Integer tuesdayWakeup;
    private Integer tuesdaySleep;
    private Integer wednesdayWakeup;
    private Integer wednesdaySleep;
    private Integer thursdayWakeup;
    private Integer thursdaySleep;
    private Integer fridayWakeup;
    private Integer fridaySleep;
    private Integer saturdayWakeup;
    private Integer saturdaySleep;
    private Integer sundayWakeup;
    private Integer sundaySleep;

    private Integer cookingLocation;
    private Integer diningLocation;
    private Integer diningAlone;
    private Integer diningNotAlone;

    private Integer sleepNoise;
    private Integer workNoise;
    private Integer alarmHabit;
    private Integer lightSensitivity;
    private Integer friendshipHabit;

    private Integer hotWeatherPreference;
    private Integer temperature;
    private Integer humidityPreference;
    private Integer hasPet;
    private String petType;

    private Integer interestSports;
    private Integer interestTravel;
    private Integer interestReading;
    private Integer interestWineTasting;
    private Integer interestDrama;
    private Integer interestAstrology;
    private Integer interestProgramming;
    private Integer interestHiking;
    private Integer interestGaming;
    private Integer interestPainting;
    private Integer interestIdolChasing;
    private Integer interestMusic;
    private String hope;

}
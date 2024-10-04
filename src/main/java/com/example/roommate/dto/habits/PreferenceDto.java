package com.example.roommate.dto.habits;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PreferenceDto {

    @JsonProperty("share_room")
    private int shareRoom;

    @JsonProperty("special_conditions")
    private ConditionDto specialConditions;

    @JsonProperty("schedule")
    private ScheduleArrayDto schedule;

    @JsonProperty("cooking_location")
    private int cookingLocation;

    @JsonProperty("dining_location")
    private int diningLocation;

    @JsonProperty("dining_habits")
    private DiningHabitsDto diningHabits;

    @JsonProperty("noise_sensitivity")
    private NoiseSensitivityDto noiseSensitivity;

    @JsonProperty("alarm_habit")
    private int alarmHabit;

    @JsonProperty("light_sensitivity")
    private int lightSensitivity;

    @JsonProperty("friendship_habit")
    private int friendshipHabit;

    @JsonProperty("hot_weather_preference")
    private WeatherDto hotWeatherPreference;

    @JsonProperty("humidity_preference")
    private int humidityPreference;

    @JsonProperty("pet")
    private PetDto pet;

    @JsonProperty("interest")
    private InterestDto interest;

    @JsonProperty("hope")
    private String hope;

}

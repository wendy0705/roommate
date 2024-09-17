package com.example.roommate.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class WeatherDto {

    @JsonProperty("preference")
    private int preference;

    @JsonProperty("temperature")
    private int temperature;

}

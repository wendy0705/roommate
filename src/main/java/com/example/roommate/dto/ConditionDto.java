package com.example.roommate.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ConditionDto {

    @JsonProperty("haunted_house")
    private int hauntedHouse;

    @JsonProperty("rooftop_extension")
    private int rooftopExtension;

    @JsonProperty("illegal_building")
    private int illegalBuilding;

    @JsonProperty("basement")
    private int basement;

    @JsonProperty("windowless")
    private int windowless;
}

package com.example.roommate.dto.habits;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class InterestDto {

    @JsonProperty("sports")
    private int sports;

    @JsonProperty("travel")
    private int travel;

    @JsonProperty("reading")
    private int reading;

    @JsonProperty("wine_tasting")
    private int wineTasting;

    @JsonProperty("drama")
    private int drama;

    @JsonProperty("astrology")
    private int astrology;

    @JsonProperty("programming")
    private int programming;

    @JsonProperty("hiking")
    private int hiking;

    @JsonProperty("gaming")
    private int gaming;

    @JsonProperty("painting")
    private int painting;

    @JsonProperty("idol_chasing")
    private int idolChasing;

    @JsonProperty("music")
    private int music;
}


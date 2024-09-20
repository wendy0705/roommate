package com.example.roommate.dto.habits;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DiningHabitsDto {

    @JsonProperty("alone")
    private int alone;

    @JsonProperty("not_alone")
    private int notAlone;

}

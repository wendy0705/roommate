package com.example.roommate.dto.rented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RoommateDto {
    @JsonProperty("room_type")
    private long roomType;

    @JsonProperty("description")
    private String description;
}

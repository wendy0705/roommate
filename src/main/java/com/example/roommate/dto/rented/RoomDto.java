package com.example.roommate.dto.rented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RoomDto {
    @JsonProperty("room_type")
    private long roomType;

    @JsonProperty("price")
    private int price;

    @JsonProperty("period")
    private int period;

}


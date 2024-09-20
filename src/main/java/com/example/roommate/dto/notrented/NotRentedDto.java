package com.example.roommate.dto.notrented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class NotRentedDto {

    @JsonProperty("area")
    private AreaDto area;

    @JsonProperty("room_type")
    private List<RoomTypeDto> roomType;

    @JsonProperty("rental_period")
    private int rentalPeriod;
}

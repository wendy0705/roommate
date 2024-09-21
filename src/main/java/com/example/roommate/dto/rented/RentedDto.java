package com.example.roommate.dto.rented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class RentedDto {
    @JsonProperty("ne_lat")
    private double neLat;

    @JsonProperty("ne_lng")
    private double neLng;

    @JsonProperty("house_name")
    private String houseName;

    @JsonProperty("available_rooms")
    private List<RoomDto> availableRooms;

    @JsonProperty("current_roommates")
    private List<RoommateDto> currentRoommates;

    @JsonProperty("details")
    private DetailsDto details;
}

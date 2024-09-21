package com.example.roommate.dto.common;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RentalRoomDto {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("room_type")
    private String roomType;

    public RentalRoomDto(Long id, String roomType) {
        this.id = id;
        this.roomType = roomType;
    }
}


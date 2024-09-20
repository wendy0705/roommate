package com.example.roommate.dto.notrented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RoomTypeDto {

    @JsonProperty("type_id")
    private Long typeId;

    @JsonProperty("low_price")
    private int low;

    @JsonProperty("high_price")
    private int high;

}

package com.example.roommate.dto.notrented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AreaDto {

    @JsonProperty("region_ne_lat")
    private double regionNeLat;

    @JsonProperty("region_ne_lng")
    private double regionNeLng;

    @JsonProperty("region_sw_lat")
    private double regionSwLat;

    @JsonProperty("region_sw_lng")
    private double regionSwLng;

}

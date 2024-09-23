package com.example.roommate.dto.notrented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NonRentedMatchDto {

    @JsonProperty("region_ne_lat")
    private Double regionNeLat;

    @JsonProperty("region_ne_lng")
    private Double regionNeLng;

    @JsonProperty("region_sw_lat")
    private Double regionSwLat;

    @JsonProperty("region_sw_lng")
    private Double regionSwLng;

    @JsonProperty("rental_period")
    private Integer rentalPeriod;

    @JsonProperty("low_price")
    private Integer lowPrice;

    @JsonProperty("high_price")
    private Integer highPrice;

    @JsonProperty("room_type")
    private String roomType;
}

package com.example.roommate.dto.rented;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RentedHouseMatchDto {
    @JsonProperty("address_lat")
    private Double addressLat;

    @JsonProperty("address_lng")
    private Double addressLng;

    @JsonProperty("house_name")
    private String houseName;

    @JsonProperty("details")
    private String details;
}

package com.example.roommate.dto.rented;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DetailsDto {
    @JsonProperty("pet_allowed")
    private boolean petAllowed;

    @JsonProperty("rental_period")
    private int rentalPeriod;

    @JsonProperty("shared_spaces")
    private String sharedSpaces;

    @JsonProperty("amenities")
    private String amenities;

    @JsonProperty("additional_fees")
    private String additionalFees;

    @JsonProperty("nearby_facilities")
    private String nearbyFacilities;

    @JsonProperty("other")
    private String other;
}

package com.example.roommate.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PetDto {

    @JsonProperty("has_pet")
    private int hasPet;

    @JsonProperty("pet_type")
    private String petType;

}

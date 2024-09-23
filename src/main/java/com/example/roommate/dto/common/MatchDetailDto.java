package com.example.roommate.dto.common;

import com.example.roommate.dto.notrented.NonRentedMatchDto;
import com.example.roommate.dto.rented.RentedHouseMatchDto;
import com.example.roommate.entity.UserMatch;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MatchDetailDto {
    private Long userId;
    private UserMatch match;
    private List<NonRentedMatchDto> nonRentedData;
    private List<RentedHouseMatchDto> rentedHouseData;
}

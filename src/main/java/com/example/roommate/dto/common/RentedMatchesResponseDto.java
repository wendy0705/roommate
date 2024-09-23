package com.example.roommate.dto.common;

import com.example.roommate.dto.notrented.NonRentedMatchDto;
import com.example.roommate.dto.rented.RentedHouseMatchDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RentedMatchesResponseDto {
    
    private List<Long> matchingUserIds;
    private List<NonRentedMatchDto> nonRentedMatches;
    private List<RentedHouseMatchDto> rentedHouseMatches;

}

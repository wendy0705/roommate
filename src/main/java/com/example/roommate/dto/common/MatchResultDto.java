package com.example.roommate.dto.common;

import com.example.roommate.dto.habits.InterestDto;
import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.dto.notrented.NonRentedMatchDto;
import com.example.roommate.dto.rented.AvailableRoomDto;
import com.example.roommate.dto.rented.OccupiedRoomDto;
import com.example.roommate.dto.rented.RentedHouseMatchDto;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MatchResultDto {
    
    private Long userId;
    private InterestDto commonInterests;
    private List<AvailableRoomDto> availableRooms;
    private List<OccupiedRoomDto> occupiedRooms;
    private PreferenceDto myPreference;
    private PreferenceDto othersPreference;
    private double matchScore;
    private List<NonRentedMatchDto> nonRentedData;
    private List<RentedHouseMatchDto> rentedHouseData;

}

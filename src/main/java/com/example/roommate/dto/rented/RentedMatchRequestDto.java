package com.example.roommate.dto.rented;

import com.example.roommate.dto.habits.PreferenceDto;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class RentedMatchRequestDto {
    @JsonProperty("my_preference")
    private PreferenceDto myPreference;

    @JsonProperty("matching_user_ids")
    private List<Long> matchingUserIds;
}

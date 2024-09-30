package com.example.roommate.dto.notrented;

import com.example.roommate.dto.habits.PreferenceDto;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
public class NotRentedMatchRequestDto {
    @JsonProperty("my_preference")
    private PreferenceDto myPreference;

    @JsonProperty("matching_user_ids")
    private Map<Long, Integer> matchingUserIds;

}

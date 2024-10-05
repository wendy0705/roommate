package com.example.roommate.dto.common;

import com.example.roommate.dto.habits.PreferenceDto;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MatchDetailDto {

    private Long userId;
    private PreferenceDto myPreference;
    private PreferenceDto othersPreference;

}

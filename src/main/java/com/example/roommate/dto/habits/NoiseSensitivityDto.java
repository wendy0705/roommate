package com.example.roommate.dto.habits;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NoiseSensitivityDto {

    @JsonProperty("sleep")
    private int sleep;

    @JsonProperty("study_or_work")
    private int studyOrWork;

}

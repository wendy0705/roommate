package com.example.roommate.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class DormDto {

    @JsonProperty("applied_dorm")
    private boolean appliedDorm;

    @JsonProperty("school")
    private Long schoolId;

    @JsonProperty("dormitory")
    private List<Long> dormitoryIds;

    @JsonProperty("room_type")
    private List<Long> roomTypesIds;
}

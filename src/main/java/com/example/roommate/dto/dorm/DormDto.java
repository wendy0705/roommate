package com.example.roommate.dto.dorm;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class DormDto {

    @JsonProperty("applied_dorm")
    private boolean appliedDorm;

    @JsonProperty("school_id")
    private Long schoolId;

    @JsonProperty("dormitory_id")
    private List<Long> dormitoryIds;

    @JsonProperty("room_type_id")
    private List<Long> roomTypesIds;
}

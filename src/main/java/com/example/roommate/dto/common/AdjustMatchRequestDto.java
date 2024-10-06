package com.example.roommate.dto.common;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdjustMatchRequestDto {
    @JsonProperty("my_id")
    private Long myId;
    @JsonProperty("user_ids")
    private List<Long> userIds;
    @JsonProperty("priority_indicators")
    private List<Integer> priorityIndicators;
}

package com.example.roommate.dto.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SortedMatchResultDto {
    private Long userId;
    private double matchScore;
}

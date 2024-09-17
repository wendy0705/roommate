package com.example.roommate.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ScheduleArrayDto {

    private Integer[] monday;
    private Integer[] tuesday;
    private Integer[] wednesday;
    private Integer[] thursday;
    private Integer[] friday;
    private Integer[] saturday;
    private Integer[] sunday;

}

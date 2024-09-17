package com.example.roommate.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class ScheduleListDto {

    private List<Integer> monday;
    private List<Integer> tuesday;
    private List<Integer> wednesday;
    private List<Integer> thursday;
    private List<Integer> friday;
    private List<Integer> saturday;
    private List<Integer> sunday;
}


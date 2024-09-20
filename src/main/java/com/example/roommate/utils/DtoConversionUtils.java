package com.example.roommate.utils;

import com.example.roommate.dto.habits.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DtoConversionUtils {

    public static List<Integer> convertConditionDtoToList(ConditionDto conditionDto) {
        List<Integer> conditionList = new ArrayList<>();

        conditionList.add(conditionDto.getHauntedHouse());
        conditionList.add(conditionDto.getRooftopExtension());
        conditionList.add(conditionDto.getIllegalBuilding());
        conditionList.add(conditionDto.getBasement());
        conditionList.add(conditionDto.getWindowless());

        return conditionList;
    }

    public static Integer[] convertScheduleDtoToList(ScheduleArrayDto scheduleDto) {
        List<Integer> scheduleList = new ArrayList<>();

        scheduleList.addAll(Arrays.asList(scheduleDto.getMonday()));
        scheduleList.addAll(Arrays.asList(scheduleDto.getTuesday()));
        scheduleList.addAll(Arrays.asList(scheduleDto.getWednesday()));
        scheduleList.addAll(Arrays.asList(scheduleDto.getThursday()));
        scheduleList.addAll(Arrays.asList(scheduleDto.getFriday()));
        scheduleList.addAll(Arrays.asList(scheduleDto.getSaturday()));
        scheduleList.addAll(Arrays.asList(scheduleDto.getSunday()));

        return scheduleList.toArray(new Integer[0]);
    }

    public static List<Integer> convertDiningHabitsDtoToList(DiningHabitsDto diningHabitsDto) {
        List<Integer> diningHabitsList = new ArrayList<>();

        diningHabitsList.add(diningHabitsDto.getAlone());
        diningHabitsList.add(diningHabitsDto.getNotAlone());

        return diningHabitsList;
    }

    public static Integer[] convertNoiseSensitivityDtoToList(NoiseSensitivityDto noiseSensitivityDto) {
        List<Integer> noiseSensitivityList = new ArrayList<>();

        noiseSensitivityList.add(noiseSensitivityDto.getSleep());
        noiseSensitivityList.add(noiseSensitivityDto.getStudyOrWork());

        return noiseSensitivityList.toArray(new Integer[0]);
    }

    public static List<Integer> convertInterestDtoToList(InterestDto interestDto) {
        List<Integer> interestList = new ArrayList<>();

        interestList.add(interestDto.getSports());
        interestList.add(interestDto.getTravel());
        interestList.add(interestDto.getReading());
        interestList.add(interestDto.getWineTasting());
        interestList.add(interestDto.getDrama());
        interestList.add(interestDto.getAstrology());
        interestList.add(interestDto.getProgramming());
        interestList.add(interestDto.getHiking());
        interestList.add(interestDto.getGaming());
        interestList.add(interestDto.getPainting());
        interestList.add(interestDto.getIdolChasing());
        interestList.add(interestDto.getMusic());

        return interestList;
    }
}

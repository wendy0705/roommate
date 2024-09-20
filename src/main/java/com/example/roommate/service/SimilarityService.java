package com.example.roommate.service;

import com.example.roommate.dto.habits.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.example.roommate.utils.DtoConversionUtils.*;
import static com.example.roommate.utils.SimilarityCalculationUtils.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class SimilarityService {

    public Map<String, Object> analysis(PreferenceDto personA) {

        PreferenceDto personB = getFakeData();

        Map<String, Object> result = new HashMap<>();

        result.put("shareroomSameOrNot", compareTwoChoices(personA.getShareRoom(), personB.getShareRoom()));
        result.put("conditionPercentage", compareConditons(personA, personB));
        result.put("schedulePercentage", compareSchedule(personA, personB));
        result.put("cookLocationSameOrNot", compareTwoChoices(personA.getCookingLocation(), personB.getCookingLocation()));
        result.put("diningLocationSameOrNot", compareTwoChoices(personA.getDiningLocation(), personB.getDiningLocation()));
        result.put("diningPercentage", compareDiningHabits(personA, personB));
        result.put("noisePercentage", compareNoiseSensitivity(personA, personB));
        result.put("alarmPercentage", compareSimpleDistance(personA.getAlarmHabit(), personB.getAlarmHabit(), 2));
        result.put("lightPercentage", compareSimpleDistance(personA.getLightSensitivity(), personB.getLightSensitivity(), 2));
        result.put("friendPercentage", compareSimpleDistance(personA.getFriendshipHabit(), personB.getFriendshipHabit(), 2));
        result.put("weatherPercentage", compareSimpleDistance(personA.getHotWeatherPreference().getPreference(), personB.getHotWeatherPreference().getPreference(), 3));
        result.put("humidPercentage", compareSimpleDistance(personA.getHumidityPreference(), personB.getHumidityPreference(), 2));
        result.put("petSameOrNot", compareTwoChoices(personA.getPet().getHasPet(), personB.getPet().getHasPet()));
        result.put("interestPercentage", compareInterest(personA, personB));

        return result;
    }

    public double compareConditons(PreferenceDto personA, PreferenceDto personB) {

        List<Integer> conditionA = convertConditionDtoToList(personA.getSpecialConditions());
        List<Integer> conditionB = convertConditionDtoToList(personB.getSpecialConditions());

        double percentage = calculateOrderedJaccardSimilarity(conditionA, conditionB);
        return percentage;

    }

    public double compareSchedule(PreferenceDto personA, PreferenceDto personB) {

        Integer[] scheduleA = convertScheduleDtoToList(personA.getSchedule());
        Integer[] scheduleB = convertScheduleDtoToList(personB.getSchedule());

        double maxDistance = calculateMaxDistance(12, 2, scheduleA.length);

        double percentage = calculateSimilarityPercentage(scheduleA, scheduleB, maxDistance, true);

        return percentage;

    }

    public double compareDiningHabits(PreferenceDto personA, PreferenceDto personB) {

        List<Integer> diningA = convertDiningHabitsDtoToList(personA.getDiningHabits());
        List<Integer> diningB = convertDiningHabitsDtoToList(personB.getDiningHabits());

        double percentage = calculateOrderedJaccardSimilarity(diningA, diningB);

        return percentage;
    }

    public double compareNoiseSensitivity(PreferenceDto personA, PreferenceDto personB) {

        Integer[] diningA = convertNoiseSensitivityDtoToList(personA.getNoiseSensitivity());
        Integer[] diningB = convertNoiseSensitivityDtoToList(personB.getNoiseSensitivity());

        double maxDistance = calculateMaxDistance(4, 2, diningA.length);
        double percentage = calculateSimilarityPercentage(diningA, diningB, maxDistance, false);

        return percentage;
    }

    public double compareInterest(PreferenceDto personA, PreferenceDto personB) {

        List<Integer> interestA = convertInterestDtoToList(personA.getInterest());
        List<Integer> interestB = convertInterestDtoToList(personB.getInterest());

        double percentage = calculateOrderedJaccardSimilarity(interestA, interestB);
        return percentage;

    }


    private PreferenceDto getFakeData() {

        PreferenceDto otherPerson = new PreferenceDto();

        otherPerson.setShareRoom(1);

        ConditionDto specialConditions = new ConditionDto();
        specialConditions.setHauntedHouse(0);
        specialConditions.setRooftopExtension(0);
        specialConditions.setIllegalBuilding(0);
        specialConditions.setBasement(0);
        specialConditions.setWindowless(0);
        otherPerson.setSpecialConditions(specialConditions);

        ScheduleArrayDto schedule = new ScheduleArrayDto();
        schedule.setMonday(new Integer[]{22, 6});
        schedule.setTuesday(new Integer[]{22, 6});
        schedule.setWednesday(new Integer[]{22, 6});
        schedule.setThursday(new Integer[]{22, 6});
        schedule.setFriday(new Integer[]{22, 6});
        schedule.setSaturday(new Integer[]{0, 8});
        schedule.setSunday(new Integer[]{0, 8});

        otherPerson.setSchedule(schedule);


        otherPerson.setCookingLocation(0);
        otherPerson.setDiningLocation(1);

        DiningHabitsDto diningHabits = new DiningHabitsDto();
        diningHabits.setAlone(1);
        diningHabits.setNotAlone(1);
        otherPerson.setDiningHabits(diningHabits);

        NoiseSensitivityDto noiseSensitivity = new NoiseSensitivityDto();
        noiseSensitivity.setSleep(5);
        noiseSensitivity.setStudyOrWork(1);
        otherPerson.setNoiseSensitivity(noiseSensitivity);

        otherPerson.setAlarmHabit(0);
        otherPerson.setLightSensitivity(2);
        otherPerson.setFriendshipHabit(1);

        WeatherDto hotWeatherPreference = new WeatherDto();
        hotWeatherPreference.setPreference(2);
        hotWeatherPreference.setTemperature(25);
        otherPerson.setHotWeatherPreference(hotWeatherPreference);

        otherPerson.setHumidityPreference(1);

        PetDto pet = new PetDto();
        pet.setHasPet(1);
        pet.setPetType("兔子");
        otherPerson.setPet(pet);

        InterestDto interest = new InterestDto();
        interest.setSports(0);
        interest.setTravel(1);
        interest.setReading(1);
        interest.setWineTasting(1);
        interest.setDrama(0);
        interest.setAstrology(1);
        interest.setProgramming(0);
        interest.setHiking(1);
        interest.setGaming(0);
        interest.setPainting(1);
        interest.setIdolChasing(1);
        interest.setMusic(0);
        otherPerson.setInterest(interest);

        return otherPerson;

    }

}

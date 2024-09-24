package com.example.roommate.service;

import com.example.roommate.dto.habits.*;
import com.example.roommate.entity.UserMatch;
import com.example.roommate.repository.UserMatchRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static com.example.roommate.utils.DtoConversionUtils.*;
import static com.example.roommate.utils.SimilarityCalculationUtils.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AnalysisService {

    private final UserMatchRepository userMatchRepository;

    public Map<String, Object> analysis(PreferenceDto myPreference, PreferenceDto othersPreference) {


        Map<String, Object> result = new HashMap<>();

        result.put("shareroom_same_or_not", compareTwoChoices(myPreference.getShareRoom(), othersPreference.getShareRoom())); // 2
        result.put("condition_percentage", compareConditons(myPreference, othersPreference)); // 5
        result.put("schedule_percentage", compareSchedule(myPreference, othersPreference)); // 12
        result.put("cook_location_same_or_not", compareTwoChoices(myPreference.getCookingLocation(), othersPreference.getCookingLocation())); // 2
        result.put("dining_location_same_or_not", compareTwoChoices(myPreference.getDiningLocation(), othersPreference.getDiningLocation())); // 2
        result.put("dining_percentage", compareDiningHabits(myPreference, othersPreference)); // 3
        result.put("noise_percentage", compareNoiseSensitivity(myPreference, othersPreference)); // 4
        result.put("alarm_percentage", compareSimpleDistance(myPreference.getAlarmHabit(), othersPreference.getAlarmHabit(), 2)); // 3
        result.put("light_percentage", compareSimpleDistance(myPreference.getLightSensitivity(), othersPreference.getLightSensitivity(), 2)); // 3
        result.put("friend_percentage", compareSimpleDistance(myPreference.getFriendshipHabit(), othersPreference.getFriendshipHabit(), 2)); // 3
        result.put("weather_percentage", compareSimpleDistance(myPreference.getHotWeatherPreference().getPreference(), othersPreference.getHotWeatherPreference().getPreference(), 3)); // 4
        result.put("humid_percentage", compareSimpleDistance(myPreference.getHumidityPreference(), othersPreference.getHumidityPreference(), 2)); // 3
        result.put("pet_same_or_not", compareTwoChoices(myPreference.getPet().getHasPet(), othersPreference.getPet().getHasPet())); // 2
        result.put("interest_percentage", compareInterest(myPreference, othersPreference)); // 12

        return result;
    }

    //data which needs to be converted

    public double compareConditons(PreferenceDto personA, PreferenceDto personB) {

        List<Integer> conditionA = convertConditionDtoToList(personA.getSpecialConditions());
        List<Integer> conditionB = convertConditionDtoToList(personB.getSpecialConditions());

        double percentage = calculateOrderedJaccardSimilarity(conditionA, conditionB);
        return percentage;

    }

    public double compareSchedule(PreferenceDto personA, PreferenceDto personB) {

        Integer[] scheduleA = convertScheduleDtoToList(personA.getSchedule());
        Integer[] scheduleB = convertScheduleDtoToList(personB.getSchedule());

        double maxDistance = calculateMaxDistance(24, 2, scheduleA.length);

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

        Integer[] noiseA = convertNoiseSensitivityDtoToList(personA.getNoiseSensitivity());
        Integer[] noiseB = convertNoiseSensitivityDtoToList(personB.getNoiseSensitivity());

        double maxDistance = calculateMaxDistance(4, 2, noiseA.length);
        double percentage = calculateSimilarityPercentage(noiseA, noiseB, maxDistance, false);

        return percentage;
    }

    public double compareInterest(PreferenceDto personA, PreferenceDto personB) {

        List<Integer> interestA = convertInterestDtoToList(personA.getInterest());
        List<Integer> interestB = convertInterestDtoToList(personB.getInterest());

        double percentage = calculateOrderedJaccardSimilarity(interestA, interestB);
        return percentage;

    }

    public void save(Long userId1, Long userId2, Map<String, Object> result) {

        UserMatch userMatch = new UserMatch();
        userMatch.setUserId1(userId1);
        userMatch.setUserId2(userId2);

        userMatch.setPetSameOrNot((Integer) result.get("pet_same_or_not"));
        userMatch.setNoisePercentage(new BigDecimal(result.get("noise_percentage").toString()));
        userMatch.setWeatherPercentage(new BigDecimal(result.get("weather_percentage").toString()));
        userMatch.setInterestPercentage(new BigDecimal(result.get("interest_percentage").toString()));
        userMatch.setHumidPercentage(new BigDecimal(result.get("humid_percentage").toString()));
        userMatch.setSchedulePercentage(new BigDecimal(result.get("schedule_percentage").toString()));
        userMatch.setDiningLocationSameOrNot((Integer) result.get("dining_location_same_or_not"));
        userMatch.setCookLocationSameOrNot((Integer) result.get("cook_location_same_or_not"));
        userMatch.setDiningPercentage(new BigDecimal(result.get("dining_percentage").toString()));
        userMatch.setShareroomSameOrNot((Integer) result.get("shareroom_same_or_not"));
        userMatch.setConditionPercentage(new BigDecimal(result.get("condition_percentage").toString()));
        userMatch.setLightPercentage(new BigDecimal(result.get("light_percentage").toString()));
        userMatch.setAlarmPercentage(new BigDecimal(result.get("alarm_percentage").toString()));
        userMatch.setFriendPercentage(new BigDecimal(result.get("friend_percentage").toString()));

        userMatchRepository.save(userMatch);
    }

    public List<UserMatch> findByUserId1AndUserIds2(Long myId, List<Long> userIds) {
        return userMatchRepository.findByUserId1AndUserId2In(myId, userIds);
    }

    public Optional<UserMatch> findByUserId1AndUserId2(Long myId, Long userId) {
        return userMatchRepository.findByUserId1AndUserId2(myId, userId);
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

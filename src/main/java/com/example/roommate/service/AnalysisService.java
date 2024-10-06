package com.example.roommate.service;

import com.example.roommate.dto.habits.InterestDto;
import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.entity.UserMatch;
import com.example.roommate.repository.UserMatchRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

import static com.example.roommate.utils.DtoConversionUtils.*;
import static com.example.roommate.utils.SimilarityCalculationUtils.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AnalysisService {

    private final UserMatchRepository userMatchRepository;
    private static final List<Integer> ALL_INDICATORS = Arrays.asList(
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
    );

    public enum Indicator {
        SHARE_ROOM(1, "shareroom_same_or_not"),
        CONDITION(2, "condition_percentage"),
        SCHEDULE(3, "schedule_percentage"),
        COOK_LOCATION(4, "cook_location_same_or_not"),
        DINING_LOCATION(5, "dining_location_same_or_not"),
        DINING_PERCENTAGE(6, "dining_percentage"),
        NOISE_PERCENTAGE(7, "noise_percentage"),
        ALARM_PERCENTAGE(8, "alarm_percentage"),
        LIGHT_PERCENTAGE(9, "light_percentage"),
        FRIEND_PERCENTAGE(10, "friend_percentage"),
        WEATHER_PERCENTAGE(11, "weather_percentage"),
        HUMID_PERCENTAGE(12, "humid_percentage"),
        PET_SAME_OR_NOT(13, "pet_same_or_not"),
        INTEREST_PERCENTAGE(14, "interest_percentage");

        private final int code;
        private final String field;

        Indicator(int code, String field) {
            this.code = code;
            this.field = field;
        }

        public int getCode() {
            return code;
        }

        public String getField() {
            return field;
        }

        public static String getFieldByCode(int code) {
            for (Indicator indicator : values()) {
                if (indicator.getCode() == code) {
                    return indicator.getField();
                }
            }
            throw new IllegalArgumentException("Invalid indicator code: " + code);
        }
    }

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

    public InterestDto compareInterests(InterestDto user1, InterestDto user2) {
        InterestDto result = new InterestDto();
        result.setSports(user1.getSports() == 1 && user2.getSports() == 1 ? 1 : 0);
        result.setTravel(user1.getTravel() == 1 && user2.getTravel() == 1 ? 1 : 0);
        result.setReading(user1.getReading() == 1 && user2.getReading() == 1 ? 1 : 0);
        result.setWineTasting(user1.getWineTasting() == 1 && user2.getWineTasting() == 1 ? 1 : 0);
        result.setDrama(user1.getDrama() == 1 && user2.getDrama() == 1 ? 1 : 0);
        result.setAstrology(user1.getAstrology() == 1 && user2.getAstrology() == 1 ? 1 : 0);
        result.setProgramming(user1.getProgramming() == 1 && user2.getProgramming() == 1 ? 1 : 0);
        result.setHiking(user1.getHiking() == 1 && user2.getHiking() == 1 ? 1 : 0);
        result.setGaming(user1.getGaming() == 1 && user2.getGaming() == 1 ? 1 : 0);
        result.setPainting(user1.getPainting() == 1 && user2.getPainting() == 1 ? 1 : 0);
        result.setIdolChasing(user1.getIdolChasing() == 1 && user2.getIdolChasing() == 1 ? 1 : 0);
        result.setMusic(user1.getMusic() == 1 && user2.getMusic() == 1 ? 1 : 0);

        return result;
    }

    public double calculateWeightedMatchScore(Map<String, Object> analysisResult) {

        double initialWeight = 1.0;
        double score = 0.0;
        int numberOfCriteria = analysisResult.size();

        double normalizedWeight = initialWeight / numberOfCriteria;

        double shareroomWeight = normalizedWeight;
        double conditionWeight = normalizedWeight;
        double scheduleWeight = normalizedWeight;
        double cookLocationWeight = normalizedWeight;
        double diningLocationWeight = normalizedWeight;
        double diningPercentageWeight = normalizedWeight;
        double noisePercentageWeight = normalizedWeight;
        double alarmPercentageWeight = normalizedWeight;
        double lightPercentageWeight = normalizedWeight;
        double friendPercentageWeight = normalizedWeight;
        double weatherPercentageWeight = normalizedWeight;
        double humidPercentageWeight = normalizedWeight;
        double petSameOrNotWeight = normalizedWeight;
        double interestPercentageWeight = normalizedWeight;

        // 確保每個指標存在並轉換為適當的類型
        score += ((Integer) analysisResult.getOrDefault("shareroom_same_or_not", 0)) * shareroomWeight;
        score += ((Double) analysisResult.getOrDefault("condition_percentage", 0.0)) * conditionWeight;
        score += ((Double) analysisResult.getOrDefault("schedule_percentage", 0.0)) * scheduleWeight;
        score += ((Integer) analysisResult.getOrDefault("cook_location_same_or_not", 0)) * cookLocationWeight;
        score += ((Integer) analysisResult.getOrDefault("dining_location_same_or_not", 0)) * diningLocationWeight;
        score += ((Double) analysisResult.getOrDefault("dining_percentage", 0.0)) * diningPercentageWeight;
        score += ((Double) analysisResult.getOrDefault("noise_percentage", 0.0)) * noisePercentageWeight;
        score += ((Double) analysisResult.getOrDefault("alarm_percentage", 0.0)) * alarmPercentageWeight;
        score += ((Double) analysisResult.getOrDefault("light_percentage", 0.0)) * lightPercentageWeight;
        score += ((Double) analysisResult.getOrDefault("friend_percentage", 0.0)) * friendPercentageWeight;
        score += ((Double) analysisResult.getOrDefault("weather_percentage", 0.0)) * weatherPercentageWeight;
        score += ((Double) analysisResult.getOrDefault("humid_percentage", 0.0)) * humidPercentageWeight;
        score += ((Integer) analysisResult.getOrDefault("pet_same_or_not", 0)) * petSameOrNotWeight;
        score += ((Double) analysisResult.getOrDefault("interest_percentage", 0.0)) * interestPercentageWeight;

        return score;
    }

    public double calculateWeightedMatchScore(UserMatch match, List<Integer> priorityIndicatorCodes) {
        double score = 0.0;

        double[] topWeights = {0.5, 0.3, 0.1};

        Map<String, Double> weights = new HashMap<>();

        if (priorityIndicatorCodes != null && priorityIndicatorCodes.size() == 3) {
            for (int i = 0; i < 3; i++) {
                int code = priorityIndicatorCodes.get(i);
                String field = Indicator.getFieldByCode(code);
                weights.put(field, topWeights[i]);
            }
        } else {
            throw new IllegalArgumentException("Exactly three priority indicators must be provided.");
        }

        // 計算剩餘權重
        double totalTopWeight = 0.0;
        for (double w : topWeights) {
            totalTopWeight += w;
        }
        double remainingWeight = 1.0 - totalTopWeight;

        // 計算其他指標的均等權重
        int remainingCount = ALL_INDICATORS.size() - 3;
        double equalWeight = remainingCount > 0 ? remainingWeight / remainingCount : 0.0;

        // 遍歷所有指標並計算加權分數
        for (int code : ALL_INDICATORS) {
            String field = Indicator.getFieldByCode(code);
            double weight = weights.getOrDefault(field, equalWeight);

            // 獲取 UserMatch 中該指標的分數
            double value = getCriterionScore(match, field);

            score += value * weight;
        }

        return score;
    }

    private double getCriterionScore(UserMatch match, String criterion) {
        switch (criterion) {
            case "shareroom_same_or_not":
                return match.getShareroomSameOrNot() != null ? match.getShareroomSameOrNot() : 0;
            case "condition_percentage":
                return match.getConditionPercentage() != null ? match.getConditionPercentage().doubleValue() : 0.0;
            case "schedule_percentage":
                return match.getSchedulePercentage() != null ? match.getSchedulePercentage().doubleValue() : 0.0;
            case "cook_location_same_or_not":
                return match.getCookLocationSameOrNot() != null ? match.getCookLocationSameOrNot() : 0;
            case "dining_location_same_or_not":
                return match.getDiningLocationSameOrNot() != null ? match.getDiningLocationSameOrNot() : 0;
            case "dining_percentage":
                return match.getDiningPercentage() != null ? match.getDiningPercentage().doubleValue() : 0.0;
            case "noise_percentage":
                return match.getNoisePercentage() != null ? match.getNoisePercentage().doubleValue() : 0.0;
            case "alarm_percentage":
                return match.getAlarmPercentage() != null ? match.getAlarmPercentage().doubleValue() : 0.0;
            case "light_percentage":
                return match.getLightPercentage() != null ? match.getLightPercentage().doubleValue() : 0.0;
            case "friend_percentage":
                return match.getFriendPercentage() != null ? match.getFriendPercentage().doubleValue() : 0.0;
            case "weather_percentage":
                return match.getWeatherPercentage() != null ? match.getWeatherPercentage().doubleValue() : 0.0;
            case "humid_percentage":
                return match.getHumidPercentage() != null ? match.getHumidPercentage().doubleValue() : 0.0;
            case "pet_same_or_not":
                return match.getPetSameOrNot() != null ? match.getPetSameOrNot() : 0;
            case "interest_percentage":
                return match.getInterestPercentage() != null ? match.getInterestPercentage().doubleValue() : 0.0;
            default:
                return 0.0;
        }
    }


}

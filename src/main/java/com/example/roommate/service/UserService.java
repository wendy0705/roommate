package com.example.roommate.service;

import com.example.roommate.dto.habits.*;
import com.example.roommate.entity.User;
import com.example.roommate.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public User savePreferenceById(Long userId, PreferenceDto preferenceDto) {

        Optional<User> existingUserOptional = userRepository.findById(userId);
        if (existingUserOptional.isPresent()) {
            User user = existingUserOptional.get();
            user.setShareRoom(preferenceDto.getShareRoom());

            // 存取 specialConditions
            user.setHauntedHouse(preferenceDto.getSpecialConditions().getHauntedHouse());
            user.setRooftopExtension(preferenceDto.getSpecialConditions().getRooftopExtension());
            user.setIllegalBuilding(preferenceDto.getSpecialConditions().getIllegalBuilding());
            user.setBasement(preferenceDto.getSpecialConditions().getBasement());
            user.setWindowless(preferenceDto.getSpecialConditions().getWindowless());

            // 存取 schedule
            user.setMondayWakeup(preferenceDto.getSchedule().getMonday()[0]);
            user.setMondaySleep(preferenceDto.getSchedule().getMonday()[1]);
            user.setTuesdayWakeup(preferenceDto.getSchedule().getTuesday()[0]);
            user.setTuesdaySleep(preferenceDto.getSchedule().getTuesday()[1]);
            user.setWednesdayWakeup(preferenceDto.getSchedule().getWednesday()[0]);
            user.setWednesdaySleep(preferenceDto.getSchedule().getWednesday()[1]);

            user.setThursdayWakeup(preferenceDto.getSchedule().getThursday()[0]);
            user.setThursdaySleep(preferenceDto.getSchedule().getThursday()[1]);

            user.setFridayWakeup(preferenceDto.getSchedule().getFriday()[0]);
            user.setFridaySleep(preferenceDto.getSchedule().getFriday()[1]);

            user.setSaturdayWakeup(preferenceDto.getSchedule().getSaturday()[0]);
            user.setSaturdaySleep(preferenceDto.getSchedule().getSaturday()[1]);

            user.setSundayWakeup(preferenceDto.getSchedule().getSunday()[0]);
            user.setSundaySleep(preferenceDto.getSchedule().getSunday()[1]);

            // 存取其他資料
            user.setCookingLocation(preferenceDto.getCookingLocation());
            user.setDiningLocation(preferenceDto.getDiningLocation());
            user.setDiningAlone(preferenceDto.getDiningHabits().getAlone());
            user.setDiningNotAlone(preferenceDto.getDiningHabits().getNotAlone());
            user.setSleepNoise(preferenceDto.getNoiseSensitivity().getSleep());
            user.setWorkNoise(preferenceDto.getNoiseSensitivity().getStudyOrWork());
            user.setAlarmHabit(preferenceDto.getAlarmHabit());
            user.setLightSensitivity(preferenceDto.getLightSensitivity());
            user.setFriendshipHabit(preferenceDto.getFriendshipHabit());

            // 存取 weather 和 pet
            user.setHotWeatherPreference(preferenceDto.getHotWeatherPreference().getPreference());
            user.setTemperature(preferenceDto.getHotWeatherPreference().getTemperature());
            user.setHumidityPreference(preferenceDto.getHumidityPreference());
            user.setHasPet(preferenceDto.getPet().getHasPet());
            user.setPetType(preferenceDto.getPet().getPetType());

            // 存取 interest
            user.setInterestSports(preferenceDto.getInterest().getSports());
            user.setInterestTravel(preferenceDto.getInterest().getTravel());
            user.setInterestReading(preferenceDto.getInterest().getReading());
            user.setInterestWineTasting(preferenceDto.getInterest().getWineTasting());
            user.setInterestDrama(preferenceDto.getInterest().getDrama());
            user.setInterestAstrology(preferenceDto.getInterest().getAstrology());
            user.setInterestProgramming(preferenceDto.getInterest().getProgramming());
            user.setInterestHiking(preferenceDto.getInterest().getHiking());
            user.setInterestGaming(preferenceDto.getInterest().getGaming());
            user.setInterestPainting(preferenceDto.getInterest().getPainting());
            user.setInterestIdolChasing(preferenceDto.getInterest().getIdolChasing());
            user.setInterestMusic(preferenceDto.getInterest().getMusic());

            return userRepository.save(user);
        } else {
            // 如果 userId 對應的用戶不存在，根據需求進行處理（拋出錯誤或其他處理）
            throw new EntityNotFoundException("User with id " + userId + " not found");
        }
    }

    public PreferenceDto getByUserId(Long userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            PreferenceDto preferenceDto = new PreferenceDto();

            preferenceDto.setShareRoom(user.getShareRoom());

            ConditionDto specialConditions = new ConditionDto();
            specialConditions.setHauntedHouse(user.getHauntedHouse());
            specialConditions.setRooftopExtension(user.getRooftopExtension());
            specialConditions.setIllegalBuilding(user.getIllegalBuilding());
            specialConditions.setBasement(user.getBasement());
            specialConditions.setWindowless(user.getWindowless());
            preferenceDto.setSpecialConditions(specialConditions);

            ScheduleArrayDto schedule = new ScheduleArrayDto();
            schedule.setMonday(new Integer[]{user.getMondayWakeup(), user.getMondaySleep()});
            schedule.setTuesday(new Integer[]{user.getTuesdayWakeup(), user.getTuesdaySleep()});
            schedule.setWednesday(new Integer[]{user.getWednesdayWakeup(), user.getWednesdaySleep()});
            schedule.setThursday(new Integer[]{user.getThursdayWakeup(), user.getThursdaySleep()});
            schedule.setFriday(new Integer[]{user.getFridayWakeup(), user.getFridaySleep()});
            schedule.setSaturday(new Integer[]{user.getSaturdayWakeup(), user.getSaturdaySleep()});
            schedule.setSunday(new Integer[]{user.getSundayWakeup(), user.getSundaySleep()});

            preferenceDto.setSchedule(schedule);

            preferenceDto.setCookingLocation(user.getCookingLocation());
            preferenceDto.setDiningLocation(user.getDiningLocation());

            DiningHabitsDto diningHabits = new DiningHabitsDto();
            diningHabits.setAlone(user.getDiningAlone());
            diningHabits.setNotAlone(user.getDiningNotAlone());
            preferenceDto.setDiningHabits(diningHabits);

            NoiseSensitivityDto noiseSensitivity = new NoiseSensitivityDto();
            noiseSensitivity.setSleep(user.getSleepNoise());
            noiseSensitivity.setStudyOrWork(user.getWorkNoise());
            preferenceDto.setNoiseSensitivity(noiseSensitivity);

            preferenceDto.setAlarmHabit(user.getAlarmHabit());
            preferenceDto.setLightSensitivity(user.getLightSensitivity());
            preferenceDto.setFriendshipHabit(user.getFriendshipHabit());

            WeatherDto hotWeatherPreference = new WeatherDto();
            hotWeatherPreference.setPreference(user.getHotWeatherPreference());
            hotWeatherPreference.setTemperature(user.getTemperature());
            preferenceDto.setHotWeatherPreference(hotWeatherPreference);

            preferenceDto.setHumidityPreference(user.getHumidityPreference());

            PetDto pet = new PetDto();
            pet.setHasPet(user.getHasPet());
            pet.setPetType(user.getPetType());
            preferenceDto.setPet(pet);

            InterestDto interest = new InterestDto();
            interest.setSports(user.getInterestSports());
            interest.setTravel(user.getInterestTravel());
            interest.setReading(user.getInterestReading());
            interest.setWineTasting(user.getInterestWineTasting());
            interest.setDrama(user.getInterestDrama());
            interest.setAstrology(user.getInterestAstrology());
            interest.setProgramming(user.getInterestProgramming());
            interest.setHiking(user.getInterestHiking());
            interest.setGaming(user.getInterestGaming());
            interest.setPainting(user.getInterestPainting());
            interest.setIdolChasing(user.getInterestIdolChasing());
            interest.setMusic(user.getInterestMusic());
            preferenceDto.setInterest(interest);

            return preferenceDto;
        } else {
            throw new RuntimeException("User not found with id: " + userId);
        }
    }
}

package com.example.roommate.service;

import com.example.roommate.dto.dorm.DormDto;
import com.example.roommate.entity.*;
import com.example.roommate.repository.*;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DormService {

    private final DormDataRepository dormDataRepository;

    private final DormRepository dormRepository;

    private final DormRoomRepository dormRoomRepository;

    private final UserDormOptionsRepository userDormOptionsRepository;

    private final SchoolRepository schoolRepository;

    private final UserRepository userRepository;


    public void saveDormData(DormDto dormDto, Long userId) {
        try {
            DormData dormData = new DormData();
            dormData.setAppliedDorm(dormDto.isAppliedDorm());

            School school = schoolRepository.findById(dormDto.getSchoolId())
                    .orElseThrow(() -> new RuntimeException("School not found"));
            dormData.setSchool(school);

            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            dormData.setUser(user);

            dormDataRepository.save(dormData);

            for (int i = 0; i < dormDto.getDormitoryIds().size(); i++) {
                Long dormId = dormDto.getDormitoryIds().get(i);
                Long roomTypeId = dormDto.getRoomTypesIds().get(i);

                Dorm dorm = dormRepository.findById(dormId)
                        .orElseThrow(() -> new RuntimeException("Dorm not found"));

                DormRoom dormRoom = dormRoomRepository.findById(roomTypeId)
                        .orElseThrow(() -> new RuntimeException("DormRoom not found"));

                UserDormOptions userDormOptions = new UserDormOptions();
                userDormOptions.setDormData(dormData);
                userDormOptions.setDorm(dorm);
                userDormOptions.setDormRoom(dormRoom);
                userDormOptionsRepository.save(userDormOptions);
            }
        } catch (EntityNotFoundException e) {
            System.out.println("Entity not found: " + e.getMessage());
            e.printStackTrace();
        } catch (DataAccessException e) {
            // 針對數據庫操作異常
            System.out.println("Database access error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("An unexpected error occurred: " + e.getMessage());
            e.printStackTrace();
        }

    }

    public List<Long> findMatchingUserIds(Long currentUserId) {
        return userDormOptionsRepository.findMatchingUserIds(
                currentUserId
        );
    }
}


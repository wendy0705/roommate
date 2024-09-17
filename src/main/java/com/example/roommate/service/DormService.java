package com.example.roommate.service;

import com.example.roommate.dto.DormDto;
import com.example.roommate.entity.*;
import com.example.roommate.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

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

        DormData dormData = new DormData();
        dormData.setAppliedDorm(dormDto.isAppliedDorm());

        School school = schoolRepository.findById(dormDto.getSchoolId())
                .orElseThrow(() -> new RuntimeException("School not found"));
        dormData.setSchool(school);

//        User user = userRepository.findById(1L) // 假設使用者的 ID 已知
//                .orElseThrow(() -> new RuntimeException("User not found"));
//        dormData.setUser(user);

        dormDataRepository.save(dormData);  // 儲存 dormData

        // 依次處理每個 dormitory 和 room type
        for (int i = 0; i < dormDto.getDormitoryIds().size(); i++) {
            Long dormId = dormDto.getDormitoryIds().get(i);
            Long roomTypeId = dormDto.getRoomTypesIds().get(i);

            // 直接使用 dormId 查找 Dorm 實體
            Dorm dorm = dormRepository.findById(dormId)
                    .orElseThrow(() -> new RuntimeException("Dorm not found"));

            // 直接使用 roomTypeId 查找 DormRoom 實體
            DormRoom dormRoom = dormRoomRepository.findById(roomTypeId)
                    .orElseThrow(() -> new RuntimeException("DormRoom not found"));

            // 創建並儲存 UserDormOptions
            UserDormOptions userDormOptions = new UserDormOptions();
            userDormOptions.setDormData(dormData);
            userDormOptions.setDorm(dorm);
            userDormOptions.setDormRoom(dormRoom);
            userDormOptionsRepository.save(userDormOptions);
        }
    }


//    public List<Long> findMatchingUserIds(DormDto dormDto) {
//        return userDormOptionsRepository.findMatchingUserIds(
//                dormDto.getSchool(),
//                dormDto.getDormitoryNames(),
//                dormDto.getRoomTypes()
//        );
//    }

    private Dorm createDorm(String dormName, School school) {
        Dorm dorm = new Dorm();
        dorm.setDormName(dormName);
        dorm.setSchool(school);
        dormRepository.save(dorm);
        return dorm;
    }

    private DormRoom createDormRoom(String roomType, Dorm dorm) {
        DormRoom dormRoom = new DormRoom();
        dormRoom.setRoomType(roomType);
        dormRoom.setDorm(dorm);
        dormRoomRepository.save(dormRoom);
        return dormRoom;
    }
}


package com.example.roommate.service;

import com.example.roommate.dto.notrented.AreaDto;
import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.notrented.RoomTypeDto;
import com.example.roommate.entity.NonRentedData;
import com.example.roommate.entity.RentalRoom;
import com.example.roommate.entity.User;
import com.example.roommate.entity.WantedRoom;
import com.example.roommate.repository.NonRentedDataRepository;
import com.example.roommate.repository.RentalRoomRepository;
import com.example.roommate.repository.UserRepository;
import com.example.roommate.repository.WantedRoomRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RentService {

    private final NonRentedDataRepository nonRentedDataRepository;

    private final WantedRoomRepository wantedRoomRepository;

    private final RentalRoomRepository rentalRoomRepository;

    private final UserRepository userRepository;

    public void saveNotRentedData(NotRentedDto notRentedDto, Long userId) {

        AreaDto area = notRentedDto.getArea();
//        RoomTypeDto roomType = notRentedDto.getRoomType();

        NonRentedData nonRentedData = new NonRentedData();
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        nonRentedData.setUser(user);
        nonRentedData.setRegionNeLat(area.getRegionNeLat());
        nonRentedData.setRegionNeLng(area.getRegionNeLng());
        nonRentedData.setRegionSwLat(area.getRegionSwLat());
        nonRentedData.setRegionSwLng(area.getRegionSwLng());
        nonRentedData.setRentalPeriod(notRentedDto.getRentalPeriod());

        nonRentedData = nonRentedDataRepository.save(nonRentedData);

        for (RoomTypeDto roomType : notRentedDto.getRoomType()) {

            RentalRoom rentalRoom = rentalRoomRepository.findById(roomType.getTypeId())
                    .orElseThrow(() -> new RuntimeException("Room type not found: " + roomType));

            WantedRoom wantedRoom = new WantedRoom();
            wantedRoom.setLowPrice(roomType.getLow());
            wantedRoom.setHighPrice(roomType.getHigh());
            wantedRoom.setNonRentedData(nonRentedData);
            wantedRoom.setRentalRoom(rentalRoom);

            wantedRoomRepository.save(wantedRoom);
        }
    }

}


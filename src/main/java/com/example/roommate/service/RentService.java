package com.example.roommate.service;

import com.example.roommate.dto.notrented.AreaDto;
import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.notrented.RoomTypeDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.dto.rented.RoomDto;
import com.example.roommate.dto.rented.RoommateDto;
import com.example.roommate.entity.*;
import com.example.roommate.repository.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RentService {

    private final NonRentedDataRepository nonRentedDataRepository;

    private final WantedRoomRepository wantedRoomRepository;

    private final RentalRoomRepository rentalRoomRepository;

    private final UserRepository userRepository;

    private final RentedHouseDataRepository rentedHouseDataRepository;

    private final AvailableRoomRepository availableRoomRepository;

    private final OccupiedRoomRepository occupiedRoomRepository;

    private final ObjectMapper objectMapper;

    public void saveNotRentedData(NotRentedDto notRentedDto, Long userId) {

        AreaDto area = notRentedDto.getArea();

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

    public void saveRentedData(RentedDto rentedDto, Long userId) {
        try {
            RentedHouseData rentedHouseData = new RentedHouseData();
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            rentedHouseData.setUser(user);
            rentedHouseData.setAddressLat(rentedDto.getNeLat());
            rentedHouseData.setAddressLng(rentedDto.getNeLng());
            rentedHouseData.setHouseName(rentedDto.getHouseName());

            String detailsJson = objectMapper.writeValueAsString(rentedDto.getDetails());
            rentedHouseData.setDetails(detailsJson);

            rentedHouseData = rentedHouseDataRepository.save(rentedHouseData);

            for (RoomDto room : rentedDto.getAvailableRooms()) {
                RentalRoom rentalRoom = rentalRoomRepository.findById(room.getRoomType())
                        .orElseThrow(() -> new RuntimeException("Room type not found: " + room.getRoomType()));

                AvailableRoom availableRoom = new AvailableRoom();
                availableRoom.setRentedHouseData(rentedHouseData);
                availableRoom.setRentalRoom(rentalRoom);
                availableRoom.setPrice(room.getPrice());
                availableRoom.setRentalPeriod(room.getPeriod());

                availableRoomRepository.save(availableRoom);
            }

            for (RoommateDto roommate : rentedDto.getCurrentRoommates()) {
                RentalRoom rentalRoom = rentalRoomRepository.findById(roommate.getRoomType())
                        .orElseThrow(() -> new RuntimeException("Room type not found: " + roommate.getRoomType()));

                OccupiedRoom occupiedRoom = new OccupiedRoom();
                occupiedRoom.setRentedHouseData(rentedHouseData);
                occupiedRoom.setRentalRoom(rentalRoom);
                occupiedRoom.setDescription(roommate.getDescription());

                occupiedRoomRepository.save(occupiedRoom);
            }

        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error converting details to JSON", e);
        }
    }

    public List<Long> findMatchingUserIds() {

        List<Long> userIds = new ArrayList<>();

        List<Long> matchingNotRentedUsers = nonRentedDataRepository.findMatchingUsers(
                30L
        );
        userIds.addAll(matchingNotRentedUsers);

        List<Long> matchingRentedUsers = rentedHouseDataRepository.findMatchingUsers(
                30L
        );
        userIds.addAll(matchingRentedUsers);

        return userIds;

    }
}


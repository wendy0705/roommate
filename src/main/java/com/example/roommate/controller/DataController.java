package com.example.roommate.controller;

import com.example.roommate.dto.common.RentalRoomDto;
import com.example.roommate.repository.RoomTypeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@RestController
@RequestMapping("/api/1.0/data")
@RequiredArgsConstructor
public class DataController {

    private final RoomTypeRepository roomTypeRepository;

    @GetMapping("/room-types")
    @ResponseBody
    public ResponseEntity<List<RentalRoomDto>> getAllRoomTypes() {
        List<RentalRoomDto> roomTypes = roomTypeRepository.findAll().stream()
                .map(rentalRoom -> new RentalRoomDto(rentalRoom.getId(), rentalRoom.getRoomType()))
                .collect(Collectors.toList());
        ;
        return ResponseEntity.ok(roomTypes);
    }

}

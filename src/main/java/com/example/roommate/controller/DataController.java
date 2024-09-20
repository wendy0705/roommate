package com.example.roommate.controller;

import com.example.roommate.entity.RentalRoom;
import com.example.roommate.repository.RoomTypeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/1.0/data")
@RequiredArgsConstructor
public class DataController {

    private final RoomTypeRepository roomTypeRepository;

    @GetMapping("/room-types")
    public ResponseEntity<List<RentalRoom>> getAllRoomTypes() {
        List<RentalRoom> roomTypes = roomTypeRepository.findAll();
        log.info("get room types: {}", roomTypes);
        return ResponseEntity.ok(roomTypes);
    }
}

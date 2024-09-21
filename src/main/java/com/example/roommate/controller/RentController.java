package com.example.roommate.controller;

import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.service.RentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/api/1.0/rent")
@RestController
@RequiredArgsConstructor
public class RentController {

    private final RentService rentService;

    @PostMapping("/rented")
    public ResponseEntity<?> saveRentedData(@RequestBody RentedDto rentedDto) {
        log.info("RentController saveRentedData");
        System.out.println(rentedDto);
        rentService.saveRentedData(rentedDto, 42L);
        return ResponseEntity.ok(200);
    }

    @GetMapping("/rented")
    public ResponseEntity<List<Long>> searchRentedMatches() {
        List<Long> matchingUserIds = rentService.findRentedMatches();
        return ResponseEntity.ok(matchingUserIds);
    }

    @PostMapping("/not-rented")
    public ResponseEntity<?> submitNotRented(@RequestBody NotRentedDto notRentedDto) {
        System.out.println(notRentedDto);
        rentService.saveNotRentedData(notRentedDto, 30L);
        return ResponseEntity.ok(200);
    }

    @GetMapping("/not-rented")
    public ResponseEntity<List<Long>> searchNotRentedMatches() {
        List<Long> matchingUserIds = rentService.findNotRentedMatches();
        return ResponseEntity.ok(matchingUserIds);
    }

}

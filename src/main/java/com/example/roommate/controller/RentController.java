package com.example.roommate.controller;

import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.service.RentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequestMapping("/api/1.0/rent")
@RestController
@RequiredArgsConstructor
public class RentController {

    private final RentService rentService;

    @PostMapping("/rented")
    public ResponseEntity<?> saveRentedData(@RequestBody RentedDto rentedDto) {
        System.out.println(rentedDto.toString());
//        rentService.saveRentedData(rentedDto, 49L);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PostMapping("/not-rented")
    public ResponseEntity<?> submitNotRented(@RequestBody NotRentedDto notRentedDto) {
        System.out.println(notRentedDto);
        rentService.saveNotRentedData(notRentedDto, 49L);
        return ResponseEntity.ok(200);
    }

//    @PostMapping("/not-rented/search")
//    public ResponseEntity<List<Long>> searchDormMatches(@RequestBody NotRentedDto notRentedDto) {
//        List<Long> matchingUserIds = dormService.findMatchingUserIds(dormDto);
//        return ResponseEntity.ok(matchingUserIds);
//    }

}

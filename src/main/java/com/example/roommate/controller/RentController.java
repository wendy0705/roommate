package com.example.roommate.controller;

import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.entity.UserMatch;
import com.example.roommate.service.AnalysisService;
import com.example.roommate.service.RentService;
import com.example.roommate.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RequestMapping("/api/1.0/rent")
@RestController
@RequiredArgsConstructor
public class RentController {

    private final RentService rentService;

    private final AnalysisService analysisService;

    private final UserService userService;

    @PostMapping("/rented")
    public ResponseEntity<?> saveRentedData(@RequestBody RentedDto rentedDto) {
        log.info("RentController saveRentedData");
        System.out.println(rentedDto);
        rentService.saveRentedData(rentedDto, 52L);
        return ResponseEntity.ok(200);
    }

    @GetMapping("/rented")
    public ResponseEntity<?> searchRentedMatches() {
        Long myId = 52L;
        List<Long> matchingUserIds = rentService.findRentedMatches(myId);

        for (Long matchingUserId : matchingUserIds) {
            PreferenceDto preferenceDto = userService.getByUserId(matchingUserId);
            Map<String, Object> response = analysisService.analysis(preferenceDto);
            analysisService.save(myId, matchingUserId, response);
        }

        List<UserMatch> matches = analysisService.findByUserId1AndUserIds2(myId, matchingUserIds);
        log.info(matches.toString());
        return ResponseEntity.ok(matches);
    }

    @PostMapping("/not-rented")
    public ResponseEntity<?> submitNotRented(@RequestBody NotRentedDto notRentedDto) {
        System.out.println(notRentedDto);
        rentService.saveNotRentedData(notRentedDto, 54L);
        return ResponseEntity.ok(200);
    }

    @GetMapping("/not-rented")
    public ResponseEntity<?> searchNotRentedMatches() {
        Long myId = 54L;
        List<Long> matchingUserIds = rentService.findNotRentedMatches(myId);

        for (Long matchingUserId : matchingUserIds) {
            PreferenceDto preferenceDto = userService.getByUserId(matchingUserId);
            Map<String, Object> response = analysisService.analysis(preferenceDto);
            analysisService.save(myId, matchingUserId, response);
        }

        List<UserMatch> matches = analysisService.findByUserId1AndUserIds2(myId, matchingUserIds);
        log.info(matches.toString());
        //save
        return ResponseEntity.ok(matches);
    }

}

package com.example.roommate.controller;

import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.repository.NonRentedDataRepository;
import com.example.roommate.repository.RentedHouseDataRepository;
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

    private final NonRentedDataRepository nonRentedDataRepository;

    private final RentedHouseDataRepository rentedHouseDataRepository;

    @PostMapping("/rented/{myId}")
    public ResponseEntity<?> saveRentedData(@RequestBody RentedDto rentedDto, @PathVariable Long myId) {
        System.out.println(rentedDto);
        rentService.saveRentedData(rentedDto, myId); // save basic data
        return ResponseEntity.ok(200);
    }

    @GetMapping("/rented/{myId}")
    public ResponseEntity<?> searchRentedMatches(@PathVariable Long myId) {
        List<Long> matchingUserIds = rentService.findRentedMatches(myId);
        log.info("matching:" + matchingUserIds.toString());
        return ResponseEntity.ok(matchingUserIds);
    }

    @PostMapping("/not-rented/{myId}")
    public ResponseEntity<?> submitNotRented(@RequestBody NotRentedDto notRentedDto, @PathVariable Long myId) {
        rentService.saveNotRentedData(notRentedDto, myId); //save basic data
        return ResponseEntity.ok(200);
    }

    @GetMapping("/not-rented/{myId}")
    public ResponseEntity<?> searchNotRentedMatches(@PathVariable Long myId) {

        Map<Long, Integer> userIdsWithSource = rentService.findNotRentedMatches(myId);
        log.info(userIdsWithSource.toString());
        return ResponseEntity.ok(userIdsWithSource);
    }

//    List<MatchDetailDto> matchDetails = new ArrayList<>();
//    PreferenceDto myIdPreference = userService.getByUserId(myId);
//
//        for(
//    Map.Entry<Long, Integer> entry :userIdsWithSource.entrySet())
//
//    {
//        Long matchingUserId = entry.getKey();
//        Integer source = entry.getValue();
//
//        PreferenceDto othersPreference = userService.getByUserId(matchingUserId);
//        Map<String, Object> response = analysisService.analysis(myIdPreference, othersPreference);
//        analysisService.save(myId, matchingUserId, response);
//
//        UserMatch match = analysisService.findByUserId1AndUserId2(myId, matchingUserId)
//                .orElseThrow(() -> new RuntimeException("UserMatch not found for userId: " + matchingUserId));
//
//        List<NonRentedMatchDto> nonRentedData = null;
//        List<RentedHouseMatchDto> rentedHouseData = null;
//
//        if (source == 0) {
//            nonRentedData = nonRentedDataRepository.getNonRentedInfo(matchingUserId);
//        } else if (source == 1) {
//            rentedHouseData = rentedHouseDataRepository.getRentedHouseInfo(matchingUserId);
//        }
//
//        MatchDetailDto matchDetail = new MatchDetailDto(matchingUserId, match, nonRentedData, rentedHouseData);
//        matchDetails.add(matchDetail);
//    }
//        return ResponseEntity.ok(matchDetails);
//}
}

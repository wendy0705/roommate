package com.example.roommate.controller;

import com.example.roommate.dto.common.MatchDetailDto;
import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.dto.notrented.NonRentedMatchDto;
import com.example.roommate.dto.notrented.NotRentedMatchRequestDto;
import com.example.roommate.dto.rented.RentedHouseMatchDto;
import com.example.roommate.dto.rented.RentedMatchRequestDto;
import com.example.roommate.entity.UserMatch;
import com.example.roommate.repository.NonRentedDataRepository;
import com.example.roommate.repository.RentedHouseDataRepository;
import com.example.roommate.service.AnalysisService;
import com.example.roommate.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@RequestMapping("/api/1.0/analysis")
@RestController
@RequiredArgsConstructor
public class AnalysisController {

    private final UserService userService;
    private final AnalysisService analysisService;
    private final NonRentedDataRepository nonRentedDataRepository;
    private final RentedHouseDataRepository rentedHouseDataRepository;

    @PostMapping("rented/match")
    public ResponseEntity<?> matchPreferences(@RequestParam Long myId, @RequestBody RentedMatchRequestDto matchRequestDto) {

        System.out.println("Received MatchRequestDto: " + matchRequestDto);

        List<MatchDetailDto> matchDetails = new ArrayList<>();
        PreferenceDto myPreference = matchRequestDto.getMyPreference();
        List<Long> matchingUserIds = matchRequestDto.getMatchingUserIds();

        userService.savePreferenceById(myId, myPreference);

        // 遍歷 matchingUserIds 並進行分析
        for (Long matchingUserId : matchingUserIds) {
            PreferenceDto othersPreference = userService.getByUserId(matchingUserId);
            Map<String, Object> response = analysisService.analysis(myPreference, othersPreference);
            log.info("response:" + response.toString());

            // 儲存分析結果
            analysisService.save(myId, matchingUserId, response);

            UserMatch match = analysisService.findByUserId1AndUserId2(myId, matchingUserId)
                    .orElseThrow(() -> new RuntimeException("UserMatch not found for userId: " + matchingUserId));

            List<NonRentedMatchDto> nonRentedData = nonRentedDataRepository.getNonRentedInfo(matchingUserId);
            MatchDetailDto matchDetail = new MatchDetailDto(matchingUserId, match, nonRentedData, null);
            matchDetails.add(matchDetail);
        }
        return ResponseEntity.ok(matchDetails);
    }

    @PostMapping("/not-rented/match")
    public ResponseEntity<?> processNotRentedMatch(@RequestParam Long myId, @RequestBody NotRentedMatchRequestDto matchRequestDto) {

        log.info("Received NotRentedMatchRequestDto: " + matchRequestDto);
        List<MatchDetailDto> matchDetails = new ArrayList<>();
        PreferenceDto myPreference = matchRequestDto.getMyPreference();

        userService.savePreferenceById(myId, myPreference);

        for (Map.Entry<Long, Integer> entry : matchRequestDto.getMatchingUserIds().entrySet()) {
            Long matchingUserId = entry.getKey();
            Integer source = entry.getValue();

            PreferenceDto othersPreference = userService.getByUserId(matchingUserId);
            Map<String, Object> response = analysisService.analysis(myPreference, othersPreference);
            analysisService.save(myId, matchingUserId, response);

            UserMatch match = analysisService.findByUserId1AndUserId2(myId, matchingUserId)
                    .orElseThrow(() -> new RuntimeException("UserMatch not found for userId: " + matchingUserId));

            List<NonRentedMatchDto> nonRentedData = null;
            List<RentedHouseMatchDto> rentedHouseData = null;

            if (source == 0) {
                nonRentedData = nonRentedDataRepository.getNonRentedInfo(matchingUserId);
            } else if (source == 1) {
                rentedHouseData = rentedHouseDataRepository.getRentedHouseInfo(matchingUserId);
            }

            MatchDetailDto matchDetail = new MatchDetailDto(matchingUserId, match, nonRentedData, rentedHouseData);
            matchDetails.add(matchDetail);
        }

        
        return ResponseEntity.ok(matchDetails);
    }
}


//    @PostMapping
//    public ResponseEntity<?> analysisAndSaveSimilarity(@RequestBody PreferenceDto preferenceDto) {
//        userService.createUser(preferenceDto);
//        Map<String, Object> response = analysisService.analysis(preferenceDto);
//        analysisService.save(30L, 49L, response);
//        Map<String, Object> result = new HashMap<>();
//        result.put("data", response);
//        return ResponseEntity.ok(response);
//    }

//    @GetMapping
//    public ResponseEntity<?> getSimilarity(@RequestParam Long userId) {
//        Long myId = 30L;
//        Optional<UserMatch> userMatch = analysisService.findByUserId1AndUserId2(myId, userId);
//
//        if (userMatch.isPresent()) {
//            return ResponseEntity.ok(userMatch.get());
//        } else {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No match found for the given users.");
//        }
//    }



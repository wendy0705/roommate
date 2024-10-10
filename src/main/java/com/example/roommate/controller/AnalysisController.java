package com.example.roommate.controller;

import com.example.roommate.dto.common.AdjustMatchRequestDto;
import com.example.roommate.dto.common.MatchResultDto;
import com.example.roommate.dto.common.SortedMatchResultDto;
import com.example.roommate.dto.habits.InterestDto;
import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.dto.notrented.NonRentedMatchDto;
import com.example.roommate.dto.notrented.NotRentedMatchRequestDto;
import com.example.roommate.dto.rented.AvailableRoomDto;
import com.example.roommate.dto.rented.OccupiedRoomDto;
import com.example.roommate.dto.rented.RentedHouseMatchDto;
import com.example.roommate.dto.rented.RentedMatchRequestDto;
import com.example.roommate.entity.UserMatch;
import com.example.roommate.repository.*;
import com.example.roommate.service.AnalysisService;
import com.example.roommate.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequestMapping("/api/1.0/analysis")
@RestController
@RequiredArgsConstructor
public class AnalysisController {

    private final UserService userService;
    private final AnalysisService analysisService;
    private final NonRentedDataRepository nonRentedDataRepository;
    private final RentedHouseDataRepository rentedHouseDataRepository;
    private final AvailableRoomRepository availableRoomRepository;
    private final OccupiedRoomRepository occupiedRoomRepository;
    private final UserMatchRepository userMatchRepository;

    @PostMapping("rented/match")
    public ResponseEntity<?> matchPreferences(@RequestParam Long myId, @RequestBody RentedMatchRequestDto matchRequestDto) {

        log.info("Received NotRentedMatchRequestDto: " + matchRequestDto);
        List<MatchResultDto> matchResults = new ArrayList<>();
        PreferenceDto myPreference = matchRequestDto.getMyPreference();

        userService.savePreferenceById(myId, myPreference);

        Map<Long, PreferenceDto> userPreferences = new HashMap<>();
        Map<Long, Map<String, Object>> userAnalysisResults = new HashMap<>();

        for (Long matchingUserId : matchRequestDto.getMatchingUserIds()) {

            PreferenceDto othersPreference = userService.getByUserId(matchingUserId);
            if (othersPreference == null) {
                continue;
            }
            userPreferences.put(matchingUserId, othersPreference);

            Map<String, Object> analysisResult = analysisService.analysis(myPreference, othersPreference);
            log.info("Analysis result for userId " + matchingUserId + ": " + analysisResult);
            userAnalysisResults.put(matchingUserId, analysisResult);
        }

        Map<Long, Double> matchScores = new HashMap<>();
        for (Map.Entry<Long, Map<String, Object>> entry : userAnalysisResults.entrySet()) {
            Long matchingUserId = entry.getKey();
            Map<String, Object> analysisResult = entry.getValue();

            double matchScore = analysisService.calculateWeightedMatchScore(analysisResult);
            matchScores.put(matchingUserId, matchScore);
        }

        List<Map.Entry<Long, Double>> sortedMatches = matchScores.entrySet().stream()
                .sorted(Map.Entry.<Long, Double>comparingByValue().reversed())
                .collect(Collectors.toList());

        for (Map.Entry<Long, Double> entry : sortedMatches) {
            Long matchingUserId = entry.getKey();
            Double matchScore = entry.getValue();

            PreferenceDto othersPreference = userPreferences.get(matchingUserId);

            List<NonRentedMatchDto> nonRentedData = nonRentedDataRepository.getNonRentedInfo(matchingUserId);

            analysisService.save(myId, matchingUserId, userAnalysisResults.get(matchingUserId));

            InterestDto commonInterests = analysisService.compareInterests(myPreference.getInterest(), othersPreference.getInterest());

            MatchResultDto matchResult = new MatchResultDto(
                    matchingUserId,
                    commonInterests,
                    null,
                    null,
                    myPreference,
                    othersPreference,
                    matchScore,
                    nonRentedData,
                    null
            );

            matchResults.add(matchResult);
        }

        return ResponseEntity.ok(matchResults);

    }

    @PostMapping("/not-rented/match")
    public ResponseEntity<?> processNotRentedMatch(@RequestParam Long myId, @RequestBody NotRentedMatchRequestDto matchRequestDto) {

        log.info("Received NotRentedMatchRequestDto: " + matchRequestDto);
        List<MatchResultDto> matchResults = new ArrayList<>();
        PreferenceDto myPreference = matchRequestDto.getMyPreference();

        userService.savePreferenceById(myId, myPreference);

        Map<Long, PreferenceDto> userPreferences = new HashMap<>();

        Map<Long, Map<String, Object>> userAnalysisResults = new HashMap<>();

        for (Map.Entry<Long, Integer> entry : matchRequestDto.getMatchingUserIds().entrySet()) {
            Long matchingUserId = entry.getKey();

            PreferenceDto othersPreference = userService.getByUserId(matchingUserId);

            if (othersPreference == null) {
                continue;
            }
            
            userPreferences.put(matchingUserId, othersPreference);

            Map<String, Object> analysisResult = analysisService.analysis(myPreference, othersPreference);
            log.info("Analysis result for userId " + matchingUserId + ": " + analysisResult);
            userAnalysisResults.put(matchingUserId, analysisResult);
        }

        Map<Long, Double> matchScores = new HashMap<>();
        for (Map.Entry<Long, Map<String, Object>> entry : userAnalysisResults.entrySet()) {
            Long matchingUserId = entry.getKey();
            Map<String, Object> analysisResult = entry.getValue();

            double matchScore = analysisService.calculateWeightedMatchScore(analysisResult);
            matchScores.put(matchingUserId, matchScore);
        }

        List<Map.Entry<Long, Double>> sortedMatches = matchScores.entrySet().stream()
                .sorted(Map.Entry.<Long, Double>comparingByValue().reversed())
                .collect(Collectors.toList());

        for (Map.Entry<Long, Double> entry : sortedMatches) {
            Long matchingUserId = entry.getKey();
            Double matchScore = entry.getValue();
            Integer source = matchRequestDto.getMatchingUserIds().get(matchingUserId);

            PreferenceDto othersPreference = userPreferences.get(matchingUserId);

            List<NonRentedMatchDto> nonRentedData = null;
            List<RentedHouseMatchDto> rentedHouseData = null;
            List<AvailableRoomDto> availableRooms = null;
            List<OccupiedRoomDto> occupiedRooms = null;

            if (source == 0) {
                nonRentedData = nonRentedDataRepository.getNonRentedInfo(matchingUserId);
            } else if (source == 1) {
                rentedHouseData = rentedHouseDataRepository.getRentedHouseInfo(matchingUserId);
                availableRooms = availableRoomRepository.getAvailableRooms(matchingUserId);
                occupiedRooms = occupiedRoomRepository.getOccupiedRooms(matchingUserId);
            }

            analysisService.save(myId, matchingUserId, userAnalysisResults.get(matchingUserId));

            InterestDto commonInterests = analysisService.compareInterests(myPreference.getInterest(), othersPreference.getInterest());

            MatchResultDto matchResult = new MatchResultDto(
                    matchingUserId,
                    commonInterests,
                    availableRooms,
                    occupiedRooms,
                    myPreference,
                    othersPreference,
                    matchScore,
                    nonRentedData,
                    rentedHouseData
            );

            matchResults.add(matchResult);
        }

        return ResponseEntity.ok(matchResults);
    }


    @PostMapping("/adjust")
    public ResponseEntity<?> adjustMatchScores(
            @RequestBody AdjustMatchRequestDto adjustRequestDto) {

        Long myId = adjustRequestDto.getMyId();
        List<Long> userIds = adjustRequestDto.getUserIds();

        log.info("Received AdjustMatchRequestDto: " + adjustRequestDto);
        List<SortedMatchResultDto> sortedMatchResults = new ArrayList<>();

        List<Integer> priorities = adjustRequestDto.getPriorityIndicators();
        if (priorities == null || priorities.size() != 3) {
            return ResponseEntity.badRequest().body("You must select exactly three priority indicators.");
        }

        Map<Long, Double> matchScores = new HashMap<>();
        for (Long matchingUserId : userIds) {

            log.info(myId + ": " + matchingUserId);

            UserMatch match = userMatchRepository.findByUserId1AndUserId2(myId, matchingUserId)
                    .orElseThrow(() -> new RuntimeException("UserMatch not found for userId: " + matchingUserId));


            double matchScore = analysisService.calculateWeightedMatchScore(match, priorities);

            matchScores.put(matchingUserId, matchScore);
        }

        log.info(matchScores.toString());

        List<Map.Entry<Long, Double>> sortedMatches = matchScores.entrySet().stream()
                .sorted(Map.Entry.<Long, Double>comparingByValue().reversed())
                .collect(Collectors.toList());

        for (Map.Entry<Long, Double> entry : sortedMatches) {
            Long matchingUserId = entry.getKey();
            Double matchScore = entry.getValue();

            SortedMatchResultDto sortedResult = new SortedMatchResultDto(matchingUserId, matchScore);
            sortedMatchResults.add(sortedResult);
        }

        log.info(sortedMatches.toString());

        return ResponseEntity.ok(sortedMatchResults);
    }
}





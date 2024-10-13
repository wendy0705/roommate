package com.example.roommate.controller;

import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.repository.NonRentedDataRepository;
import com.example.roommate.repository.RentedHouseDataRepository;
import com.example.roommate.service.AnalysisService;
import com.example.roommate.service.RentService;
import com.example.roommate.service.UserService;
import com.example.roommate.utils.JwtUtils;
import jakarta.servlet.http.HttpServletRequest;
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

    private final JwtUtils jwtUtils;

    @PostMapping("/rented")
    public ResponseEntity<?> saveRentedData(@RequestBody RentedDto rentedDto, HttpServletRequest request) {

        Long myId = (Long) request.getAttribute("userId");

        // 保存基本數據，將 myId 傳遞給 service
        rentService.saveRentedData(rentedDto, myId);
        return ResponseEntity.ok(200);

    }


    @GetMapping("/rented")
    public ResponseEntity<?> searchRentedMatches(HttpServletRequest request) {

        Long myId = (Long) request.getAttribute("userId"); // 提取 userId

        // 使用 myId 查找 matchingUserIds
        List<Long> matchingUserIds = rentService.findRentedMatches(myId);
        log.info("matching: " + matchingUserIds.toString());

        return ResponseEntity.ok(matchingUserIds);

    }


    @PostMapping("/not-rented")
    public ResponseEntity<?> submitNotRented(@RequestBody NotRentedDto notRentedDto, HttpServletRequest request) {

        // 從 HttpServletRequest 中提取 userId
        Long myId = (Long) request.getAttribute("userId");

        // 保存基本數據，將 myId 傳遞給 service
        rentService.saveNotRentedData(notRentedDto, myId);
        return ResponseEntity.ok(200);
    }


    @GetMapping("/not-rented")
    public ResponseEntity<?> searchNotRentedMatches(HttpServletRequest request) {

        // 從 HttpServletRequest 中提取 userId
        Long myId = (Long) request.getAttribute("userId");

        // 使用 myId 查找匹配的用戶
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

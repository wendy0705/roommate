package com.example.roommate.controller;

import com.example.roommate.dto.notrented.NotRentedDto;
import com.example.roommate.dto.rented.RentedDto;
import com.example.roommate.service.RentService;
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

}

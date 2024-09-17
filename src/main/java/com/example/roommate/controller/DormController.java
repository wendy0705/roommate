package com.example.roommate.controller;

import com.example.roommate.dto.DormDto;
import com.example.roommate.service.DormService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping
@RestController
@RequiredArgsConstructor
public class DormController {

    private final DormService dormService;

    @PostMapping("/submitDormData")
    public ResponseEntity<?> aveAndFindMatchingUsers(@RequestBody DormDto dormDto) {

//        dormService.saveDormData(dormDto, 51L);
        List<Long> matchingUserIds = dormService.findMatchingUserIds(dormDto);
        return ResponseEntity.ok(matchingUserIds);
//        boolean isMatchFound = dormService.compareDormData(appliedDorm, school, dormitoryName, roomType);
//        if (isMatchFound) {
//            return ResponseEntity.ok("已找到相似宿舍資料！");
//        } else {
//            return ResponseEntity.ok("沒有找到相似的宿舍資料。");
//        }
    }
}

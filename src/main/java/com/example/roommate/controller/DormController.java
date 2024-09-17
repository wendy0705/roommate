package com.example.roommate.controller;

import com.example.roommate.dto.DormDto;
import com.example.roommate.service.DormService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping
@RestController
public class DormController {

    private DormService dormService;

    @PostMapping("/submitDormData")
    public ResponseEntity<?> aveAndFindMatchingUsers(@RequestBody DormDto dormDto) {
//        dormService.saveDormData(dormDto);
//        List<Long> matchingUserIds = dormService.findMatchingUserIds(dormDto);
        return ResponseEntity.ok("ok");
//        boolean isMatchFound = dormService.compareDormData(appliedDorm, school, dormitoryName, roomType);
//        if (isMatchFound) {
//            return ResponseEntity.ok("已找到相似宿舍資料！");
//        } else {
//            return ResponseEntity.ok("沒有找到相似的宿舍資料。");
//        }
    }
}

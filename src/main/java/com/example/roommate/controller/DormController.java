package com.example.roommate.controller;

import com.example.roommate.dto.dorm.DormDto;
import com.example.roommate.service.DormService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping("/api/1.0/dorm")
@RestController
@RequiredArgsConstructor
public class DormController {

    private final DormService dormService;

    @PostMapping
    public ResponseEntity<?> saveDormData(@RequestBody DormDto dormDto) {
        dormService.saveDormData(dormDto, 51L);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PostMapping("/search")
    public ResponseEntity<List<Long>> searchDormMatches() {
        List<Long> matchingUserIds = dormService.findMatchingUserIds(3L);
        return ResponseEntity.ok(matchingUserIds);
    }

}

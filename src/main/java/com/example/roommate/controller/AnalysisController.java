package com.example.roommate.controller;

import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.entity.UserMatch;
import com.example.roommate.service.AnalysisService;
import com.example.roommate.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@Slf4j
@RequestMapping("/api/1.0/analysis")
@RestController
@RequiredArgsConstructor
public class AnalysisController {

    private final UserService userService;
    private final AnalysisService analysisService;

    @PostMapping
    public ResponseEntity<?> analysisAndSaveSimilarity(@RequestBody PreferenceDto preferenceDto) {
        userService.createUser(preferenceDto);
        Map<String, Object> response = analysisService.analysis(preferenceDto);
//        analysisService.save(30L, 49L, response);
//        Map<String, Object> result = new HashMap<>();
//        result.put("data", response);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<?> getSimilarity(@RequestParam Long userId) {
        Long myId = 30L;
        Optional<UserMatch> userMatch = analysisService.findByUserId1AndUserId2(myId, userId);

        if (userMatch.isPresent()) {
            return ResponseEntity.ok(userMatch.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No match found for the given users.");
        }
    }

}


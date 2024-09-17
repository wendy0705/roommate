package com.example.roommate.controller;

import com.example.roommate.dto.PreferenceDto;
import com.example.roommate.service.SimilarityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequestMapping("/data")
@RestController
@RequiredArgsConstructor
public class SimilarityController {

    private final SimilarityService similarityService;

    @PostMapping("/similarity")
    public ResponseEntity<?> getResult(@RequestBody PreferenceDto preferenceDto) {
        Map<String, Object> response = similarityService.analysis(preferenceDto);
        Map<String, Object> result = new HashMap<>();
        result.put("data", response);
        return ResponseEntity.ok(result);
    }

//    @PostMapping("/weight")
//    public ResponseEntity<?> getweightedResult() {
//
//        return ResponseEntity.ok(result);
//    }

}


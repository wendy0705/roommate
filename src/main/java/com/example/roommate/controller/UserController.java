package com.example.roommate.controller;

import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/1.0/users")
public class UserController {

    private final UserService userService;

    @GetMapping("/{userId}")
    public ResponseEntity<PreferenceDto> getUserPreferences(@PathVariable Long userId) {
        PreferenceDto preferenceDto = userService.getByUserId(userId);
        return ResponseEntity.ok(preferenceDto);
    }
}


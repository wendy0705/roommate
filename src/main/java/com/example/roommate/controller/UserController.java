package com.example.roommate.controller;

import com.example.roommate.dto.habits.PreferenceDto;
import com.example.roommate.service.UserService;
import com.example.roommate.utils.JwtUtils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/1.0/users")
public class UserController {

    private final UserService userService;
    private final JwtUtils jwtUtils;

    @GetMapping("/{userId}")
    public ResponseEntity<PreferenceDto> getUserPreferences(@PathVariable Long userId) {
        PreferenceDto preferenceDto = userService.getByUserId(userId);
        return ResponseEntity.ok(preferenceDto);
    }

    @GetMapping("/user-info")
    public ResponseEntity<?> getUserInfo(HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        if (userId != null) {
            log.info("Current User ID: {}", userId);
            return ResponseEntity.ok(userId);
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not authenticated");
    }

    @GetMapping("/{userId}/name")
    public ResponseEntity<String> getUserName(@PathVariable Long userId) {
        Optional<String> nameOpt = userService.getUserNameById(userId);
        String name = nameOpt.orElse("Unknown User");

        return ResponseEntity.ok(name);
    }

}


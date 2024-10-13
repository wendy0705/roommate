package com.example.roommate.controller;

import com.example.roommate.entity.User;
import com.example.roommate.service.UserService;
import com.example.roommate.utils.JwtUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/1.0/auth")
public class AuthController {

    private final UserService userService;
    private final JwtUtils jwtUtils;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SignupRequest {
        @Valid
        private String email;
        @Valid
        private String password;
        @Valid
        private String name;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class LoginRequest {
        private String email;
        private String password;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class JwtResponse {
        private String token;
        private String type = "Bearer";

        public JwtResponse(String accessToken) {
            this.token = accessToken;
        }
    }

    // 註冊端點
    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest, HttpServletResponse response) {
        try {
            User user = userService.registerUser(
                    signUpRequest.getEmail(),
                    signUpRequest.getPassword(),
                    signUpRequest.getName()
            );

            // 註冊成功後生成 JWT Token
            String jwt = jwtUtils.generateJwtToken(user.getId(), user.getEmail());

            // 將 JWT Token 存入 Cookie
            Cookie cookie = new Cookie("JWT_TOKEN", jwt);
            cookie.setHttpOnly(false); // 防止 JavaScript 訪問
            cookie.setSecure(false);  // 僅在 HTTPS 下傳輸
            cookie.setMaxAge(-1);     // Session cookie
            cookie.setPath("/");      // Cookie 對整個應用程式可見

            response.addCookie(cookie);

            return ResponseEntity.ok(new JwtResponse("Signup successful"));
        } catch (Exception e) {
            return ResponseEntity
                    .badRequest()
                    .body(e.getMessage());
        }
    }

    // 登入端點
    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest, HttpServletResponse response) {
        Optional<User> userOpt = userService.findByEmail(loginRequest.getEmail());

        // 檢查用戶是否存在以及密碼是否正確
        if (userOpt.isPresent() && userService.authenticate(loginRequest.getEmail(), loginRequest.getPassword())) {
            User user = userOpt.get();
            Long userId = user.getId(); // 獲取自動生成的 userId
            String jwt = jwtUtils.generateJwtToken(userId, user.getEmail()); // 傳入 userId 和 email

            Cookie cookie = new Cookie("JWT_TOKEN", jwt);
            cookie.setHttpOnly(false); // 防止 JavaScript 訪問
            cookie.setSecure(false); // 僅在 HTTPS 下傳輸
            cookie.setMaxAge(-1); // session cookie，瀏覽器關閉後消失
            cookie.setPath("/"); // Cookie 對整個應用程式可見

            response.addCookie(cookie);

            return ResponseEntity.ok(new JwtResponse("Login successful"));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
        }
    }
}

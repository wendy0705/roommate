package com.example.roommate.filter;


import com.example.roommate.service.UserService;
import com.example.roommate.utils.JwtUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtils jwtUtils;
    private final UserService userService;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        log.info("JwtAuthenticationFilter is running for URL: {}", request.getRequestURI());
        String token = null;
        String email = null;
        Long userId;

        // 從 Cookie 中讀取 JWT Token
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("JWT_TOKEN".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token != null) {
            log.info("Found token: {}", token);
            if (jwtUtils.validateJwtToken(token)) {
                email = jwtUtils.getEmailFromJwtToken(token);
                userId = jwtUtils.getUserIdFromJwtToken(token);
                log.info("Email extracted from token: {}", email);
                log.info("User ID extracted from token: {}", userId);

                // 將 userId 或其他資訊設置到 HttpServletRequest
                request.setAttribute("userId", userId);
            }
        }

        log.info("Email: {}", email);

        if (email == null) {
            log.info("Unauthorized access, redirecting to /auth");
            response.sendRedirect("/auth");
            return;
        }

        filterChain.doFilter(request, response);
    }
}

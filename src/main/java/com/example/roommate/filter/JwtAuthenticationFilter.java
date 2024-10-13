package com.example.roommate.filter;


import com.example.roommate.service.UserService;
import com.example.roommate.utils.JwtUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
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
        String header = request.getHeader(HttpHeaders.AUTHORIZATION);
        String token;
        String email = null;


        if (header != null && header.startsWith("Bearer ")) {
            token = header.substring(7);
            log.info(token);
            if (jwtUtils.validateJwtToken(token)) {
                email = jwtUtils.getEmailFromJwtToken(token);
                log.info(email); //test@gmail.com
            }
        }

        log.info(email);

        if (email == null) {
            log.info("Unauthorized access, redirecting to /auth");
            response.sendRedirect("/auth");
            return;
        }

        filterChain.doFilter(request, response);
    }
}


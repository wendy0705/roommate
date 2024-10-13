package com.example.roommate;

import com.example.roommate.filter.JwtAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

@RequiredArgsConstructor
@SpringBootApplication
public class RoommateApplication {

    public static void main(String[] args) {
        SpringApplication.run(RoommateApplication.class, args);
    }

    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public FilterRegistrationBean<JwtAuthenticationFilter> jwtFilter() {
        FilterRegistrationBean<JwtAuthenticationFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(jwtAuthenticationFilter);
        registrationBean.setOrder(1);

        registrationBean.addUrlPatterns(
                "/api/1.0/users/*",
                "/mainpage",
                "/api/1.0/rent/*",
                "/habits",
                "/api/1.0/analysis/*",
                "/not-rented-matched",
                "/rented-matched",
                "/js/chat.js",
                "/js/compare.js",
                "/js/header.js",
                "/js/rented-matched.js",
                "/js/not-rented-matched.js",
                "/header",
                "/css/matched.css",
                "/css/chat.css",
                "/css/header.css",
                "/favicon.icon"
        );


        return registrationBean;
    }

}

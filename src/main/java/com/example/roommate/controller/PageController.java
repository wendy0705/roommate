package com.example.roommate.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@RequestMapping
@Controller
public class PageController {

    @Value("${google.maps.api.key}")
    private String googleMapsApiKey;

    @GetMapping("/habits")
    public String showHabits() {
        return "habits";
    }

    @GetMapping("/test")
    public String showBasic() {
        return "test";
    }

    @GetMapping("/rental-form")
    public String showRentalForm(@RequestParam(name = "status", required = false) String status, Model model) {
        model.addAttribute("status", status);

        if ("rented".equals(status)) {
            model.addAttribute("mapType", "marker"); // 已經找到房子，使用標記
        } else if ("not_rented".equals(status)) {
            model.addAttribute("mapType", "drawing"); // 未找到房子，使用框選
        } else {
            model.addAttribute("mapType", "drawing"); // 無選擇
        }

        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "rental-form"; // 主模板頁面
    }

    @GetMapping("/header")
    public String showHeader() {
        return "header";
    }

    @GetMapping("/mainpage")
    public String showMainpage() {
        return "mainpage";
    }

    @GetMapping("/rented-matched")
    public String showRentedMatchedUsers() {
        return "rented-matched";
    }

    @GetMapping("/not-rented-matched")
    public String showNotRentedMatchedUsers() {
        return "not-rented-matched";
    }
}

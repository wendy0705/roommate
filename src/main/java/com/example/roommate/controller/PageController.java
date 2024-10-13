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

    @Value("${websocket.url}")
    private String websocketUrl;

    @Value("${chatservice.host}")
    private String chatServiceHost;

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
        return "mainpage"; // 如果驗證成功，繼續顯示主頁面
    }


    @GetMapping("/rented-matched")
    public String showRentedMatchedUsers(Model model) {
        model.addAttribute("chatServiceHost", chatServiceHost);
        model.addAttribute("websocketUrl", websocketUrl);
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "rented-matched";
    }

    @GetMapping("/not-rented-matched")
    public String showNotRentedMatchedUsers(Model model) {
        model.addAttribute("chatServiceHost", chatServiceHost);
        model.addAttribute("websocketUrl", websocketUrl);
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "not-rented-matched";
    }

    @GetMapping("/compare")
    public String showCompare() {
        return "compare";
    }

    @GetMapping("/auth")
    public String showAuth() {
        return "auth";
    }
}

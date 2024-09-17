package com.example.roommate.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @Value("${google.maps.api.key}")
    private String googleMapsApiKey;

    @GetMapping("/map")
    public String showMap(Model model) {
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "map";
    }

    @GetMapping("/habits")
    public String showHabits() {
        return "habits";
    }

    @GetMapping("/basic")
    public String showBasic() {
        return "basic";
    }

}

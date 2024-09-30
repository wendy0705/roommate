package com.example.roommate.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping
@Controller
public class PageController {

    @Value("${google.maps.api.key}")
    private String googleMapsApiKey;

//    @GetMapping("/map")
//    public String showMap(Model model) {
//        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
//        return "map";
//    }

    @GetMapping("/habits")
    public String showHabits() {
        return "habits";
    }

    @GetMapping("/test")
    public String showBasic() {
        return "test";
    }

    @GetMapping("/not-rented")
    public String showNotRentedForm(Model model) {
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "not-rented";
    }

    @GetMapping("/rented")
    public String showRentedForm(Model model) {
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "rented";
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

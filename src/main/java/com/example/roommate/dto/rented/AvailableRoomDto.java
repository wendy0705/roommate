package com.example.roommate.dto.rented;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AvailableRoomDto {
    private Integer price;
    private String roomType;
}

package com.example.roommate.dto.rented;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OccupiedRoomDto {
    private String description;
    private String roomType;
}

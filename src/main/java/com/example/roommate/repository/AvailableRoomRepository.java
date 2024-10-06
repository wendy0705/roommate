package com.example.roommate.repository;

import com.example.roommate.dto.rented.AvailableRoomDto;
import com.example.roommate.entity.AvailableRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AvailableRoomRepository extends JpaRepository<AvailableRoom, Long> {

    @Query("SELECT new com.example.roommate.dto.rented.AvailableRoomDto(a.price, rm.roomType) " +
            "FROM AvailableRoom a " +
            "JOIN a.rentalRoom rm " +
            "WHERE a.rentedHouseData.user.id = :userId")
    List<AvailableRoomDto> getAvailableRooms(@Param("userId") Long userId);

}


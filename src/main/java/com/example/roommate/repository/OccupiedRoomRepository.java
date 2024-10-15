package com.example.roommate.repository;

import com.example.roommate.dto.rented.OccupiedRoomDto;
import com.example.roommate.entity.OccupiedRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OccupiedRoomRepository extends JpaRepository<OccupiedRoom, Long> {

    @Query("SELECT new com.example.roommate.dto.rented.OccupiedRoomDto(o.description, rm2.roomType) " +
            "FROM OccupiedRoom o " +
            "JOIN o.rentalRoom rm2 " +
            "WHERE o.rentedHouseData.user.id = :userId")
    List<OccupiedRoomDto> getOccupiedRooms(@Param("userId") Long userId);

    void deleteByRentedHouseDataId(Long rentedHouseDataId);

}


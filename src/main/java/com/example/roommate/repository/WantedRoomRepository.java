package com.example.roommate.repository;

import com.example.roommate.entity.WantedRoom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WantedRoomRepository extends JpaRepository<WantedRoom, Long> {

    void deleteByNonRentedDataId(Long userId);
    
}
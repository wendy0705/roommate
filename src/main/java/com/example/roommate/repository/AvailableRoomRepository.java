package com.example.roommate.repository;

import com.example.roommate.entity.AvailableRoom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AvailableRoomRepository extends JpaRepository<AvailableRoom, Long> {
}


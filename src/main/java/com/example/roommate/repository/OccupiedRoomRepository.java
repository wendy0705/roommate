package com.example.roommate.repository;

import com.example.roommate.entity.OccupiedRoom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OccupiedRoomRepository extends JpaRepository<OccupiedRoom, Long> {
}


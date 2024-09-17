package com.example.roommate.repository;

import com.example.roommate.entity.DormRoom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DormRoomRepository extends JpaRepository<DormRoom, Long> {
}

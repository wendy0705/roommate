package com.example.roommate.repository;

import com.example.roommate.entity.RentalRoom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomTypeRepository extends JpaRepository<RentalRoom, Long> {

}

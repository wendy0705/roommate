package com.example.roommate.repository;


import com.example.roommate.entity.DormData;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DormDataRepository extends JpaRepository<DormData, Long> {
}

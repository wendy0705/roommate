package com.example.roommate.repository;

import com.example.roommate.entity.Dorm;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DormRepository extends JpaRepository<Dorm, Long> {
}

package com.example.roommate.repository;

import com.example.roommate.entity.School;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SchoolRepository extends JpaRepository<School, Long> {

    School findByName(String schoolName);
}


package com.example.roommate.repository;

import com.example.roommate.entity.NonRentedData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface NonRentedDataRepository extends JpaRepository<NonRentedData, Long> {

    @Query("SELECT n2.user.id FROM NonRentedData n1 " +
            "JOIN NonRentedData n2 ON " +
            "n1.regionSwLng < n2.regionNeLng " +
            "AND n1.regionNeLng > n2.regionSwLng " +
            "AND n1.regionSwLat < n2.regionNeLat " +
            "AND n1.regionNeLat > n2.regionSwLat " +
            "AND n1.rentalPeriod >= n2.rentalPeriod " +
            "WHERE n1.user.id = :currentUserId " +
            "AND n1.user.id <> n2.user.id")
    List<Long> findMatchingUsers(

            @Param("currentUserId") Long currentUserId
    );
}


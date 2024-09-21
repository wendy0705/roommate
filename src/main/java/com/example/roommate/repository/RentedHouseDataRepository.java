package com.example.roommate.repository;

import com.example.roommate.entity.RentedHouseData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RentedHouseDataRepository extends JpaRepository<RentedHouseData, Long> {

    @Query("SELECT DISTINCT r.user.id FROM RentedHouseData r " +
            "JOIN r.availableRooms ar " +
            "JOIN NonRentedData n ON n.user.id = :currentUserId " +
            "WHERE r.addressLat BETWEEN n.regionSwLat AND n.regionNeLat " +
            "AND r.addressLng BETWEEN n.regionSwLng AND n.regionNeLng " +
            "AND ar.price BETWEEN (SELECT MIN(wr.lowPrice) FROM WantedRoom wr WHERE wr.rentalRoom.id = ar.rentalRoom.id AND wr.nonRentedData.id = n.id) " +
            "AND (SELECT MAX(wr.highPrice) FROM WantedRoom wr WHERE wr.rentalRoom.id = ar.rentalRoom.id AND wr.nonRentedData.id = n.id) " +
            "AND ar.rentalPeriod <= n.rentalPeriod " +
            "AND r.user.id <> :currentUserId")
    List<Long> findMatchingUsers(@Param("currentUserId") Long currentUserId);

}


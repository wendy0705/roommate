package com.example.roommate.repository;

import com.example.roommate.dto.notrented.NonRentedMatchDto;
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

    @Query("SELECT DISTINCT n.user.id FROM NonRentedData n " +
            "JOIN WantedRoom wr ON wr.nonRentedData.id = n.id " +
            "JOIN RentedHouseData r ON r.user.id = :currentUserId " +
            "JOIN r.availableRooms ar " +
            "WHERE r.addressLat BETWEEN n.regionSwLat AND n.regionNeLat " +
            "AND r.addressLng BETWEEN n.regionSwLng AND n.regionNeLng " +
            "AND ar.rentalRoom.id = wr.rentalRoom.id " +
            "AND ar.price BETWEEN wr.lowPrice AND wr.highPrice " +
            "AND ar.rentalPeriod <= n.rentalPeriod " +
            "AND n.user.id <> :currentUserId")
    List<Long> findNotRentedMatches(@Param("currentUserId") Long currentUserId);

    @Query("SELECT new com.example.roommate.dto.notrented.NonRentedMatchDto(n.regionNeLat, n.regionNeLng, n.regionSwLat, n.regionSwLng, " +
            "n.rentalPeriod, w.lowPrice, w.highPrice, r.roomType) " +
            "FROM NonRentedData n " +
            "JOIN WantedRoom w ON n.id = w.nonRentedData.id " +
            "JOIN RentalRoom r ON w.rentalRoom.id = r.id " +
            "WHERE n.user.id = :userId")
    List<NonRentedMatchDto> getNonRentedInfo(@Param("userId") Long userId);

    List<NonRentedData> findByUserId(Long userId);

    void deleteByUserId(Long userId);
}


package com.example.roommate.repository;

import com.example.roommate.entity.UserDormOptions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserDormOptionsRepository extends JpaRepository<UserDormOptions, Long> {

    @Query("SELECT DISTINCT u2.id " +
            "FROM User u1 " +
            "JOIN u1.dormData dd1 " +
            "JOIN dd1.school s " +
            "JOIN dd1.userDormOptions udo1 " +
            "JOIN udo1.dorm d " +
            "JOIN udo1.dormRoom dr " +
            "JOIN UserDormOptions udo2 ON udo1.dorm = udo2.dorm AND udo1.dormRoom = udo2.dormRoom " +
            "JOIN udo2.dormData dd2 " +
            "JOIN dd2.user u2 " +
            "WHERE s.id = :schoolId " +
            "AND d.id IN :dormitoryIds " +
            "AND dr.id IN :roomTypesIds " +
            "AND u1.id <> u2.id")
    List<Long> findMatchingUserIds(@Param("schoolId") Long schoolId,
                                   @Param("dormitoryIds") List<Long> dormitoryIds,
                                   @Param("roomTypesIds") List<Long> roomTypesIds);

}


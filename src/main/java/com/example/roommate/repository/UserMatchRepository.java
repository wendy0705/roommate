package com.example.roommate.repository;

import com.example.roommate.entity.UserMatch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserMatchRepository extends JpaRepository<UserMatch, Long> {
    Optional<UserMatch> findByUserId1AndUserId2(Long myId, Long userId);

    List<UserMatch> findByUserId1AndUserId2In(Long myId, List<Long> userIds);
}


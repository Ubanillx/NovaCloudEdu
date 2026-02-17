package com.novacloudedu.backend.domain.membership.repository;

import com.novacloudedu.backend.domain.membership.entity.UserMembership;
import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;

import java.util.List;
import java.util.Optional;

public interface UserMembershipRepository {

    UserMembership save(UserMembership membership);

    Optional<UserMembership> findById(Long id);

    Optional<UserMembership> findByOrderNo(String orderNo);

    Optional<UserMembership> findActiveByUserId(UserId userId);

    Optional<UserMembership> findLatestByUserId(UserId userId);

    List<UserMembership> findByUserId(UserId userId);

    List<UserMembership> findByStatus(MembershipStatus status, int page, int size);

    long countByStatus(MembershipStatus status);

    List<UserMembership> findExpiredActive();
}

package com.novacloudedu.backend.domain.membership.entity;

import com.novacloudedu.backend.domain.membership.valueobject.MembershipStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户会员聚合根
 */
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserMembership {

    private Long id;
    private UserId userId;
    private Long planId;
    private String orderNo;
    private LocalDateTime startTime;
    private LocalDateTime expireTime;
    private MembershipStatus status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    public static UserMembership create(UserId userId, Long planId, String orderNo,
                                        LocalDateTime startTime, LocalDateTime expireTime) {
        UserMembership membership = new UserMembership();
        membership.userId = userId;
        membership.planId = planId;
        membership.orderNo = orderNo;
        membership.startTime = startTime;
        membership.expireTime = expireTime;
        membership.status = MembershipStatus.PENDING;
        membership.isDelete = false;
        membership.createTime = LocalDateTime.now();
        membership.updateTime = LocalDateTime.now();
        return membership;
    }

    public static UserMembership createActive(UserId userId, Long planId, String orderNo,
                                               LocalDateTime startTime, LocalDateTime expireTime) {
        UserMembership membership = create(userId, planId, orderNo, startTime, expireTime);
        membership.status = MembershipStatus.ACTIVE;
        return membership;
    }

    public static UserMembership reconstruct(Long id, UserId userId, Long planId, String orderNo,
                                              LocalDateTime startTime, LocalDateTime expireTime,
                                              MembershipStatus status,
                                              LocalDateTime createTime, LocalDateTime updateTime,
                                              boolean isDelete) {
        UserMembership membership = new UserMembership();
        membership.id = id;
        membership.userId = userId;
        membership.planId = planId;
        membership.orderNo = orderNo;
        membership.startTime = startTime;
        membership.expireTime = expireTime;
        membership.status = status;
        membership.createTime = createTime;
        membership.updateTime = updateTime;
        membership.isDelete = isDelete;
        return membership;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("会员ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void activate() {
        if (this.status != MembershipStatus.PENDING) {
            throw new IllegalStateException("只有待支付的会员才能激活");
        }
        this.status = MembershipStatus.ACTIVE;
        this.startTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    public void activateWithExpiry(int durationDays) {
        activate();
        if (durationDays > 0) {
            this.expireTime = this.startTime.plusDays(durationDays);
        }
    }

    public void expire() {
        if (this.status != MembershipStatus.ACTIVE) {
            throw new IllegalStateException("只有生效中的会员才能过期");
        }
        this.status = MembershipStatus.EXPIRED;
        this.updateTime = LocalDateTime.now();
    }

    public void cancel() {
        this.status = MembershipStatus.CANCELLED;
        this.updateTime = LocalDateTime.now();
    }

    public boolean isActive() {
        return this.status == MembershipStatus.ACTIVE
                && (this.expireTime == null || this.expireTime.isAfter(LocalDateTime.now()));
    }

    public boolean isExpired() {
        return this.status == MembershipStatus.EXPIRED
                || (this.status == MembershipStatus.ACTIVE
                    && this.expireTime != null
                    && this.expireTime.isBefore(LocalDateTime.now()));
    }
}

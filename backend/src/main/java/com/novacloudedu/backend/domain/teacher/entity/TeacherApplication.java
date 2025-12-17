package com.novacloudedu.backend.domain.teacher.entity;

import com.novacloudedu.backend.domain.teacher.valueobject.TeacherStatus;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class TeacherApplication {

    private Long id;
    private UserId userId;
    private String name;
    private String introduction;
    private List<String> expertise;
    private String certificateUrl;
    private TeacherStatus status;
    private String rejectReason;
    private UserId reviewerId;
    private LocalDateTime reviewTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static TeacherApplication create(UserId userId, String name, String introduction, 
                                           List<String> expertise, String certificateUrl) {
        TeacherApplication application = new TeacherApplication();
        application.userId = userId;
        application.name = name;
        application.introduction = introduction;
        application.expertise = expertise;
        application.certificateUrl = certificateUrl;
        application.status = TeacherStatus.PENDING;
        application.createTime = LocalDateTime.now();
        application.updateTime = LocalDateTime.now();
        return application;
    }

    public static TeacherApplication reconstruct(Long id, UserId userId, String name, 
                                                String introduction, List<String> expertise,
                                                String certificateUrl, TeacherStatus status,
                                                String rejectReason, UserId reviewerId,
                                                LocalDateTime reviewTime, LocalDateTime createTime,
                                                LocalDateTime updateTime) {
        TeacherApplication application = new TeacherApplication();
        application.id = id;
        application.userId = userId;
        application.name = name;
        application.introduction = introduction;
        application.expertise = expertise;
        application.certificateUrl = certificateUrl;
        application.status = status;
        application.rejectReason = rejectReason;
        application.reviewerId = reviewerId;
        application.reviewTime = reviewTime;
        application.createTime = createTime;
        application.updateTime = updateTime;
        return application;
    }

    public void assignId(Long id) {
        if (this.id != null) {
            throw new IllegalStateException("申请ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void approve(UserId reviewerId) {
        if (this.status != TeacherStatus.PENDING) {
            throw new IllegalStateException("只有待审核的申请才能通过");
        }
        this.status = TeacherStatus.APPROVED;
        this.reviewerId = reviewerId;
        this.reviewTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    public void reject(UserId reviewerId, String reason) {
        if (this.status != TeacherStatus.PENDING) {
            throw new IllegalStateException("只有待审核的申请才能拒绝");
        }
        this.status = TeacherStatus.REJECTED;
        this.rejectReason = reason;
        this.reviewerId = reviewerId;
        this.reviewTime = LocalDateTime.now();
        this.updateTime = LocalDateTime.now();
    }

    public boolean isPending() {
        return this.status == TeacherStatus.PENDING;
    }

    public boolean isApproved() {
        return this.status == TeacherStatus.APPROVED;
    }
}

package com.novacloudedu.backend.domain.teacher.entity;

import com.novacloudedu.backend.domain.teacher.valueobject.TeacherId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Teacher {

    private TeacherId id;
    private String name;
    private String introduction;
    private List<String> expertise;
    private UserId userId;
    private UserId adminId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public static Teacher create(String name, String introduction, List<String> expertise, UserId userId, UserId adminId) {
        Teacher teacher = new Teacher();
        teacher.name = name;
        teacher.introduction = introduction;
        teacher.expertise = expertise;
        teacher.userId = userId;
        teacher.adminId = adminId;
        teacher.createTime = LocalDateTime.now();
        teacher.updateTime = LocalDateTime.now();
        return teacher;
    }

    public static Teacher reconstruct(TeacherId id, String name, String introduction, 
                                     List<String> expertise, UserId userId, UserId adminId,
                                     LocalDateTime createTime, LocalDateTime updateTime) {
        Teacher teacher = new Teacher();
        teacher.id = id;
        teacher.name = name;
        teacher.introduction = introduction;
        teacher.expertise = expertise;
        teacher.userId = userId;
        teacher.adminId = adminId;
        teacher.createTime = createTime;
        teacher.updateTime = updateTime;
        return teacher;
    }

    public void assignId(TeacherId id) {
        if (this.id != null) {
            throw new IllegalStateException("讲师ID已分配，不可重复分配");
        }
        this.id = id;
    }

    public void updateInfo(String name, String introduction, List<String> expertise) {
        this.name = name;
        this.introduction = introduction;
        this.expertise = expertise;
        this.updateTime = LocalDateTime.now();
    }
}

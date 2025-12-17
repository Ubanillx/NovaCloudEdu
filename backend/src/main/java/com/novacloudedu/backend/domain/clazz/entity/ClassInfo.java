package com.novacloudedu.backend.domain.clazz.entity;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ClassInfo {
    private ClassId id;
    private String className;
    private String description;
    private UserId creatorId;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private boolean isDelete;

    private ClassInfo() {}

    public static ClassInfo create(String className, String description, UserId creatorId) {
        ClassInfo classInfo = new ClassInfo();
        classInfo.className = className;
        classInfo.description = description;
        classInfo.creatorId = creatorId;
        classInfo.createTime = LocalDateTime.now();
        classInfo.updateTime = LocalDateTime.now();
        classInfo.isDelete = false;
        return classInfo;
    }

    public static ClassInfo reconstruct(ClassId id, String className, String description, UserId creatorId,
                                      LocalDateTime createTime, LocalDateTime updateTime, boolean isDelete) {
        ClassInfo classInfo = new ClassInfo();
        classInfo.id = id;
        classInfo.className = className;
        classInfo.description = description;
        classInfo.creatorId = creatorId;
        classInfo.createTime = createTime;
        classInfo.updateTime = updateTime;
        classInfo.isDelete = isDelete;
        return classInfo;
    }

    public void assignId(ClassId id) {
        this.id = id;
    }

    public void update(String className, String description) {
        if (className != null && !className.isBlank()) {
            this.className = className;
        }
        this.description = description;
        this.updateTime = LocalDateTime.now();
    }

    public void delete() {
        this.isDelete = true;
        this.updateTime = LocalDateTime.now();
    }
}

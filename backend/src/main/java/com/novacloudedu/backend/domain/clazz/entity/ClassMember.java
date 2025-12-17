package com.novacloudedu.backend.domain.clazz.entity;

import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassRole;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class ClassMember {
    private Long id;
    private ClassId classId;
    private UserId userId;
    private ClassRole role;
    private LocalDateTime joinTime;
    private boolean isDelete;

    private ClassMember() {}

    public static ClassMember create(ClassId classId, UserId userId, ClassRole role) {
        ClassMember member = new ClassMember();
        member.classId = classId;
        member.userId = userId;
        member.role = role;
        member.joinTime = LocalDateTime.now();
        member.isDelete = false;
        return member;
    }

    public static ClassMember reconstruct(Long id, ClassId classId, UserId userId, ClassRole role,
                                        LocalDateTime joinTime, boolean isDelete) {
        ClassMember member = new ClassMember();
        member.id = id;
        member.classId = classId;
        member.userId = userId;
        member.role = role;
        member.joinTime = joinTime;
        member.isDelete = isDelete;
        return member;
    }

    public void assignId(Long id) {
        this.id = id;
    }

    public void delete() {
        this.isDelete = true;
    }
}

package com.novacloudedu.backend.domain.clazz.repository;

import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import lombok.Value;

import java.util.List;
import java.util.Optional;

public interface ClassMemberRepository {
    ClassMember save(ClassMember member);
    
    void update(ClassMember member);
    
    List<ClassMember> findByClassId(ClassId classId);
    
    MemberPage findByClassId(ClassId classId, int pageNum, int pageSize);
    
    List<ClassMember> findByUserId(UserId userId);
    
    Optional<ClassMember> findByClassIdAndUserId(ClassId classId, UserId userId);
    
    void deleteByClassId(ClassId classId);
    
    void deleteByClassIdAndUserId(ClassId classId, UserId userId);

    @Value
    class MemberPage {
        List<ClassMember> list;
        long total;
        int pageNum;
        int pageSize;
    }
}

package com.novacloudedu.backend.interfaces.rest.clazz.assembler;

import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.interfaces.rest.clazz.dto.ClassMemberResponse;
import com.novacloudedu.backend.interfaces.rest.clazz.dto.ClassResponse;
import org.springframework.stereotype.Component;

@Component
public class ClassAssembler {

    public ClassResponse toClassResponse(ClassInfo classInfo) {
        if (classInfo == null) {
            return null;
        }
        ClassResponse response = new ClassResponse();
        response.setId(String.valueOf(classInfo.getId().getValue()));
        response.setClassName(classInfo.getClassName());
        response.setDescription(classInfo.getDescription());
        response.setCreatorId(String.valueOf(classInfo.getCreatorId().value()));
        response.setCreateTime(classInfo.getCreateTime());
        response.setUpdateTime(classInfo.getUpdateTime());
        return response;
    }

    public ClassMemberResponse toClassMemberResponse(ClassMember member) {
        if (member == null) {
            return null;
        }
        ClassMemberResponse response = new ClassMemberResponse();
        response.setId(String.valueOf(member.getId()));
        response.setClassId(String.valueOf(member.getClassId().getValue()));
        response.setUserId(String.valueOf(member.getUserId().value()));
        response.setRole(member.getRole().name());
        response.setJoinTime(member.getJoinTime());
        return response;
    }
}

package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.clazz.entity.ClassMember;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassRole;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassMemberPO;
import org.springframework.stereotype.Component;

@Component
public class ClassMemberConverter {

    public ClassMemberPO toPO(ClassMember domain) {
        if (domain == null) {
            return null;
        }
        ClassMemberPO po = new ClassMemberPO();
        po.setId(domain.getId());
        if (domain.getClassId() != null) {
            po.setClassId(domain.getClassId().getValue());
        }
        if (domain.getUserId() != null) {
            po.setUserId(domain.getUserId().value());
        }
        if (domain.getRole() != null) {
            po.setRole(domain.getRole().name());
        }
        po.setJoinTime(domain.getJoinTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }

    public ClassMember toDomain(ClassMemberPO po) {
        if (po == null) {
            return null;
        }
        return ClassMember.reconstruct(
                po.getId(),
                ClassId.of(po.getClassId()),
                UserId.of(po.getUserId()),
                ClassRole.fromString(po.getRole()),
                po.getJoinTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }
}

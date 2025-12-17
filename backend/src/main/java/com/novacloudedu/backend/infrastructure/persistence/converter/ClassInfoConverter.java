package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.clazz.entity.ClassInfo;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.ClassInfoPO;
import org.springframework.stereotype.Component;

@Component
public class ClassInfoConverter {

    public ClassInfoPO toPO(ClassInfo domain) {
        if (domain == null) {
            return null;
        }
        ClassInfoPO po = new ClassInfoPO();
        if (domain.getId() != null) {
            po.setId(domain.getId().getValue());
        }
        po.setClassName(domain.getClassName());
        po.setDescription(domain.getDescription());
        if (domain.getCreatorId() != null) {
            po.setCreatorId(domain.getCreatorId().value());
        }
        po.setCreateTime(domain.getCreateTime());
        po.setUpdateTime(domain.getUpdateTime());
        po.setIsDelete(domain.isDelete() ? 1 : 0);
        return po;
    }

    public ClassInfo toDomain(ClassInfoPO po) {
        if (po == null) {
            return null;
        }
        return ClassInfo.reconstruct(
                ClassId.of(po.getId()),
                po.getClassName(),
                po.getDescription(),
                UserId.of(po.getCreatorId()),
                po.getCreateTime(),
                po.getUpdateTime(),
                po.getIsDelete() != null && po.getIsDelete() == 1
        );
    }
}
